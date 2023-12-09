const std = @import("std");
const mem = @import("std").mem; // will be used to compare bytes
const print = std.debug.print;
const io = std.io;

pub fn main() !void {
    var file = try std.fs.cwd().openFile("input", .{});
    defer file.close();
    var buf_reader = io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;

    const blue = 14;
    const red = 12;
    const green = 13;

    var sum: u32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var it = std.mem.split(u8, line, ":");
        var game_it = std.mem.split(u8, it.next().?, " ");
        _ = game_it.next(); // skip Game .
        const game = try std.fmt.parseInt(u32, game_it.next().?, 10);

        var sets_it = std.mem.split(u8, it.next().?, ";");
        var ok = true;
        while (sets_it.next()) |x| {
            var colors_it = std.mem.split(u8, x, ",");
            while (colors_it.next()) |y| {
                std.debug.print("{s}\n", .{y});

                const trimmed = std.mem.trimLeft(u8, y, " ");
                var values_it = std.mem.split(u8, trimmed, " ");
                const value = try std.fmt.parseInt(u32, values_it.next().?, 10);
                const color = values_it.next().?;
                if (std.mem.eql(u8, color, "red")) {
                    if (value > red)
                        ok = false;
                } else if (std.mem.eql(u8, color, "green")) {
                    if (value > green)
                        ok = false;
                } else if (std.mem.eql(u8, color, "blue")) {
                    if (value > blue)
                        ok = false;
                }
            }
        }

        if (ok)
            sum += game;
    }
    std.debug.print("{d}\n", .{sum}); // 1931
}
