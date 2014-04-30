---
layout: post
title: "Refactoring Go code"
date: 2014-04-28 10:45
comments: true
categories: 
- golang
- blog-post
- tutorial
---

[Go](http://golang.org/) aka golang is an amazing language but also a language that
is really easy to learn due to its small scope.
If you have some coding experience, you will be able to have fully working code
in a matter of minutes otherwise you might want to read [my free book](http://www.golangbootcamp.com/) (WIP).

<div style="text-align:center; padding:2em 0">
  <a href="http://www.golangbootcamp.com/"><img src="/images/matt_aimonetti-go_bootcamp.png" alt="Go Bootcamp free book (golang)"></a>
</div>

Very much like with many other programming languages, a challenging part
of Go is to learn how to write idiomatic code.
The good news is that Go makes refactoring easy (and already has a lot
of conventions).
I strongly recommend [this post](http://peter.bourgon.org/go-in-production/) from Peter Bourgon about Go at SoundCloud and 
the extra conventions they follow ([Splice](https://splice.com) also
follows the same conventions).

One of my favorite Go projects is the [gobot](http://gobot.io) project
by [HybridGroup](http://hybridgroup.com/).

<div style="text-align:center; padding:2em 0">
<a href="http://gobot.io/"><img src="/images/gobotio.png" alt="Gobot"></a>
</div>

The Gobot project is pretty young and I noticed a few things that
could be improved so I offered my help to [Ron](https://twitter.com/deadprogram),
[Adrian](https://twitter.com/adzankich) and the rest of the team.
Our discussion quickly turned into a fun group refactoring
session (featuring [@kytrinyx](https://twitter.com/kytrinyx),
[@deadprogram](https://twitter.com/deadprogram),
[@codegangsta](https://twitter.com/codegangsta),
[@jnbeck](https://twitter.com/jnbeck),
[@adzankich](https://twitter.com/adzankich) )

<div style="text-align:center; padding:2em 0">
  <img src="/images/matt_aimonetti-go_refactoring.jpg" alt="Go refactoring at GopherCon">
</div>

## Packages

Gobot is split into multiple packages, a core and a few other packages.
The gobot team, out of habit chose to put a package per repo.
After further discussions, we chose to bring all official packages
inside the same repo to keep things easier and to keep the import paths
clean and logical.

So instead of having:

```
github.com/hybridgroup/gobot
github.com/hybridgroup/gobot-sphero
github.com/hybridgroup/gobot-...
```

All the none-core packages are moved to subdirectories:

```
github.com/hybridgroup/gobot
github.com/hybridgroup/gobot/sphero
github.com/hybridgroup/gobot/...
```

This also allowed us to fix the package names
`gobot-sphero` is now simply `sphero`

Which also allowed us to simplify the following code:

From:
```go
type SpheroAdaptor struct {
	gobot.Adaptor
	sp io.ReadWriteCloser
}
```

To

```go
type Adaptor struct {
  gobot.Adaptor
  sp io.ReadWriteCloser
}
```

We did that with a few other types and methods all over the packages.

We had a discussion about what lead to the multiple repos vs
one repo. There are legitimate cases for both approaches but in this
situation, the decision was based on a misunderstanding. The author
thought that by importing the top package, all sub packages would
also be somewhat included in the build, making the binary bigger than
needed. Since Go only compiles and links packages imported, moving all
packages within the same repo wouldn't change the binary output.
Note that this is not because in this specific case we have all packages
in the same repo that this is the right thing to do every single time.

## doc.go

By conventions, package should contain a `doc.go` file that contains
an overview of the package and often some information so the developer
trying to use the library can find the right entry points.

As usual, the standard libraries are a good example,
[here is the net/http `doc.go` file](http://golang.org/src/pkg/net/http/doc.go).

## Using a constructor

We spent some time refactoring `master.go` which is the file implementing
the code handling one or multiple robots (which can each have multiple devices).

The original function code looked like this:

```go
func GobotMaster() *Master {
  m := new(Master)
  m.NumCPU = runtime.NumCPU()
  return m
}
```

There are a few things that aren't really idiomatic in this code.
The first thing is that by convention, constructors are usually called `New<Type>`.
Secondly, the [community seems to follow](http://peter.bourgon.org/go-in-production/) the following stylistic choice:
only use `new` and `make` when you need to set the capacity (`make([]string,3)`)
Finally we don't need to allocate a variable. Here is the refactored code:

```go
func NewMaster() *Master {
  return &Master{NumCPU: runtime.NumCPU()}
}
```

## Cleanup package vars

In the original code, we had a variable called `trap` which was
a function living at the top level of the package:

```go
var trap = func(c chan os.Signal) {
  signal.Notify(c, os.Interrupt)
}
```

The func was then used to handle signals. The author
chose to use a variable so he could mutate it in the test suite and
avoid sending an interrupt when testing.
We realized we could avoid having this function variable at the top of the package by moving
it as a field on the `Master` type and setting the default func in the constructor.

```go
func NewMaster() *Master {
	return &Master{
		NumCPU: runtime.NumCPU(),
		trap: func(c chan os.Signal) {
			signal.Notify(c, os.Interrupt)
		},
	}
}
```

The code still behaves the same and we can still overwrite the trap function in our tests
(since the tests are part of the same packge, the non exported field is available)
but we got rid of a top level var.

## Reading from a channel

The following code was ranging over a predefined channel (`c`) of signals.
and when a signal would arrive, all robots belonging to the master
would be halted and disconnected.

```go
for _ = range c {
  for r := range m.Robots {
  	m.Robots[r].haltDevices()
  	m.Robots[r].finalizeConnections()
  }
  break
}
```

The code above works well but could be cleaned up a little:

```go
// waiting on something coming on the channel
_ = <- c
for _, r := range m.Robots {
	r.haltDevices()
	r.finalizeConnections()
}
```

This code does the same thing but simpler.
We are trying to read from the channel which will block
(we don't care about the result so we use an underscore).
Then we loop through each robot and stop them.
We managed to remove a for loop on the channel (with an odd break)
and made the code intent clearer.

## Chainable functions and typed nils

Next, we tackled the following method:

```go
func (m *Master) FindRobotDevice(name string, device string) *device {
	robot := m.FindRobot(name)
	if robot != nil {
		return robot.GetDevice(device)
	}
	return nil
}
```

The funny thing about this method is that it's not needed.
We could get the same result by calling:

```go
m.FindRobot("bot name").GetDevice("laser")
```

When I said that, someone suggested that it might be a bad idea
since `FindRobot()` might return `nil` and now we would be calling
`GetDevice()` on `nil` and bad things would happen.
Looking at the code, it was actually easy to fix.

Here is the original code:

```go
func (r *Robot) GetDevice(name string) *device {
	for _, device := range r.devices {
		if device.Name == name {
			return device
		}
	}
	return nil
}
```

Here is the refactored version:

```go
func (r *Robot) GetDevice(name string) *device {
	if r == nil {
		return nil
	}
	for _, device := range r.devices {
		if device.Name == name {
			return device
		}
	}
	return nil
}
```

Did you spot the difference? We just added a check to see if the pointer (`r`)
was nil, if it is, we just return `nil`.
When I added the code above, the person who was worried
about calling `GetDevice()` on `nil` was scratching his head.

Golang does something very interesting (and a bit surprising if you come
from a dynamic language),
it returns a nil pointer of the type we defined as return type.
Let's walk through the code by rewriting it slightly differently:

```go
var bot *Robot
bot = m.FindRobot("unknown name")
```

At this point if `FindRobot()` didn't find a robot, `bot` is still
of type `*Robot` but the pointer is nil.
Because we defined a method `GetDevice()` on `*Robot`, we
can call:

```go
bot.GetDevice("x-ray")
```

The `GetDevice()` method will execute and will return `nil` right
away because we check if the pointer is `nil`.

The fact that nil pointers have types has 2 important implications,
the first one is that you can nicely chain methods without
checking at the caller site if the returned value is `nil`.
The second is that your methods should expect to be potentially
called on a nil pointer and should properly handle such cases.


## Collection types / type aliasing

I'm writing this post on my way back from GopherCon and there
was one more thing I wanted to clean up and share with you.
This is a nice pattern I use often to simplify my code.


Our `Robot` type has a `connections` field and a `devices` field:

```go
type Robot struct {
  // .. fields removed to simplify the example
	devices       []*device
}
```

To avoid always having to manually loop through the slice, a method is defined on
pointers to `Robot`. This method iterates over
the devices and halts them:

```go
func (r *Robot) haltDevices() {
	for _, device := range r.devices {
		device.Halt()
	}
}
```

This code is totally fine but from an API design perspective, wouldn't it be nicer
to use?:

```go
r.devices().Halt()
```

One of the nice things with this approach is that the concept of halting, which
really belongs to the devices, doesn't need to leak into the `Robot` world.

To implement the suggested API change, we need to define a [type alias](http://www.golangbootcamp.com/book/methods_and_interfaces#uid90):

```go
type DeviceCollection []*device
```

We can now define methods on our new type:

```go
func(c DeviceCollection) Halt() {
  for _, device := range c {
    device.Halt()
  }
}
```

We then need to update our `Robot` type:

```go
type Robot struct {
  // .. fields removed to simplify the example
  devices       DeviceCollection
}
```

And we are done with out refactoring.

One last note, since we might need to call different methods on our collection
we could create an iterator method.

```go
func(c DeviceCollection) Each(f func(*device)) {
  for _, d := range c {
    f(d)
  }
}

// which can be called like so
r.devices.Each(func(d *device){
  d.Halt()
})
```

## Conclusion

Needless to say that we had fun. The refactoring went much further
and we removed the use of reflections, some sleeps and much more.
The code is going through a nice cleanup before reaching 1.0 and
I can only encourage everybody to play with [Gobot](http://gobot.io),
there are very few things as fun as Go and Robots!
(The code is open sourced, look at it, add new drivers, send PRs!)

I'd like to thank [Ron Evans](https://twitter.com/deadprogram) and the [Hybrid Group](http://hybridgroup.com/)
for  open sourcing their code and sharing the fun with all of us.
I can't wait for the next LA Go + Robot hack night.

Finally, [Splice](https://splice.com) is hiring, our stack uses a lot of
different technologies but our backend is all in Go and we are always
looking for talented engineers. Drop me a line if interested.
