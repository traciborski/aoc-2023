const std = @import("std");
const print = std.debug.print;
const io = std.io;

pub fn main() !void {
    var file = try std.fs.cwd().openFile("input", .{});
    defer file.close();
    var buf_reader = io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;

    var sum: u32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var it = std.mem.split(u8, line, ":");
        var game_it = std.mem.split(u8, it.next().?, " ");
        _ = game_it.next(); // skip Game .
        const game = try std.fmt.parseInt(u32, game_it.next().?, 10);
        _ = game;

        var sets_it = std.mem.split(u8, it.next().?, ";");

        var blue: u32 = 0;
        var red: u32 = 0;
        var green: u32 = 0;

        while (sets_it.next()) |x| {
            var colors_it = std.mem.split(u8, x, ",");
            while (colors_it.next()) |y| {
                const trimmed = std.mem.trimLeft(u8, y, " ");
                var values_it = std.mem.split(u8, trimmed, " ");
                const value = try std.fmt.parseInt(u32, values_it.next().?, 10);
                const color = values_it.next().?;

                if (std.mem.eql(u8, color, "red")) {
                    if (value > red)
                        red = value;
                } else if (std.mem.eql(u8, color, "green")) {
                    if (value > green)
                        green = value;
                } else if (std.mem.eql(u8, color, "blue")) {
                    if (value > blue)
                        blue = value;
                }
            }
        }

        sum += red * blue * green;
    }
    std.debug.print("{d}\n", .{sum});
}
