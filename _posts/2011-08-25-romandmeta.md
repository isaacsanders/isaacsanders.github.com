---
layout: blog_post
title: MetaProg and Ruby Object Model
archive: true
---

### Preface

After watching the first few episodes of Dave Thomas's screencast
on the ROM and MP, I have had a revolution in the way that I see
different structures in Ruby. Everything from eigenclasses to si
ngleton methods, to modules, mixins, and prototypes, to bindings,
blocks, and method-defining methods, are now available to me. These
are all important things for metaprogramming in Ruby, and in other
OO languages.

### Class Warfare

This summer, I have been exposed to a lot of code. In most of the
code I have seen, most has been from a strong class-oriented
perspective. The classes are in control, but I am not so sure about
use of classes from a OO POV. Classes are just objects, and for
that matter so are modules. The only reason we give it a different
feel, is that we are so used to it from other languages. Here are
some examples of how you can use classes (whether or not they have
value, I am not to judge): [Gists](https://gist.github.com/1170768)

### Bound and Determined

There are a lot of terms out there that I don't know, and have yet
to look them up. Last week, one of those words was 'binding', in
the context of programming. For those who are in the dark, the
binding is the state at a given point in your program. By accessing
the binding, one can use the arguments and the local variables.

### Redefining Methods

Another one of the interesting ideas that Dave put forth in his
screencast was the idea of defining or redefining methods within a
method. Here is a code example of that:
[Gist](https://gist.github.com/1170838). This would enable you to
change the entire method, and while the safety of that is
debatable, it is still a very interesting concept.

### Conclusion

There are some many ways we can manipulate a program within its own
context, and it allows us to create living code. Our solutions can
be more directly targeted to the context we are looking for,
instead of monkey-patching onto other classes, which can have it's
own dangerous effects. As always, if you have any feedback for me,
please don't hesitate, it is welcome as long as it is constructive.
