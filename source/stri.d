module stri;

import std.format : format;
import std.algorithm : map;

auto parse(string s) {
    import std.string;
    import std.algorithm : find;
    import std.typecons;

    string fmt = s;
    string[] ids;
    auto subs = s.find("${"); // "${def}gh${i}..."
    while (!subs.empty) {
        auto ends = subs.find("}"); // "}gh${i}..."
        if (ends.empty) {
            // TODO assert here
            break;
        }
        auto _id = subs[2..$-ends.length]; // "def"
        auto idFmt = _id.find("%");
        auto id = _id[0 .. $-idFmt.length];
        ids ~= id; // [..., "def"]
        auto quote = subs[0..$+1-ends.length]; // "${def}"
        fmt = fmt.replace(quote, idFmt.empty ? "%s" : idFmt);
        subs = ends.find("${"); // "${i}..."
    }
    return tuple!("ids", "fmt")(ids, fmt);
}

mixin template s(string sfmt) {
    enum _ret = parse(sfmt);
    mixin(format!`immutable str = format!"%s"(%-(%s, %));`(_ret.fmt, _ret.ids));
}

unittest
{
    import std.stdio;
    auto a = 1;
    struct A {
        static a = 0.123;
    }

    enum _a0 = "D-lang";
    mixin s!"${a} is one. ${_a0} is nice. ${a%03d}, ${A.a%.3f}" i;
    writeln(i.str);
    assert(i.str == "1 is one. D-lang is nice. 001, 0.123");
}
