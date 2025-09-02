const std = @import("std");
const Elements = @import("element.zig");
const RenderCommand = @import("render_command.zig").RenderCommand;
const Layout = @This();

pub fn layout(root_element: Elements.RootElement, allocator: std.mem.Allocator) ![]RenderCommand {
    var elements = std.ArrayList(RenderCommand).init(allocator);
    try elements.append(RenderCommand{
        .rect = .{
            .background_color = root_element.background_color,
            .x = root_element.x,
            .y = root_element.y,
            .w = root_element.w,
            .h = root_element.h,
        },
    });

    return elements.toOwnedSlice();
}
