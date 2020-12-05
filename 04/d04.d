import std.stdio;
import std.file;
import std.array;
import std.algorithm;
import std.regex;

struct Passport {
    string[string] fields;
    string[string] regexes;

    this(string data) {
        auto pairs = data.split("\n")
            .join(" ")
            .split(" ")
            .map!(val => val.split(":"));

        foreach(p; pairs) {
            if (p.length == 0) continue;
            fields[p[0]] = p[1];
        }

        regexes = [
            "byr": r"^(19[2-9][0-9]|200[0-2])$",
            "iyr": r"^20(1[0-9]|20)$",
            "eyr": r"^20(2[0-9]|30)$",
            "hgt": r"^(59in|6[0-9]in|7[0-6]in|1[5-8][0-9]cm|19[0-3]cm)$",
            "hcl": r"^#[0-9a-f]{6}$",
            "ecl": r"^(amb|blu|brn|gry|grn|hzl|oth)$",
            "pid": r"^[0-9]{9}$"
        ];
    }

    bool valid_one() {
        foreach(key; regexes.byKey())
            if (!(key in fields))
                return false;

        return true;
    }

    bool valid_two() {
        foreach(key; regexes.byKey())
            if (!fields.get(key, "").matchFirst(regexes[key]))
                return false;

        return true;
    }
}

void main() {
    writefln("%d", part_one());
    writefln("%d", part_two());
}

int part_one() {
    auto passports = get_passports("input");

    int count = 0;
    foreach(passport; passports)
        if (passport.valid_one())
            ++count;

    return count;
}

int part_two() {
    auto passports = get_passports("input");

    int count = 0;
    foreach(passport; passports)
        if (passport.valid_two())
            ++count;

    return count;
}

Passport[] get_passports(string fname) {
    return readText(fname)
        .split("\n\n")
        .map!(data => Passport(data))
        .array;
}
