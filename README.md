# stri: string interpolation library for D

[![Dub version](https://img.shields.io/dub/v/stri.svg)](https://code.dlang.org/packages/stri)


D language library emulates [Scala's string interpolation](https://docs.scala-lang.org/overviews/core/string-interpolation.html).

## how to use

```d
import stri : s;

# runtime/compile-time variables
auto a = 1;
enum _a0 = "D-lang";
struct A {
    static a = 0.123;
}

# you can use the default %s and custom format e.g., %03d
mixin s!"${a} is one. ${_a0} is nice. ${a%03d}, ${A.a%.3f}" i;
assert(i.str == "1 is one. D-lang is nice. 001");
```
