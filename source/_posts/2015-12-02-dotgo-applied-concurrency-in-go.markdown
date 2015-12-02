---
layout: post
title: "Applied Concurrency in Go"
date: 2015-12-02 08:20
comments: true
categories: 
- Presentation
- Golang
slides: https://speakerd.s3.amazonaws.com/presentations/c55aca1f604545abbbc143ca65171ec7/dotGo2015.pdf
---

<img src="https://farm6.staticflickr.com/5688/22350810834_20caad1e11_k_d.jpg" class="">

Back in November I was in Paris for [dotGo](http://www.dotgo.eu/), one of my favorite Golang conferences.
I was invited to speak and wanted to share something concrete with the audience, something based on my
experience with [Go](http://golang.org) at [Splice](https://splice.com). Go is designed for simplicity 
with only one way of doing one thing. That makes preparing talks pretty challenging since a lot has already been said
and there is not much more to add. A lot of us pick Go because it's has concurrency built-in, but it doesn't mean that
writing efficient concurrent code is instinctive or obvious.

I walked the audience through the parallelization of code execution and all the mistakes we usually make.
Using an Arduino and a set of LEDs, I show how goroutines operate and how to write working Go code.

[Official post about the talk](http://www.thedotpost.com/2015/11/matt-aimonetti-applied-concurrency-in-go)

## Video

<iframe width="720" height="480" src="https://www.youtube.com/embed/TI8OW22WZvQ" frameborder="0" allowfullscreen></iframe>

## Slides

<script async class="speakerdeck-embed" data-id="c55aca1f604545abbbc143ca65171ec7" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>