import std.stdio;
import std.file;
import std.array;
import std.typecons;

void main() {
    writefln("%d", part_one(3, 1));
    writefln("%d", part_two());
}

string[] get_grid(string fname) {
    auto fp = File(fname);
    auto grid = appender!(string[]);

    foreach(line; fp.byLine())
        grid.put(line.idup);

    fp.close();
    return grid.data;
}

int part_one(int _x, int _y) {
    auto grid = get_grid("input");

    int trees = 0;
    for (int y = 0, x = 0; y < grid.length; x += _x, y += _y)
        if (grid[y][x % grid[0].length] == '#') ++trees;

    return trees;
}

long part_two() {
    long mul = 1;

    Tuple!(int, int)[] xys = [
        tuple(1, 1),
        tuple(3, 1),
        tuple(5, 1),
        tuple(7, 1),
        tuple(1, 2)
    ];

    foreach(xy; xys)
        mul *= part_one(xy[0], xy[1]);
    return mul;
}
