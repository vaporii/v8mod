const Color = @This();

fn hexVal(c: u8) i32 {
    if (c >= '0' and c <= '9') return @intCast(c - '0');
    if (c >= 'a' and c <= 'f') return @intCast(c - 'a' + 10);
    if (c >= 'A' and c <= 'F') return @intCast(c - 'A' + 10);
    return -1;
}

fn pairToByte(high: u8, low: u8) i32 {
    const hi = hexVal(high);
    const lo = hexVal(low);
    if (hi < 0 or lo < 0) return -1;
    return hi * 16 + lo;
}

fn nibbleToByte(n: u8) i32 {
    const v = hexVal(n);
    if (v < 0) return -1;
    return v * 17;
}

pub fn fromHex(hex: []const u8) Color {
    var s = hex;
    if (s.len == 0) return Color{ .r = 0, .g = 0, .b = 0, .a = 255 };

    if (s[0] == '#') s = s[1..];

    var r: i32 = -1;
    var g: i32 = -1;
    var b: i32 = -1;
    var a: i32 = 255;

    switch (s.len) {
        3 => {
            r = nibbleToByte(s[0]);
            g = nibbleToByte(s[1]);
            b = nibbleToByte(s[2]);
        },
        4 => {
            r = nibbleToByte(s[0]);
            g = nibbleToByte(s[1]);
            b = nibbleToByte(s[2]);
            a = nibbleToByte(s[3]);
        },
        6 => {
            r = pairToByte(s[0], s[1]);
            g = pairToByte(s[2], s[3]);
            b = pairToByte(s[4], s[5]);
        },
        8 => {
            r = pairToByte(s[0], s[1]);
            g = pairToByte(s[2], s[3]);
            b = pairToByte(s[4], s[5]);
            a = pairToByte(s[6], s[7]);
        },
        else => {
            return Color{ .r = 0, .g = 0, .b = 0, .a = 255 };
        },
    }

    if (r < 0 or g < 0 or b < 0 or a < 0) {
        return Color{ .r = 0, .g = 0, .b = 0, .a = 255 };
    }

    return Color{
        .r = @intCast(r),
        .g = @intCast(g),
        .b = @intCast(b),
        .a = @intCast(a),
    };
}

pub const indian_red = Color{ .r = 205, .g = 92, .b = 92, .a = 255 };
pub const light_coral = Color{ .r = 240, .g = 128, .b = 128, .a = 255 };
pub const salmon = Color{ .r = 250, .g = 128, .b = 114, .a = 255 };
pub const dark_salmon = Color{ .r = 233, .g = 150, .b = 122, .a = 255 };
pub const light_salmon = Color{ .r = 255, .g = 160, .b = 122, .a = 255 };
pub const crimson = Color{ .r = 220, .g = 20, .b = 60, .a = 255 };
pub const red = Color{ .r = 255, .g = 0, .b = 0, .a = 255 };
pub const fire_brick = Color{ .r = 178, .g = 34, .b = 34, .a = 255 };
pub const dark_red = Color{ .r = 139, .g = 0, .b = 0, .a = 255 };

pub const pink = Color{ .r = 255, .g = 192, .b = 203, .a = 255 };
pub const light_pink = Color{ .r = 255, .g = 182, .b = 193, .a = 255 };
pub const hot_pink = Color{ .r = 255, .g = 105, .b = 180, .a = 255 };
pub const deep_pink = Color{ .r = 255, .g = 20, .b = 147, .a = 255 };
pub const medium_violet_red = Color{ .r = 199, .g = 21, .b = 133, .a = 255 };
pub const pale_violet_red = Color{ .r = 219, .g = 112, .b = 147, .a = 255 };

pub const coral = Color{ .r = 255, .g = 127, .b = 80, .a = 255 };
pub const tomato = Color{ .r = 255, .g = 99, .b = 71, .a = 255 };
pub const orange_red = Color{ .r = 255, .g = 69, .b = 0, .a = 255 };
pub const dark_orange = Color{ .r = 255, .g = 140, .b = 0, .a = 255 };
pub const orange = Color{ .r = 255, .g = 165, .b = 0, .a = 255 };

