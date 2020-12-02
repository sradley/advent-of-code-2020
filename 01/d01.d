import std.stdio;
import std.file;
import std.array;
import std.conv;

void main() {
    writefln("%d", part_one());
    writefln("%d", part_two());
}

int part_one() {
    auto nums = get_nums("input");

    for (int i = 0; i < nums.length; ++i) {
        for (int j = 0; j < nums.length; ++j) {
            if (i == j)
                continue;

            if (nums[i] + nums[j] == 2020)
                return nums[i] * nums[j];
        }
    }

    return 0;
}

int part_two() {
    auto nums = get_nums("input");

    for (int i = 0; i < nums.length; ++i) {
        for (int j = 0; j < nums.length; ++j) {
            if (i == j) continue;

            for (int k = 0; k < nums.length; ++k) {
                if (i == k || j == k) continue;

                if (nums[i] + nums[j] + nums[k] == 2020)
                    return nums[i] * nums[j] * nums[k];
            }
        }
    }

    return 0;
}

int[] get_nums(string fname) {
    auto fp = File(fname);
    auto a = appender!(int[]);

    foreach(line; fp.byLine()) {
        a.put(to!int(line.idup));
    }

    fp.close();
    return a.data;
}
