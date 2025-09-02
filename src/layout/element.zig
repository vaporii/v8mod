const Color = @import("Color.zig");

pub const RootElement = struct {
    children: []Element,
    background_color: Color,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
};

pub const Element = struct {
    parent: union(enum) {
        root: *RootElement,
        element: *Element,
    },
    children: []Element,
    background_color: Color,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
};