pub const gold = Color{ .r = 255, .g = 215, .b = 0, .a = 255 };
pub const yellow = Color{ .r = 255, .g = 255, .b = 0, .a = 255 };
pub const light_yellow = Color{ .r = 255, .g = 255, .b = 224, .a = 255 };
pub const lemon_chiffon = Color{ .r = 255, .g = 250, .b = 205, .a = 255 };
pub const light_goldenrod_yellow = Color{ .r = 250, .g = 250, .b = 210, .a = 255 };
pub const papaya_whip = Color{ .r = 255, .g = 239, .b = 213, .a = 255 };
pub const moccasin = Color{ .r = 255, .g = 228, .b = 181, .a = 255 };
pub const peach_puff = Color{ .r = 255, .g = 218, .b = 185, .a = 255 };
pub const pale_goldenrod = Color{ .r = 238, .g = 232, .b = 170, .a = 255 };
pub const khaki = Color{ .r = 240, .g = 230, .b = 140, .a = 255 };
pub const dark_khaki = Color{ .r = 189, .g = 183, .b = 107, .a = 255 };

pub const lavender = Color{ .r = 230, .g = 230, .b = 250, .a = 255 };
pub const thistle = Color{ .r = 216, .g = 191, .b = 216, .a = 255 };
pub const plum = Color{ .r = 221, .g = 160, .b = 221, .a = 255 };
pub const violet = Color{ .r = 238, .g = 130, .b = 238, .a = 255 };
pub const orchid = Color{ .r = 218, .g = 112, .b = 214, .a = 255 };
pub const fuchsia = Color{ .r = 255, .g = 0, .b = 255, .a = 255 };
pub const magenta = Color{ .r = 255, .g = 0, .b = 255, .a = 255 };
pub const medium_orchid = Color{ .r = 186, .g = 85, .b = 211, .a = 255 };
pub const medium_purple = Color{ .r = 147, .g = 112, .b = 219, .a = 255 };
pub const blue_violet = Color{ .r = 138, .g = 43, .b = 226, .a = 255 };
pub const dark_violet = Color{ .r = 148, .g = 0, .b = 211, .a = 255 };
pub const dark_orchid = Color{ .r = 153, .g = 50, .b = 204, .a = 255 };
pub const dark_magenta = Color{ .r = 139, .g = 0, .b = 139, .a = 255 };
pub const purple = Color{ .r = 128, .g = 0, .b = 128, .a = 255 };
pub const rebecca_purple = Color{ .r = 102, .g = 51, .b = 153, .a = 255 };
pub const indigo = Color{ .r = 75, .g = 0, .b = 130, .a = 255 };
pub const medium_slate_blue = Color{ .r = 123, .g = 104, .b = 238, .a = 255 };
pub const slate_blue = Color{ .r = 106, .g = 90, .b = 205, .a = 255 };
pub const dark_slate_blue = Color{ .r = 72, .g = 61, .b = 139, .a = 255 };

pub const green_yellow = Color{ .r = 173, .g = 255, .b = 47, .a = 255 };
pub const chartreuse = Color{ .r = 127, .g = 255, .b = 0, .a = 255 };
pub const lawn_green = Color{ .r = 124, .g = 252, .b = 0, .a = 255 };
pub const lime = Color{ .r = 0, .g = 255, .b = 0, .a = 255 };
pub const lime_green = Color{ .r = 50, .g = 205, .b = 50, .a = 255 };
pub const pale_green = Color{ .r = 152, .g = 251, .b = 152, .a = 255 };
pub const light_green = Color{ .r = 144, .g = 238, .b = 144, .a = 255 };
pub const medium_spring_green = Color{ .r = 0, .g = 250, .b = 154, .a = 255 };
pub const spring_green = Color{ .r = 0, .g = 255, .b = 127, .a = 255 };
pub const medium_sea_green = Color{ .r = 60, .g = 179, .b = 113, .a = 255 };
pub const sea_green = Color{ .r = 46, .g = 139, .b = 87, .a = 255 };
pub const forest_green = Color{ .r = 34, .g = 139, .b = 34, .a = 255 };
pub const green = Color{ .r = 0, .g = 128, .b = 0, .a = 255 };
pub const dark_green = Color{ .r = 0, .g = 100, .b = 0, .a = 255 };
pub const yellow_green = Color{ .r = 154, .g = 205, .b = 50, .a = 255 };
pub const olive_drab = Color{ .r = 107, .g = 142, .b = 35, .a = 255 };
pub const olive = Color{ .r = 128, .g = 128, .b = 0, .a = 255 };
pub const dark_olive_green = Color{ .r = 85, .g = 107, .b = 47, .a = 255 };
pub const medium_aquamarine = Color{ .r = 102, .g = 205, .b = 170, .a = 255 };
pub const dark_sea_green = Color{ .r = 143, .g = 188, .b = 143, .a = 255 };
pub const light_sea_green = Color{ .r = 32, .g = 178, .b = 170, .a = 255 };
pub const dark_cyan = Color{ .r = 0, .g = 139, .b = 139, .a = 255 };
pub const teal = Color{ .r = 0, .g = 128, .b = 128, .a = 255 };

