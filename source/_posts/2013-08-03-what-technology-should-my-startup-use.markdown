---
layout: post
title: "What technology should my startup use?"
date: 2013-08-03 22:10
comments: true
categories: 
- blog-post
- golang
- ruby
- entrepreneurship
---

Over the years many people have asked me the same question:

> I'm starting this new project, what technology do you think I should use?

Often these people fit in one of two categories:

* Technologists who've already made up their mind
* Non-technologist entrepreneurs who need to be reassured

At the end of the day, I doubt that many of these people actually cared
about my answers. They probably just wanted to know if we were on the same page or wanted to be reassured.

To be honest, as an engineer, I believe **a great idea can be built with almost any
technology**. They all have their pros/cons. No matter what stack you choose, you'll pay a
certain price for whatever advantages it offers. But really, the success or failure of your project has more to do with vision, leadership, execution, and market than technological choices.

Now that I'm an entrepreneur, I make technical decisions daily. When I choose
a specific technology, I need to be able to justify the decision to myself, my
partners/employees and potential investors. I make technical choices based on the project and company's vision.

For a project to be successful you must have a strong vision.
If you can convert your **vision** into a set of **values** to benchmark every decision, your path will be clear and it'll be easier to find the right people to join you.

Besides the vision, a lot of startups focus on culture. 
It is commonly said that the culture is defined by the founders, the first few employees, and
the product itself.
However, what isn't often mentioned is that **the technical
decisions will have a direct effect on the company culture**.

Whether your new startup is based on J2EE/Oracle, Perl, PHP, Rails, Node.js or
.NET, the team's engineers will have different expectations, different
values, and different concerns. None of these technologies are intrinsically bad,
great things have been built with each. But they do come with a culture.

A couple years ago, I met an entrepreneur who chose to
build his application in Node.js. Curious, I asked why he chose Node.
The response was simple:
* smart engineers are excited about it so I can more easily recruit
* people are willing to contribute for free because it builds their
  experience

This decision clearly set the engineering culture and defined the team of people
who could work or be interested in working on the project. 

## Asking a Different Question

So maybe instead of asking what technology I should use, we should ask ourselves:

> Does this technology fit my company's core values?

That's a much harder question because you need to actually *understand* your
core values. That understanding is key to building a successful product.

You can't blindly copy a tech stack in the same way you can't copy a business plan. It's a part of your company's identity. Your core values, your objectives, your team and your
expectations are different.

The whole _"it worked for X"_ argument is
rarely valid. Look, Facebook uses PHP, it "worked for them". Does that mean we should all use PHP?

Technical decisions have cultural impact. Think clearly and carefully about **how your technologies align with your company's core values**. Make the right choices and you'll spend less time fighting about technical details and more time building a great business.

And if you miss those arguments, there's always [hackernews](http://news.ycombinator.com/).


## Technology culture alignment

