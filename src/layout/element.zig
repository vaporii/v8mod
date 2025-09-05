const Layout = @import("Layout.zig");
const Color = @import("Color.zig");

pub const RootElementOptions = struct {
    background_color: Color = Color.black,
    children: []const Element = &.{},
    padding: Layout.Padding = Layout.Padding.pad(0, 0, 0, 0),
    // properties like "resizable" are up to SDL3. not specified here
};

pub const RootElement = struct {
    children: []const Element,
    background_color: Color,
    x: i32,
    y: i32,
    w: i32,
    h: i32,

    pub fn init(_: RootElementOptions) RootElement {
        return undefined;
    }
};

pub const ElementOptions = struct {
    background_color: Color = Color.black,
    padding: Layout.Padding = Layout.Padding.pad(0, 0, 0, 0),
    margin: Layout.Margin = Layout.Margin.margin(0, 0, 0, 0),
    width: Layout.Sizing = Layout.Sizing.fit(.{}),
    height: Layout.Sizing = Layout.Sizing.fit(.{}),
    layout: Layout.LayoutType = .horizontal,
    alignment: Layout.Alignment = .start,
    justify: Layout.Justify = .start,
    children: []const Element = &.{},
};

pub const Element = struct {
    parent: union(enum) {
        root: *RootElement,
        element: *Element,
    },
    children: []const Element,
    background_color: Color,
    x: i32,
    y: i32,
    w: i32,
    h: i32,

    pub fn create(_: ElementOptions) Element {
        return undefined;
    }
};
