const Color = @import("Color.zig");

pub const RenderCommand = union(enum) {
    rect: struct {
        x: i32,
        y: i32,
        w: i32,
        h: i32,
        background_color: Color,
    },
};
