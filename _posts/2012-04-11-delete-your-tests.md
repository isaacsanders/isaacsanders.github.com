---
title: Delete Your Tests
layout: blog_post

---

Have you ever deleted a test because it kept breaking? I delete tests all the
time. I enjoy deleting tests. __almost as much as I like deleting the code they
test__. I have been deleting tests that tie me to my implmentation. The tests I
delete are the ones that drive me to my implementation, and the tests that I
leave are the ones that test behavior in my code.

##What kind of tests are good to delete?

Here is a spec file on my [Githubris](http://github.com/isaacsanders/githubris)
project.

<script src="https://gist.github.com/2359662.js"> </script>

##How do I keep the behavior covered?

After pulling the attribute behavior into a superclass, I can test the generic
parts of the code above.

This is the code that I am testing now, instead of the individual methods:

<script src="https://gist.github.com/2361032.js"> </script>

##Why delete tests?

There's nothing in Test-Driven Development that says you should keep the
tests forever. I feel that once you write the test that gets you to where you
are going, you should not let it keep you from moving forward. Many times, I
will write a test that says what arguments I give to the method. A test like
that is there to get me to write the method definition. After I have the tests
for its behavior, I will delete the test that keeps me pinned to a certain
implementation.

Michael Feathers has many good reasons that tests aren't safe from deletion. In
his blog post [Taking Automated Tests Off The Pedestal](https://plus.google.com/104920553571646483561/posts/fmyZi1MxMgo),
he implores the reader to consider true quality when testing. In my opinion, a
test that holds a project from moving forward is definitely impeding quality.

##When?

I will delete a test when it starts to cause friction for me. If I keep hitting
a test, and it provides little value, then I will delete it. My tests are not
gospel, and catering to the tests hurts my projects.

If you would like to talk further about this, please comment below or email me
at [isaac@isaacbfsanders.com](mailto:isaac@isaacbfsanders.com)
Now go, and delete some specs!
