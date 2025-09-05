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
    up: i32 = 0,
    right: i32 = 0,
    down: i32 = 0,
    left: i32 = 0,

    pub fn pad(up: i32, right: i32, down: i32, left: i32) Padding {
        return Padding{
            .up = up,
            .right = right,
            .down = down,
            .left = left,
        };
    }
};

pub const Margin = struct {
    up: i32 = 0,
    right: i32 = 0,
    down: i32 = 0,
    left: i32 = 0,

    pub fn margin(up: i32, right: i32, down: i32, left: i32) Margin {
        return Margin{
            .up = up,
            .right = right,
            .down = down,
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
