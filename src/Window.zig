const Window = @This();
const Widget = @import("Widget.zig");

title: []const u8,
x: i32,
y: i32,
w: i32,
h: i32,
children: []Widget,

fn open() !void {}
fn close() !void {}

fn draw() !void {}
