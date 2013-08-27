---
layout: post
title: "What technology should my startup use?"
date: 2013-08-27 22:10
comments: true
categories: 
- blog-post
- golang
- ruby
- entrepreneurship
- PHP
- C#
- Java
- Scala
- Node.js
- Clojure
- Python
- Popular
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
values, and different concerns. None of these technologies are intrinsically bad. Great things have been built with each. But they do come with a culture.

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

## Technology-Culture Alignment

Characterizing communities is difficult, but I'll share with you the impressions and perspectives that I have on various options. Feel free to use the comments to share your own perspective and cover other communities. 

### Old School

Here are some of the "classics": languages that have been used for a
while and have proven their values. They're widespread, but don't inspire much passion anymore. 

*Note*: I omitted Perl because I personally don't know any new startups building their core technology in Perl (6?).

## PHP

**Philosophy:**

* Get stuff done, that's what matters
* It's like Basic for the Web
* As long as there is a way to do it, it ain't broken
* It works and it's fast, anything else is pointless
* Don't be too academic, our language is accessible and anyone can be
  started in no time. Try to do the same thing with Java!
* Object orientation as an afterthought

**Common use case: (as of mid-2013)**

* Your first web app
* Extending Wordpress/Drupal

**Personal opinion:**

PHP had its days of glory. It really made web development easy and
accessible. However, probably due to the really large amount of new programmers who
started with PHP and a not so opinionated community, very few people can
write good PHP. 

Good idiomatic code examples are hard to find and I'm not even sure there is such as as idiomatic PHP. The result is a community known for poor code quality, lack of
tests, security nightmares and an after taste of the early 2000s.

Strong PHP teams with well established conventions, processes and guidelines can accomplish great things, 
but such teams are rare. 

## Java

**Philosophy:**

* Portability
* The power & performance of C/C++ but with automatic memory management
* Cares a lot about object-orientation
* IDE required
* Memory is cheap so we consume it *ALL*
* Threading is the way to go!
* Don't mention Java applets
* Look at my pretty JVM!
* Open source (but owned by Oracle)
* Slower but safer development cycles

**Personal Opinion:**

Java is quite interesting. A few years ago a lot of developers got tired of Java and
explored other lands. They often switched to interpreted languages
such as PHP, Python, Ruby or more esoteric languages like Erlang.

