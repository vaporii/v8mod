const std = @import("std");
const Elements = @import("element.zig");
const RenderCommand = @import("render_command.zig").RenderCommand;
const Layout = @This();

pub fn render(element: Elements.Element, allocator: std.mem.Allocator) ![]RenderCommand {
    var commands = std.ArrayList(RenderCommand).init(allocator);
    try commands.append(RenderCommand{
        .rect = .{
            .background_color = element.background_color,
            .x = element.x,
            .y = element.y,
            .w = element.w,
            .h = element.h,
        },
    });

    for (element.children) |child| {
        const children_slice = try render(child, allocator);
        defer allocator.free(children_slice);
        try commands.appendSlice(children_slice);
    }

    return commands.toOwnedSlice();
}

pub const Sizing = union(enum) {
    pub const FitSizing = struct {
        min_size: i32 = 0,
        max_size: i32 = std.math.maxInt(i32),
    };
    pub const FixedSizing = struct {
        size: i32 = 0,
    };
    pub const GrowSizing = struct {
        min_size: i32 = 0,
        max_size: i32 = std.math.maxInt(i32),
    };

    pub fn fit(options: FitSizing) Sizing {
        return Sizing{ .Fit = options };
    }
    pub fn fixed(size: i32) Sizing {
        return Sizing{ .Fixed = .{ .size = size } };
    }
    pub fn grow(options: GrowSizing) Sizing {
        return Sizing{ .Grow = options };
    }

    Fit: FitSizing,
    Fixed: FixedSizing,
    Grow: GrowSizing,
};

pub const Padding = struct {
    top: i32 = 0,
    right: i32 = 0,
    bottom: i32 = 0,
    left: i32 = 0,

    pub fn pad(up: i32, right: i32, down: i32, left: i32) Padding {
        return Padding{
            .top = up,
            .right = right,
            .bottom = down,
            .left = left,
        };
    }
};

pub const Alignment = enum {
    start,
    center,
    end,
};

pub const Justify = enum {
    start,
    center,
    end,
};

pub const LayoutType = enum {
    horizontal,
    vertical,
};
