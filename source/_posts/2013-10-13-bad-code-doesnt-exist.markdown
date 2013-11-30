---
layout: post
title: "Bad code doesn't exist"
date: 2013-10-14 09:08
comments: true
categories: 
 - Presentation
 - Ruby
 - Golang
slides: https://speakerd.s3.amazonaws.com/presentations/f325aee016620131a63906e09cf22df5/wickedbadruby-2013.pdf
---

I just give a talk at [Wicked Good Ruby Conf](http://wickedgoodruby.com/) in Boston. I'm sure the talk will be online soon, but I figured it would be interesting to discuss it a bit further in a blog post.

The format was a bit different than usual, I had a 40 minute slot and
divided in 2, I made my points for 20 minutes and invited two special
guests on stage to discuss the topic. The reason for this format is
because I think we all learn better by looking at things from different
perspectives. I can't thank enough [Sandi Metz](http://www.sandimetz.com/) and [Katrina Owen](http://kytrinyx.com/) for their contributions.

Here are a few points that I think are interesting and
that we discussed during the talk.

## There isn't such thing as bad code

Bad code doesn't exist, you have code that can be interpreted/compiled and code that doesn't.
"Good" and "bad" are moralistic designations, not scientific ones.
Let's try to stop using these terms to refer to talk. Let's be more
precise when arguing about code, "what do you mean by bad?" Is it
hard to maintain, hard to understand, slow etc.. ?
Always refer to the context in which the code was written. Don't use it
as an excuse to defend anybody's potentially hurt ego, but instead to
explain why the code was written caring about certain values instead of
others. Most code turns emo after a little while, being able to
understand the context, helps a lot the devision process when facing
such code.

![Bad code](/images/matt_aimonetti-code_apology.jpg)

## It's all about expected outcome and context

As developers, we aren't paid to write code, we are paid to build
products, to convert ideas into something "concrete". When I use my
favorite app, I don't care that the code is beautiful, I care that it
works, that it's stable and provides me with what I need. If the code is
written in Go, Pascal, Erlang, VB or Ruby doesn't matter at all. That the
code has full test coverage and was written in an agile manner using
weekly scrums and TDD is probably as important as knowing the Pantone
color of a company's logo: it only matters to the people deeply
involved.

Don't focus on how to build, focus on why you build things. Then the how
will come as you learn from others, experiment and discover "how" to build
the "why". The "why" is often the constant, the "how" keeps on changing
as we collect more information.

## We love rules

When you learn, rules are easier. Katrina made a very good point during
our discussion. When she teaches, she needs to have very strong rules
that she can justify. That said, her rules can change, and as you become
better, you can start challenging the rules. Rules are somewhere between
training wheels and a guard-rail. They are very useful but shouldn't be
used to attack other people.

Ruby has a language doesn't enforce many rules, as a matter of fact,
Matz designed a language so you can set your own rules, or barely have
any rules.
This fact probably explains why so many people are after solid rules
they can rely on. Rules are easy to follow and are a good reference.
The Ruby language doesn't have enough rules to some, so the community is
helping by coming together to define them. 
This is by the way, the biggest difference with Python and Go where
these 2 languages explicitly want to only have 1 way of doing one thing.


## Communication and team work

The key to building a good product (which is what we are paid to do) is
communication. Unfortunately, us developers, are on average, pretty
terrible at that.
We need to do a better job communicating with the rest of the
organization (i.e: anybody who's not an engineer). It usually starts by
the designers. The expected outcome of the product should be clear, well
understood by all and easily evaluable.
Within the engineering team, coding values should be set explicitly.
Not everyone will agree but when we write code, we should all care about
the same overall values so our work is consistent. When something
happens and we have a disagreement, it's easier to refer to our values
to decide what solution to pick.


## Slides

<script async class="speakerdeck-embed" data-id="f325aee016620131a63906e09cf22df5" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

## Video

<iframe width="640" height="480" src="//www.youtube.com/embed/VO-NvnZfMA4" frameborder="0" allowfullscreen></iframe>
