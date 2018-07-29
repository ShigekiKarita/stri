module stri;

import std.format : format;
import std.algorithm : map;

auto extractIdentifiers(string s) {
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
        auto id = subs[2..$-ends.length]; // "def"
        ids ~= id; // [..., "def"]
        auto quote = subs[0..$+1-ends.length]; // "${def}"
        fmt = fmt.replace(quote, "%s");
        subs = ends.find("${"); // "${i}..."
    }
    return tuple!("ids", "fmt")(ids, fmt);
}

mixin template s(string sfmt) {
    enum _ret = extractIdentifiers(sfmt);
    mixin(format!`immutable str = format!"%s"(%-(%s, %));`(_ret.fmt, _ret.ids));
}

unittest
{
    import std.stdio;
    auto a = 1;
    enum _a0 = "D-lang";
    mixin s!"${a} is one. ${_a0} is nice. ${a}" i;
    assert(i.str == "1 is one. D-lang is nice. 1");
    writeln(i.str);
}