However, Google via Android was able to show that Java in itself isn't as terrible
as we remembered (as long as you don't have to use J2EE or Swing).
There is also a "hipsterish" trend that seems to indicate that Java is
actually cool again. A lot of that has to do with two things:

* the JVM
* the incredible quantity of high quality libraries

That said, for a lot of us, writing Java all day long doesn't sound
 appealing. If you are going to rely on the Java stack, there is [long list of other JVM languages](http://en.wikipedia.org/wiki/List_of_JVM_languages) 
which are mature and play well with Java
libs (i.e: Scala, Groovy, JRuby, Clojure).
You can always to mix and match. 

Hiring Java developers isn't too hard since most students coming out of school learned Java, 
but finding great early-stage startup engineers who want to write Java is quite challenging. 

*Side note: If you are targeting Android, keep it simple, stay with the official
stack even if you might fancy another JVM language better.*

There are still many reasons to use Java's technology for your new
startup, but you might also consider using a more "rapid/flexible" solution in parallel (Ruby,
Python, Node...). A multilingual environment brings a lot of value to
both the company and the engineers, which is something the Java
community seems to be slowly but surely discovering.

Java mainly attracts more classically trained engineers looking for
comfortable, repetitive, well known patterns. They will be used to the language, its
tools and its natural rhythm. They might not be the most curious
developers but they are reliable (if you pick the right ones obviously).

## C#/.NET

**Philosophy:**

* A better Java
* Originally designed for desktop and embedded apps
* We have a better IDE than the Java guys
* We are enterprise serious but we can offer you most of Rails' cool
  features
* We have a conflicted vision of Open Source
* Slower but safer development cycles

**Personal Opinion:**

I went back and looked at C# when C# 5 was released and I have to say
that I was really impressed by some of the new language features. From a
purely language design perspective, C# is quite a bit ahead of Java. I was
also surprised by how pleasant it was to write Javascript in Visual
Studio (I really didn't expect that since my experience with VS was
mainly around C++). 

Another thing that really impressed me: the quality level of the
available documentation is outstanding!
But the fact that C# isn't open source, that Visual Studio + MSDN is so expensive and 
the whole environment reeks of licenses and costs, is bit of a turn off.

Microsoft is slowly opening up to open source and more open solutions like Azure. But as a
community, .NET is still quite Microsoft-centered.
As a startup entrepreneur, you should consider how you feel about open source vs enterprise backed cultures.

C# mainly attracts a variant of the Java crowd: engineers seeking stability and a support contract over open source. And they can tolerate IIS!

### Established Alternatives

Over the years, two dynamic languages became cherished by startups:
Python and Ruby. The two languages are
actually quite similar. Nowadays Python is quite popular for backend apps
(NLP, biotech, APIs, SOA elements) while Ruby is more popular for
consumer-facing apps.
Both of these languages suffer from the same limitations (mainly
performance and concurrency) but their core
values and communities have different focuses.

## Python

**Philosophy:**

* Only one obvious way to do things
* Code has to be beautiful, simple and explicit
* Documentation is critical
* Strong language design leadership

**Personal Opinion:**

As someone who chose Ruby over Python, I often envy the quality of
the documentation you find in Python projects.
I also have a love/hate relationship with the fact that Python is
designed to give you just one right way. This is
often great for teams, but it can also be frustrating.

In some areas, Python has some of the best libraries out there, and
depending on the problems you are tackling, Python might be the right
choice. Python developers know how to communicate about their code. They document what they do
and are process oriented while being pragmatic about their
approaches. 

But Python was created way before the internet became
popular and if concurrency and high throughput is a concern for you, a
dynamic, interpreted language with poor concurrency might not be the right choice.

Python mainly attracts more pragmatic, experienced, full-stack developers
wanting a modern but well-proven language.

## Ruby/Ruby on Rails

**Philosphy:**

* Designed for humans, not machines
* Extreme flexibility: if you mess up, it's on you
* Everything has to be easy, elegant and fun
* DSL on top of DSLs on top of DSLs
* Testing is critical
* Things move quickly, learn to keep up
* Passionate and vibrant community

**Personal opinion:**

As far as I'm concerned, Ruby has been my go-to language for years.
You will find an incredible, sometimes overwhelming amount of Ruby open
source code. Rails is really an amazing web framework making most web
projects easy to implement if you know how to use the tool. 

But the flexibility and rapid development cycle also have
downsides. Be ready to invest a large chunk of your time keeping your code
base up to date and migrating away from abandoned libraries.
If you can't rely on caching, the throughput of a successful app will often be limited
by the lack of good concurrency support.

Ruby developers are mainly Rails developers and a great majority might
have a hard time being able to identify core language features versus
framework features. They are often curious, opportunistic (in a good way),
somewhat pragmatic and care about code quality/structure and
test coverage. Rails developers are typically early adopters due to
the fact that the framework itself uses some new technologies by
default (coffeescript, turbolinks, CSS pre-processors...).

Ruby and Rails mainly attract developers wanting to get things done
quickly but elegantly. These developers are often
product-oriented and care more about the purpose and customer value  than the lower-level computational details. 

## New Players

These are the languages/technologies that get people excited. They
represent the new wave of programming languages designed to run
in "the cloud".

## Node.js (Javascript)

Node.js isn't a programming language but it's the most popular way to
run JS server side. The same way most of my comments about Ruby were
about Rails, I'll focus on Node more than JS itself.

**Philosophy:**

* Designed for real-time driven apps with high throughput, low latency
* DIY
* Small core, the rest is up to the community
* Coupling is a sin
* Learned lessons from Ruby/Python

**Personal Opinion:**

I find Node.js interesting. Technically there isn't much new with Node. Python has
Tornado/Twisted, Ruby has EventMachine, and C had libevent. 

Event-driven frameworks have
been used for a while but Node has two major advantages: 
* most JS libs are non-blocking
* most web developers have to write some JS anyway

The idea of using the same
programming language both in the front end and the back end appeals to many, but the value is still unproven.

Node offers great throughput (as long as you stick to IO operations),
is easy to get started, and is fun to write.

Due to the nature of event-based programming, debugging and testing is challenging. Dealing with callbacks can be maintenance hell. I hope that Node will adopt an official future/promise solution. And documentation is typically spotty making jumping on an existing project difficult.

Node developers are definitely early adopters and comfortable creating a custom structure/pattern rather than following convention.It attracts developers wanting to use a known language (JS)
to handle high levels of concurrency. Node as a framework is lower level than the classical MVCs which is a plus for hackers. Node developers also really like the idea of using the same programming language on both server and client.

## Clojure

**Philosophy:**

* A pragmatic and modern Lisp
* Everything is data
* Concurrency, concurrency, concurrency
* States are evil
* Great Java interoperability
* A bit on the academic side, but still being pragmatic

**Personal Opinion:**

What I like the most about Clojure is the lisp
spirit.
Once you get past the parenthesis and the operator/argument order,
Clojure challenges you to entirely rethink the way you architect your code.
It's really good and efficient at processing data and pushes you to keep
your code short.

My problem with Clojure is that I'm not smart enough to write a lot of
it. My brain quickly stack overflows trying to follow the data.
Exceptions are often meaningless and trying to debug someone else's code is
challenging since the language itself is complex and it can be extended
by macros. Finally, the Clojure community isn't really web-oriented,
most of the work done in Clojure seems to be data-centric. 

Clojure mainly attracts more fringe, language-curious, data-oriented programmers. If you are looking for data scientists with a programming language fetish,
Clojure is a good way to attract them.

## Scala

**Philosophy:**

* Have the best of both object oriented and functional programming worlds
* Let the compiler do some of the work for you
* Concurrency matters
* Less ceremony than Java, but aiming for same or better performance
* Live in harmony with the Java ecosystem

**Personal Opinion:**

Scala is currently my language of choice when targeting the JVM. The learning curve is steep. Knowing
when to use FP vs OOP can be tricky and so is dealing with the
language syntax itself. 

That said, getting the benefits of using FP, while
still keeping OOP when needed, is very useful.
Once you "get" the language idioms, writing Scala is actually pleasant
and the community is quite nice. 

The [Play](http://www.playframework.com/) 
framework is really good and offers a good alternative to Rails,
especially for API development. Twitter's engineering team offers a lot of resources and open source code.

Using Scala is a pretty safe bet at this point. Java developers feel
confortable and get to try a more "modern" language. Dynamic
language developers don't feel too far from home but get the Java
ecosystem, the performance boost, concurrency and immutability.
The tooling and convetions make using Scala on a
growing team quite nice, if the compilation time doesn't get you down.

Like Ruby, though, the Scala community isn't big on documentation.
I really hope [the API doc](http://www.scala-lang.org/api/current/) will be rewritten to be more intuitive and overall more useful.
But to be fair there are a lot of great resources out there such as
[Twitter's Scala school](http://twitter.github.io/scala_school/) and
[Coursera's FP in Scala class](https://www.coursera.org/course/progfun) given
by Martin Odersky (Scala's creator).

Scala mainly attracts curious Java developers wanting
something more modern as well as Ruby/Python developers wanting a more scalable version of their language. 
Scala is a good way to attract great developers who want to push 
the boundaries of their existing dev environment as well as developers being able to leverage the duality of the language.

## Go

* A better C
* Memory management is handled for you, but don't be wreckless
* Explicit is better than implicit
* Rich built-in functionality
* Fast.. everything (from compilation to execution)
* Concurrency built-in and made easy
* Documentation is critical

**Personal Opinion:**

I really like Go (aka Golang). After playing with it for years, I chose to use it to
develop the APIs of my own startup. Go might sound boring to some, but
its simplicity and efficiency just work.

Go forces you to think a bit more about how you structure your
data/behavior because you can't just stick to the usual OO patterns. I've found that my code ends up being easier
to follow and simpler in structure, yet sometimes a bit more repetitive (ex: error handling).

Concurrency can't get much easier than Go. While it is compiled, your code compiles and boots in less time than a Rails server starts up. Go supports some form of duck typing making the transition from Ruby (for instance) quite easy. The production performance is quite amazing when coming from
a scripting language and the memory footprint stays small.

Go is designed so a single user or a big team can work on the same codebase and the tooling around the language is really great. 

However, it's not a perfect language. 3rd party dependency management can be tricky at
times. The code can feel too low-level when you're used to high-level programming languages. And some of the language design decisions can cause confusion at times (ex: interacting with interfaces vs structs). 

Go seems to become quite popular within the startup scene when
performance and concurrency matters. I've seen a good number of startups migrating from Node to Go and others simply extending their stack by adding small Go apps.

The Go community seems to be a mix of old school hackers coming from C/C++ and a younger crowd enjoying a lower-level language.
The language and the community leaders are opinionated which makes
understanding their vision and approach easy. It also allows you to
quickly evaluate how comfortable you are with their philosophy and see if it matches your expectations.

Go mainly attracts performance/architecture oriented developers.
They want easy concurrency, the execution speed of C with the development speed of
Python/Ruby. They don't look for a new fun language, they look for a
solid compromise. 

## Technology Drives Culture

Technical decisions have cultural impact. Think clearly and carefully about **how your technologies align with your company's core values**. Make the right choices and you'll spend less time fighting about technical details and more time building a great business.

And if you miss those arguments, there's always [hackernews](http://news.ycombinator.com/).


---
<br/>

*Update*: Speaking of HN, [here is the thread for this post](https://news.ycombinator.com/item?id=6285129)
