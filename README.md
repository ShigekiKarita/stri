# stri: string interpolation library for D

[![Dub version](https://img.shields.io/dub/v/stri.svg)](https://code.dlang.org/packages/stri)


D language library emulates [Scala's string interpolation](https://docs.scala-lang.org/overviews/core/string-interpolation.html).

## how to use

```d
import std.stdio;
import stri : s;

auto a = 1;
enum _a0 = "D-lang";
mixin s!"${a} is one. ${_a0} is nice. ${a}" i;
assert(i.str == "1 is one. D-lang is nice. 1");
writeln(i.str);
```

## todo

- custom formatter like `%f2.2` instead of default `%s`
