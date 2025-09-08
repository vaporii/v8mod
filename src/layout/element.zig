const Layout = @import("Layout.zig");
const Color = @import("Color.zig");

pub const ElementOptions = struct {
    background_color: Color = Color.black,
    padding: Layout.Padding = Layout.Padding.pad(0, 0, 0, 0),
    width: Layout.Sizing = Layout.Sizing.fit(.{}),
    height: Layout.Sizing = Layout.Sizing.fit(.{}),
    layout: Layout.LayoutType = .horizontal,
    alignment: Layout.Alignment = .start,
    justify: Layout.Justify = .start,
    children: []const Element = &.{},
    child_gap: i32 = 0,
};

pub const Element = struct {
    // parent: ?*Element = null,
    children: []Element,
    background_color: Color,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    padding: Layout.Padding,
    width: Layout.Sizing,
    height: Layout.Sizing,
    layout: Layout.LayoutType,
    child_gap: i32,

    pub fn create(options: ElementOptions) Element {
        const children: []Element = @constCast(options.children);

        var element = Element{
            .children = children,
            .background_color = options.background_color,
            .x = 0,
            .y = 0,
            .w = 0,
            .h = 0,
            .padding = options.padding,
            .width = options.width,
            .height = options.height,
            .layout = options.layout,
            .child_gap = options.child_gap,
        };

        const child_gap = if (element.children.len > 0) (@as(i32, @intCast(element.children.len - 1)) * element.child_gap) else 0;

        if (element.layout == .horizontal) {
            element.w += child_gap;
        } else {
            element.h += child_gap;
        }

        switch (element.width) {
            .Fit => {
                for (element.children) |*child| {
                    if (element.layout == .horizontal) {
                        element.w += child.w;
                    } else {
                        element.w = @max(element.w, child.w);
                    }
                }
            },
            .Fixed => {
                element.w += element.width.Fixed.size;
            },
            else => {},
        }

        switch (element.height) {
            .Fit => {
                for (element.children) |*child| {
                    if (element.layout == .horizontal) {
                        element.h = @max(element.h, child.h);
                    } else {
                        element.h += child.h;
                    }
                }
            },
            .Fixed => {
                element.h += element.height.Fixed.size;
            },
            else => {},
        }

        element.w += element.padding.left + element.padding.right;
        element.h += element.padding.top + element.padding.bottom;

        return element;
    }

    pub fn calculatePositions(self: *Element) void {
        var cursor_x: i32 = self.x + self.padding.left;
        var cursor_y: i32 = self.y + self.padding.top;

        switch (self.layout) {
            .horizontal => {
                for (self.children) |*child| {
                    child.x = cursor_x;
                    child.y = cursor_y;

                    cursor_x += child.w + self.child_gap;

                    child.calculatePositions();
                }
            },
            .vertical => {
                for (self.children) |*child| {
                    child.x = cursor_x;
                    child.y = cursor_y;

                    cursor_y += child.h + self.child_gap;

                    child.calculatePositions();
                }
            },
        }
    }

    pub fn growElements(self: *Element) void {
        var remaining_width = self.w - (self.padding.left + self.padding.right);
        var remaining_height = self.h - (self.padding.top + self.padding.bottom);

        if (self.layout == .horizontal) {
            for (self.children) |*child| {
                remaining_width -= child.w;
            }
            remaining_width -= if (self.children.len > 0) (@as(i32, @intCast(self.children.len - 1)) * self.child_gap) else 0;

            for (self.children) |*child| {
                if (child.width == .Grow) {
                    child.w += remaining_width;
                }
                if (child.height == .Grow) {
                    child.h += (remaining_height - child.h);
                }
                growElements(child);
            }
        } else if (self.layout == .vertical) {
            for (self.children) |*child| {
                remaining_height -= child.h;
            }
            remaining_height -= if (self.children.len > 0) (@as(i32, @intCast(self.children.len - 1)) * self.child_gap) else 0;

            for (self.children) |*child| {
                if (child.height == .Grow) {
                    child.h += remaining_height;
                }
                if (child.width == .Grow) {
                    child.w += (remaining_width - child.w);
                }
                growElements(child);
            }
        }
    }
};