pub const aqua = Color{ .r = 0, .g = 255, .b = 255, .a = 255 };
pub const cyan = Color{ .r = 0, .g = 255, .b = 255, .a = 255 };
pub const light_cyan = Color{ .r = 224, .g = 255, .b = 255, .a = 255 };
pub const pale_turquoise = Color{ .r = 175, .g = 238, .b = 238, .a = 255 };
pub const aquamarine = Color{ .r = 127, .g = 255, .b = 212, .a = 255 };
pub const turquoise = Color{ .r = 64, .g = 224, .b = 208, .a = 255 };
pub const medium_turquoise = Color{ .r = 72, .g = 209, .b = 204, .a = 255 };
pub const dark_turquoise = Color{ .r = 0, .g = 206, .b = 209, .a = 255 };
pub const cadet_blue = Color{ .r = 95, .g = 158, .b = 160, .a = 255 };
pub const steel_blue = Color{ .r = 70, .g = 130, .b = 180, .a = 255 };
pub const light_steel_blue = Color{ .r = 176, .g = 196, .b = 222, .a = 255 };
pub const powder_blue = Color{ .r = 176, .g = 224, .b = 230, .a = 255 };
pub const light_blue = Color{ .r = 173, .g = 216, .b = 230, .a = 255 };
pub const sky_blue = Color{ .r = 135, .g = 206, .b = 235, .a = 255 };
pub const light_sky_blue = Color{ .r = 135, .g = 206, .b = 250, .a = 255 };
pub const deep_sky_blue = Color{ .r = 0, .g = 191, .b = 255, .a = 255 };
pub const dodger_blue = Color{ .r = 30, .g = 144, .b = 255, .a = 255 };
pub const cornflower_blue = Color{ .r = 100, .g = 149, .b = 237, .a = 255 };
pub const royal_blue = Color{ .r = 65, .g = 105, .b = 225, .a = 255 };
pub const blue = Color{ .r = 0, .g = 0, .b = 255, .a = 255 };
pub const medium_blue = Color{ .r = 0, .g = 0, .b = 205, .a = 255 };
pub const dark_blue = Color{ .r = 0, .g = 0, .b = 139, .a = 255 };
pub const navy = Color{ .r = 0, .g = 0, .b = 128, .a = 255 };
pub const midnight_blue = Color{ .r = 25, .g = 25, .b = 112, .a = 255 };