I originally did not plan on adding this section, mainly because it will require for me to indulge in generalities which will more than likely bother some of you.
But when [Jeff Casimir](https://twitter.com/j3) reviewed this post he convinced me to dive into what cultures align with different technologies stacks. Note that I'm just reporting my own perspective of the core values I noticed in the following technology communities. Feel free to use the comments to share your own perspective and cover other communities. 


#### Old School

Here are some of the "classics", languages that have been used for a
while and proved their values, they grew big but don't really get people too
passionate about anymore. I omitted Perl because I personally don't know any new
startups building their core technology in Perl (6?).

## PHP

**Philosphy:**

* We don't have any, get stuff done, that's what matters.
* Basic for the Web.
* As long as there is a way to do it, it ain't broken.
* It works and it's fast, anything else is pointless.
* Don't be too academic, our language is accessible and anyone can be
  started in no time. Try to do the same thing with Java!
* Object orientation as an afterthought.

**Common use case: (as of mid-2013)**

* Your first web app
* Extending Wordpress/Drupal

**Personal opinion:**

PHP had its days of glory. It really made web development easy and
accessible. However, probably due to the really large amount of new programmers who
started with PHP and a not so opinionated community, very few people can
write good PHP. Good idiomatic code examples are hard to find and I'm not even sure there is such as as idiomatic PHP.
Unfortunately, for most of us, PHP means poor code quality, lack of
tests, security nightmare and an after taste of the early 2000s.
Strong PHP teams with well established conventions, processes and guidelines can accomplish great things, 
but such teams are seldom.
To be honest I'm not sure what kind of developers who you will attract
when using PHP.


## Java


**Philosphy:**

* Portability
* The power & performance of C/C++ but with automatic memory management
* We care a lot about object-orientation
* IDE required
* Memory is cheap so we consume it ALL
* Threading is the way to go!
* Don't mention Java applets
* Look at my pretty JVM!
* Open source (but owned by Oracle)
* Slower but safer development cycles.

**Personal opinion:**

Java is quite interesting, a few years ago a lot of developers got tired of Java and
explored other lands. They often switched to interpreted languages
such as PHP, Python, Ruby or more esoteric languages such as Erlang.
However, Google via Android was able to show that Java in itself isn't as terrible
as we remembered (as long as you don't have to use J2EE or Swing).
There is also a "hipsterish" trend that seems to indicate that Java is
actually cool again. A lot of that has to do with two things:

* the JVM
* the incredible amount of available and high quality libraries

That said, for a lot of us, writing Java all day long doesn't sound
really appealing. If you are going to rely on the Java stack, there is [long list of other JVM languages](http://en.wikipedia.org/wiki/List_of_JVM_languages) 
which are mature and plays well with Java
libs (i.e: Scala, Groovy, JRuby, Clojure).
You can always to mix and match. 
Hiring Java developers isn't too hard since most students coming out of school learned Java, 
but finding great early-stage startup engineers who want to write Java is quite harder. 

*Side note: If you are targeting Android, keep it simple, stay with the official
stack even if you might fancy another JVM language better.*

There are still many reasons to use Java's technology for your new
startup, but you might also consider using a more "rapid/flexible" solution in parallel (Ruby,
Python, Node...). A multilingual environment brings a lot of value to
both the company and the engineers, which is something the Java
community seems to slowly but surely discover.

Java mainly attracts more classical trained engineers looking for
comfortable, repetitive, well known patterns. They will be used to the language, its
tools and its natural rhythm. They might not be the most curious
developers but they are reliable (if you pick the right ones obviously).


## C#/.NET

**Philosphy:**

* A better a Java.
* Originally designed for desktop and embedded apps.
* We have a better IDE than the Java guys.
* We are enterprise serious but we can offer you most of Rails' cool
  features.
* We have a conflicted vision of Open Source.
* Slower but safer development cycles.

**Personal opinion:**

I went back and looked at C# when C# 5 was released and I have to say
that I was really impressed by some of the new language features. From a
purely language design perspective, C# is quite ahead of Java. I was
also surprised by how pleasant it was to write Javascript in Visual
Studio (I really didn't expect that since my experience with VS was
mainly around C++). 
Another thing that really impressed me: the quality level of the
available documentation is outstanding!
But the fact that C# isn't open source, that Visual Studio + msdn is so expensive and 
that you can smell money everywhere you look, is bit of a turn off.
From the look of it, Microsoft is pushing Javascript/Node.js as a
main web solution and C# for more "serious" business. Like most developers
out there, I personally have no desire/need/reason to run on the Microsoft stack 
so for me the choice is easy.
Microsoft seems to slowly change their mind on open source and as a
company, it opens up to non MSFT solutions (see Azure). But as a
community, .NET is still quite MSFT centered.
As a startup entrepreneur, you should consider how you feel about open
source vs enterprise backed cultures.

C# mainly attracts the Microsoft version of the Java crowd, that is the
same kind of engineer but the version who doesn't value Open Source too much
and prefer Windows/IIS over Linux/Nginx|Apache.



#### Established alternatives

Over the years, two dynamic languages became cherished by startups:
Python first, then Ruby thanks to Ruby on Rails. These two languages are
actually quite similar. Nowadays Python is quite popular for backend apps
(NLP, biotech, APIs, SOA elements) while Ruby is more popular for
frontend apps (after all, Ruby is the web 2.0 language by excellence).
Both of these languages suffer from the same limitations (mainly
performance and concurrency) but their core
values and communities have different focuses.

## Python

**Philosphy:**

* Only one obvious way to do things
* Code has to be beautiful, simple and explicit
* Documentation is critical
* Strong language design leadership

**Personal opinion:**

As someone who chose Ruby over Python, I often envy the quality of
the documentation you find in most Python projects.
I also have a love/hate relationship with the fact that Python is
designed to give you the minimal amount of ways to do one thing. This is
often great for teams, but it can also be greatly frustrating.
In some areas, Python has some of the best libraries out there, and
depending on the problems you are tackling, Python might be the right
choice. However, when it comes to the frontend, I think Ruby offers more
benefits, but I will admit that it's debatable. 
Python developers often know how to communicate about their code since 
that's one of the language's strong values. They document what they do
and are somewhat process oriented while being pragmatic about their
approaches. But Python was created way before the internet became
popular and if concurrency and high throughput is a concern for you, a
dynamic, interpreted language with poor concurrency might not be for
you.

Python mainly attracts more pragmatic, experienced, full stack developers
wanting a modern but well proven language.

## Ruby/Ruby on Rails

**Philosphy:**

* Designed for humans, not machines.
* Extreme flexibility, if you mess up, it's on you.
* Everything has to be easy, elegant and fun.
* DSL on top of DSLs on top of DSLs, abstraction is pretty and fun!
* Testing is critical!
* Things move quickly, learn to keep up.
* Passionate and vibrant community.

**Personal opinion:**

As far as I'm concerned, Ruby has been my goto language for years.
You will find an incredible, sometimes overwhelming amount of Ruby open
source code. Rails is really an amazing web framework making most web
project easy to implement (once you've passed the increasingly steep learning
curve). But this flexibility and rapid development cycles also have
cons. Be ready to invest a large chunk of your time keeping your code
base up to date and migrate away from abandoned libraries.
If you can't rely on caching, the throughput of your app will often be limited
by the lack of good concurrency support (often not a problem until you
grow big enough tho, see Twitter as an example).
Ruby developers are mainly Rails developers and a great majority might
have a hard time being able to identify core language features vs
framework features. They are often curious, opportunistic (in a good way),
somewhat pragmatic and care about code quality (whatever that means) and
test coverage. Rails developers usually are early adopters often due to
the fact that the framework itself uses some new technologies by
default (coffeescript, turbolinks, CSS pre-processors...).

Ruby and Rails mainly attracts developers wanting to get things done
quickly but elegantly (whatever that means). These developers are often
product oriented and care more about the higher than the lower level
details. They are pragmatic, rely and contribute heavily to the
ecosystem.

#### New players

These are the languages/technologies that get people excited. They
represent the new wave of programming languages designed to run
in "the cloud".

## Node.js (Javascript)

Node.js isn't a programming language but it's the most popular way to
run JS server side. The same way most of my comments about Ruby were
about Rails, I'll focus on node more than JS itself.

**Philosphy:**

* Designed for real-time driven apps with high throughput, low latency
* DIY
* Small core, the rest is up to the community
* Coupling is a sin
* Learned from Ruby/Python

**Personal opinion:**

I find Node.js interesting. Technically there isn't much new with Node, Python had
Tornado/Twisted, Ruby had EventMachine (C had libevent), event-driven frameworks have
been used for a while but Node has two major advantages: 
* most JS libs are non-blocking. 
* most web developers have to write some JS.
Granted, there wasn't many server side js libs out there,
but at the same time other languages have mostly blocking libs meaning
that they need to rewritten/refactored anyway.
There is also something appealing in the idea of using the same
programming language both in the front end and the back end.
While I don't personally think that using the same language is realistic or even
a good idea, I can appreciate why others think otherwise.
Node offers great throughput (as long as you stick to IO operations),
it's easy to get started and it's also fun to write.
Node developers are early adopters, might or might stick with the
technology but are interested in a more custom approach than what Rails
or Django would have to offer.
Dealing with so callbacks can be a serious pain and maintenance hell. I hope that node
will adopt an official future/promise solution.
Due to the nature of even based programming, debugging and testing is
challenging, documentation is spotty making jumping on an existing
project a bit challenging.

Node.js mainly attracts developers wanting to use a known language (JS)
to handle high levels of concurrency. Node as a framework is lower level
than the classical MVCs which is a plus for hackers. Node developers
also really like the idea of using the same programming language server
and browser side.

## Clojure

**Philosphy:**

* A pragmatic and modern Lisp.
* Everything is data.
* Concurrency, concurrency, concurrency.
* States are evil.
* Great Java interoperability.
* A bit on the academic side, but still being pragmatic.

**Personal opinion:**

What I like the most about Clojure is that you get close to the lisp
spirit.
Once you get passed the parenthesis and the operator/argument order,
clojure forces you to entirely rethink the way you architect your code.
It's really good and efficient at processing data and pushes you to keep
your code short.
My problem with Clojure is that I'm not smart enough to write a lot of
it. My brain quickly stack overflows trying to follow the data flows.
Exceptions are often meaningless and trying to debug someone's code is
challenging since the language itself is complex and it can be extended
by macros. Finally, the Clojure community isn't really web oriented,
most of the work done in Clojure seems to be data centric, which
obviously makes sense. 

Clojure mainly attracts more fringe, language-curious, data
oriented programmers. If you are looking for data scientists with a programming language fetish,
Clojure is a good way to attract them.

## Scala

**Philosphy:**

* Have the best of both object oriented and functional programming worlds.
* Let the compiler do some of the work so you can focus on your job.
* Concurrency matters.
* Less ceremony than Java, but aiming for same or better performance.
* Live in harmony with the Java ecosystem.
* Our language can get a bit crazy sometimes but with great comes great
  responsibilities.
* If you are a Java, Python or Ruby guy & want to develop concurrent,
  party OO, partly functional apps, Scala is for you.

**Personal opinion:**

When dealing with the JVM, Scala is for me currently the best
language choice. The learning curve might be a bit stiff, knowing
when to use FP vs OOP can be a bit tricky and so is dealing with the
language surface. That said, getting the benefits of using FP, while
still keeping OOP when needed is very useful.
Once you "get" the language idioms, writing Scala is actually pleasant
and the community is quite nice. The [Play](http://www.playframework.com/) 
framework is really good and offers a good alternative to Rails,
especially for API development. Twitter's engineering team offers a lot
of resources and open source code.
Using Scala is a pretty safe bet at this point. Java developers feel
confortable and get to try more "modern" language, while dynamic
language developers don't feel too far from home but get the Java
ecosystem, the performance boost, concurrency and immutability.
The tooling and convetions make it so working on a Scala project with a
growing team is actually quite nice, however the compilation time can
get a bit annoying when coming from a scripting language or Go.
Another thing that Scala isn't really good at:
documentation (very much like the Ruby community btw).
I really hope [the API doc](http://www.scala-lang.org/api/current/) will
be rewritten to be more intuitive, and overall more useful.
But to be fair there is a lot of great resources out there such as
[Twitter's Scala school](http://twitter.github.io/scala_school/) and
[Coursera's FP in Scala class](https://www.coursera.org/course/progfun) given
by Martin Odersky himself (Scala's creator).

Scala mainly attracts curious and tired Java developers wanting
something more modern as well as Ruby/Python developers wanting a more
"enterprisey/performant" version of their language. 
Scala is a good way to attract great developers who want to push 
the boundaries of their existing dev environment as well as developers 
being able to leverage the duality of the language.


## Go

* A better C.
* Memory management is handled for you, but don't be stupid.
* Explicit is better than implicit.
* Batteries included (the language provides you with what most people
  need).
* Fast.. everything (from compilation to execution).
* Concurrency built-in and made easy.
* Keep it simple, really!
* Documentation is critical.

**Personal opinion:**

I really like Go (aka Golang), after playing with it for years, I chose to use it to
develop the APIs of my own startup. Go might sound boring to some, but
its simplicity and efficiency make for an enjoyable language to work with.
Go forces you to think a bit more about how you structure your
data/behaviors because you can't just stick to the usual OO patterns
you've been using for years. I found that my code ended up being clearer
to follow, simpler yet sometimes a bit more repetitive (error handling
is a good example of that).
Concurrency doesn't get much easier than what Go provides.
Your code compiles and boots faster than it takes Rails to start. (Go
supports some sort of duck typing making the transition from Ruby quite
easy).
Obviously the production performance are quite amazing when coming from
a scripting language and the memory footprint stays small.
Go is designed so a single user or a big team can work on the same code
base and the tooling around the language is really great. However, it's
not a perfect language. 3rd party dependency management can be tricky at
times, the code can be a bit too low level when you're used to high
level programming languages and some of the great language design decisions
also make some things a bit confusing (interaction with interfaces vs structs). 
Go seems to become quite popular within the startup scene when
performance and concurrency matters. I've seen a good number of startups
migrating from Node to Go and others simply extending their stack by
adding small Go apps.
The Go community seems to be a mix of old school dudes coming from C/C++
and a younger crowd finding a good compromise in the language.
The language and the community leaders are opinionated which makes
understanding their vision and approach easy. It also allows you to
quickly evaluate how comfortable you are with their philosophy and see
if it matches your expectations.

Go mainly attracts performance/architecture oriented developers.
They want easy concurrency, the speed of C as well as the easiness of
Python/Ruby. They don't look for a new fun language, they look for a
solid compromise. 
