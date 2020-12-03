import std.stdio;
import std.file;
import std.array;
import std.conv;
import std.string;

struct Password {
    int    min;
    int    max;
    int    chr;
    string pwd;

    bool valid_one() {
        auto c = count(pwd, chr);
        return c >= min && c <= max;
    }

    bool valid_two() {
        int count = 0;

        if (min - 1 < pwd.length && pwd[min - 1] == chr) ++count;
        if (max - 1 < pwd.length && pwd[max - 1] == chr) ++count;

        return count == 1;
    }
}

void main() {
    writefln("%d", part_one());
    writefln("%d", part_two());
}

int part_one() {
    auto passwords = get_passwords("input");

    int count = 0;
    foreach(password; passwords) {
        if (password.valid_one()) ++count;
    }

    return count;
}

int part_two() {
    auto passwords = get_passwords("input");

    int count = 0;
    foreach(password; passwords) {
        if (password.valid_two()) ++count;
    }

    return count;
}

Password[] get_passwords(string fname) {
    auto fp = File(fname);
    auto a = appender!(Password[]);

    foreach(line; fp.byLine()) {
        a.put(Password(
            to!int(line.idup.split(" ")[0].split("-")[0]),
            to!int(line.idup.split(" ")[0].split("-")[1]),
            line.idup.split(" ")[1][0],
            line.idup.split(" ")[2]
        ));
    }

    fp.close();
    return a.data;
}
