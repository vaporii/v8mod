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

    var running = true;
    while (running) {
        var event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&event)) {
            if (event.type == c.SDL_EVENT_QUIT) {
                running = false;
            }
        }

        _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
        _ = c.SDL_RenderClear(renderer);
        _ = c.SDL_RenderPresent(renderer);

        // c.SDL_Delay(16);
    }

    c.SDL_DestroyWindow(window);
    c.SDL_Quit();
}
