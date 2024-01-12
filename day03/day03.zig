// read data from input.txt
const std = @import("std");

pub fn main() !void {
    const input = @embedFile("input.txt");
    var lines = std.mem.split(u8, input, "\n");
    const line_count = 140;
    const line_len = 142;
    // create grid, 2d array of line_count * line_len
    var grid = std.mem.zeroes([line_count + 2][line_len + 2]u8);
    var num_grid = std.mem.zeroes([line_count][line_len]u8);
    // iter every char, line by line
    {
        var i: usize = 0;
        while (lines.next()) |line| {
            for (0.., line) |j, c| {
                if (c >= '0' and c <= '9') {
                    num_grid[i][j] = c;
                } else if (c != '.') {
                    grid[i][j] = 1;
                    grid[i][j + 1] = 1;
                    grid[i][j + 2] = 1;
                    grid[i + 1][j] = 1;
                    grid[i + 1][j + 1] = 1;
                    grid[i + 1][j + 2] = 1;
                    grid[i + 2][j] = 1;
                    grid[i + 2][j + 1] = 1;
                    grid[i + 2][j + 2] = 1;
                }
            }
            i += 1;
        }
    }

    var result: usize = 0;
    var accumulated: usize = 0;
    for (0.., grid) |i, line| {
        for (0.., line) |j, flag| {
            var cond = i == 0 or j == 0 or i == line_count + 1 or j == line_len + 1;
            var number_ascii: usize = 0;
            if (!cond) {
                number_ascii = num_grid[i - 1][j - 1];
                if (number_ascii == 0) {
                    cond = true;
                }
            }
            if (cond) {
                if (accumulated != 0) {
                    std.debug.print("{}, ", .{accumulated});
                    result += accumulated;
                    accumulated = 0;
                    continue;
                }
            } else if (flag == 1 or accumulated != 0) {
                if (accumulated == 0) {
                    var k = j;
                    while (k > 1 and num_grid[i - 1][k - 1] != 0) {
                        k -= 1;
                    }
                    k += 1;
                    while (k <= j) {
                        accumulated *= 10;
                        number_ascii = num_grid[i - 1][k - 1];
                        accumulated += number_ascii - '0';
                        k += 1;
                    }
                } else {
                    number_ascii -= '0';
                    accumulated *= 10;
                    accumulated += number_ascii;
                }
            }
        }
    }
    result += accumulated;
    std.debug.print("result: {}\n", .{result});
}