pub const cornsilk = Color{ .r = 255, .g = 248, .b = 220, .a = 255 };
pub const blanched_almond = Color{ .r = 255, .g = 235, .b = 205, .a = 255 };
pub const bisque = Color{ .r = 255, .g = 228, .b = 196, .a = 255 };
pub const navajo_white = Color{ .r = 255, .g = 222, .b = 173, .a = 255 };
pub const wheat = Color{ .r = 245, .g = 222, .b = 179, .a = 255 };
pub const burly_wood = Color{ .r = 222, .g = 184, .b = 135, .a = 255 };
pub const tan = Color{ .r = 210, .g = 180, .b = 140, .a = 255 };
pub const rosy_brown = Color{ .r = 188, .g = 143, .b = 143, .a = 255 };
pub const sandy_brown = Color{ .r = 244, .g = 164, .b = 96, .a = 255 };
pub const goldenrod = Color{ .r = 218, .g = 165, .b = 32, .a = 255 };
pub const dark_goldenrod = Color{ .r = 184, .g = 134, .b = 11, .a = 255 };
pub const peru = Color{ .r = 205, .g = 133, .b = 63, .a = 255 };
pub const chocolate = Color{ .r = 210, .g = 105, .b = 30, .a = 255 };
pub const saddle_brown = Color{ .r = 139, .g = 69, .b = 19, .a = 255 };
pub const sienna = Color{ .r = 160, .g = 82, .b = 45, .a = 255 };
pub const brown = Color{ .r = 165, .g = 42, .b = 42, .a = 255 };
pub const maroon = Color{ .r = 128, .g = 0, .b = 0, .a = 255 };

pub const white = Color{ .r = 255, .g = 255, .b = 255, .a = 255 };
pub const snow = Color{ .r = 255, .g = 250, .b = 250, .a = 255 };
pub const honeydew = Color{ .r = 240, .g = 255, .b = 240, .a = 255 };
pub const mint_cream = Color{ .r = 245, .g = 255, .b = 250, .a = 255 };
pub const azure = Color{ .r = 240, .g = 255, .b = 255, .a = 255 };
pub const alice_blue = Color{ .r = 240, .g = 248, .b = 255, .a = 255 };
pub const ghost_white = Color{ .r = 248, .g = 248, .b = 255, .a = 255 };
pub const white_smoke = Color{ .r = 245, .g = 245, .b = 245, .a = 255 };
pub const seashell = Color{ .r = 255, .g = 245, .b = 238, .a = 255 };
pub const beige = Color{ .r = 245, .g = 245, .b = 220, .a = 255 };
pub const old_lace = Color{ .r = 253, .g = 245, .b = 230, .a = 255 };
pub const floral_white = Color{ .r = 255, .g = 250, .b = 240, .a = 255 };
pub const ivory = Color{ .r = 255, .g = 255, .b = 240, .a = 255 };
pub const antique_white = Color{ .r = 250, .g = 235, .b = 215, .a = 255 };
pub const linen = Color{ .r = 250, .g = 240, .b = 230, .a = 255 };
pub const lavender_blush = Color{ .r = 255, .g = 240, .b = 245, .a = 255 };
pub const misty_rose = Color{ .r = 255, .g = 228, .b = 225, .a = 255 };

pub const gainsboro = Color{ .r = 220, .g = 220, .b = 220, .a = 255 };
pub const light_gray = Color{ .r = 211, .g = 211, .b = 211, .a = 255 };
pub const light_grey = Color{ .r = 211, .g = 211, .b = 211, .a = 255 };
pub const silver = Color{ .r = 192, .g = 192, .b = 192, .a = 255 };
pub const dark_gray = Color{ .r = 169, .g = 169, .b = 169, .a = 255 };
pub const dark_grey = Color{ .r = 169, .g = 169, .b = 169, .a = 255 };
pub const gray = Color{ .r = 128, .g = 128, .b = 128, .a = 255 };
pub const grey = Color{ .r = 128, .g = 128, .b = 128, .a = 255 };
pub const dim_gray = Color{ .r = 105, .g = 105, .b = 105, .a = 255 };
pub const dim_grey = Color{ .r = 105, .g = 105, .b = 105, .a = 255 };
pub const light_slate_gray = Color{ .r = 119, .g = 136, .b = 153, .a = 255 };
pub const light_slate_grey = Color{ .r = 119, .g = 136, .b = 153, .a = 255 };
pub const slate_gray = Color{ .r = 112, .g = 128, .b = 144, .a = 255 };
pub const slate_grey = Color{ .r = 112, .g = 128, .b = 144, .a = 255 };
pub const dark_slate_gray = Color{ .r = 47, .g = 79, .b = 79, .a = 255 };
pub const dark_slate_grey = Color{ .r = 47, .g = 79, .b = 79, .a = 255 };
pub const black = Color{ .r = 0, .g = 0, .b = 0, .a = 255 };

r: u8,
g: u8,
b: u8,
a: u8,
