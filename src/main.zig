const Elements = @import("layout/element.zig");
const Layout = @import("layout/Layout.zig");
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

        const render_commands = try Layout.layout(.{
            .children = &[_]Elements.Element{},
            .background_color = .{
                .r = 100,
                .g = 100,
                .b = 100,
                .a = 255,
            },
            .w = @intCast(width),
            .h = @intCast(height),
            .x = 0,
            .y = 0,
        }, std.heap.page_allocator);

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

        // c.SDL_Delay(16);
    }

    c.SDL_DestroyWindow(window);
    c.SDL_Quit();
}
