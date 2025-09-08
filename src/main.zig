const Elements = @import("layout/element.zig");
const Layout = @import("layout/Layout.zig");
const Color = @import("layout/Color.zig");
const std = @import("std");
const c = @import("c.zig").c;

pub fn main() !void {
    if (!c.SDL_Init(c.SDL_INIT_VIDEO)) {
        c.SDL_Log("failed to initialize SDL: %s", c.SDL_GetError());
        return error.SDLFailInit;
    }

    const windowOp: ?*c.SDL_Window = c.SDL_CreateWindow("window", 500, 500, c.SDL_WINDOW_RESIZABLE);
    if (windowOp == null) {
        c.SDL_Log("failed to create window: %s", c.SDL_GetError());
        c.SDL_Quit();
        return error.SDLFailCreateWindow;
    }
    const window: *c.SDL_Window = windowOp.?;

    const renderer = c.SDL_CreateRenderer(window, null);
    if (renderer == null) {
        c.SDL_Log("failed to create renderer: %s", c.SDL_GetError());
        c.SDL_DestroyWindow(window);
        c.SDL_Quit();
        return error.SDLFailCreateRenderer;
    }

    var width: c_int = undefined;
    var height: c_int = undefined;

    var time: f64 = 0.0;
    var running = true;
    while (running) {
        _ = c.SDL_GetWindowSizeInPixels(window, &width, &height);

        var event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&event)) {
            if (event.type == c.SDL_EVENT_QUIT) {
                running = false;
            }
            if (event.type == c.SDL_EVENT_WINDOW_RESIZED) {
                width = event.window.data1;
                height = event.window.data2;
            }
        }

        // const layout = Elements.Element.create(.{
        //     .width = Layout.Sizing.grow(.{}),
        //     .height = Layout.Sizing.grow(.{}),
        //     .background_color = Color.black,
        //     .children = &.{
        //         Elements.Element.create(.{
        //             .width = Layout.Sizing.fit(.{}),
        //             .height = Layout.Sizing.fit(.{}),
        //             .padding = Layout.Padding.pad(10, 10, 10, 10),
        //             .layout = .horizontal,
        //             .alignment = .end, // start (' ' ), center (- - ), end (. . )
        //             .justify = .center, // start (= =  ), center ( = = ), end (  = =) (only has an effect if children length along axis < parent length along axis)
        //             .background_color = Color.dark_magenta,
        //             .children = &.{
        //                 Elements.Element.create(.{
        //                     .width = Layout.Sizing.fixed(200),
        //                     .height = Layout.Sizing.fixed(200),
        //                     .background_color = Color.lavender,
        //                     .margin = Layout.Margin.margin(0, 10, 0, 0),
        //                 }),
        //                 Elements.Element.create(.{
        //                     .width = Layout.Sizing.grow(.{ .max_size = 500 }),
        //                     .height = Layout.Sizing.grow(.{}),
        //                     .background_color = Color.cyan,
        //                 }),
        //             },
        //         }),
        //     },
        // });

        var layout = Elements.Element.create(.{
            .background_color = Color.white,
            .width = .fixed(@intCast(width)),
            .height = .fixed(@intCast(height)),
            .children = &.{
                Elements.Element.create(.{
                    .width = .grow(.{}),
                    .height = .grow(.{}),
                    .background_color = Color.blue,
                    .padding = .pad(25, 25, 25, 25),
                    .child_gap = 25,
                    .layout = .horizontal,
                    .children = &.{
                        Elements.Element.create(.{
                            .width = .fixed(200),
                            .height = .fixed(200),
                            .background_color = Color.pink,
                        }),
                        Elements.Element.create(.{
                            .width = .grow(.{}),
                            .height = .grow(.{}),
                            .background_color = Color.yellow,
                        }),
                        Elements.Element.create(.{
                            .width = .fixed(200),
                            .height = .fixed(200),
                            .background_color = Color.light_blue,
                        }),
                    },
                }),
                // Elements.Element.create(.{
                //     .width = .fixed(300),
                //     .height = .fixed(100),
                //     .background_color = Color.light_gray,
                // }),
            },
        });
        layout.growElements();
        layout.calculatePositions();
        // _ = layout;

        const render_commands = try Layout.render(layout, std.heap.page_allocator);
        defer std.heap.page_allocator.free(render_commands);

        _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
        _ = c.SDL_RenderClear(renderer);

        for (render_commands) |command| {
            switch (command) {
                .rect => {
                    _ = c.SDL_SetRenderDrawColor(
                        renderer,
                        command.rect.background_color.r,
                        command.rect.background_color.g,
                        command.rect.background_color.b,
                        command.rect.background_color.a,
                    );
                    _ = c.SDL_RenderFillRect(renderer, &c.SDL_FRect{
                        .x = @floatFromInt(command.rect.x),
                        .y = @floatFromInt(command.rect.y),
                        .w = @floatFromInt(command.rect.w),
                        .h = @floatFromInt(command.rect.h),
                    });
                },
            }
        }
        _ = c.SDL_RenderPresent(renderer);

        time += 1;
        c.SDL_Delay(16);
    }

    c.SDL_DestroyWindow(window);
    c.SDL_Quit();
}
