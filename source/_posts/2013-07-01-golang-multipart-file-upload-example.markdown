---
layout: post
title: "Golang multipart file upload example"
date: 2013-07-01 22:28
comments: true
categories: 
- blog-post
- golang
- tutorial
---

The Go language is one of my favorite programming languages. However,
sometimes doing simple things can seem a bit harder than it should.
However, most of the time, the problem is just to find out how to
do things the easy way. While Go's documention isn't bad, the real key
to finding out how to do things is often to look at the [source code](http://golang.org/src/pkg/mime/multipart/) and
the [test suite](http://golang.org/src/pkg/mime/multipart/multipart_test.go).

I'm not yet super familiar with all the std lib packages, so when I
wanted to test my Go web services, I wrote a few lines of code to create
a multipart file upload function that was building the body from scratch.
Once I was done messing with the various headers, boundary protocol etc..
I started testing some edge cases, I found some bugs in my code.
Looking at Go's packages, I realized that all the tools were already
available for me to use. I was just lacking a good example. Walking
through the test suite I finally figured out how to write a simple
multipart file upload example with some extra query params. 

Hopefully this example will be helpful to some of you.

```go
package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"os"
)

// Creates a new file upload http request with optional extra params
func newfileUploadRequest(uri string, params map[string]string, paramName, path string) *http.Request {
	file, _ := os.Open(path)
	fileContents, _ := ioutil.ReadAll(file)
	fi, _ := file.Stat()

	body := new(bytes.Buffer)
	writer := multipart.NewWriter(body)
	{
		part, _ := writer.CreateFormFile(paramName, fi.Name())
		part.Write(fileContents)

		for key, val := range params {
			_ = writer.WriteField(key, val)
		}
	}
	writer.Close()
	req, _ := http.NewRequest("POST", uri, body)
  req.Header.Add("Content-Type", writer.FormDataContentType())
	return req
}

func main() {
	path, _ := os.Getwd()
	path += "/test.pdf"
	extraParams := map[string]string{
		"title":       "My Document",
		"author":      "Matt Aimonetti",
		"description": "A document with all the Go programming language secrets",
	}
	request := newfileUploadRequest("https://google.com/upload", extraParams, "file", "/tmp/doc.pdf")
	client := &http.Client{}
	resp, err := client.Do(request)
	if err != nil {
		panic(err)
	} else {
		fmt.Println(resp.StatusCode)
		fmt.Println(resp.Header)
		var bodyContent []byte
		resp.Body.Read(bodyContent)
		fmt.Println(bodyContent)
	}
}
```

All the work is done in the `newfileUploadRequest` function and
really, the `mime/multipart` package hides all the complexity of
creating a multipart request.

The key is to set a new `multipart.Writer`:

```go
writer := multipart.NewWriter(body)
```

The writer will do all the work and writes directly to our body (which itself is a buffer of bytes).

We then create a part for the file form entry with the name of the file
param and the name of the file (that we extracted using the `os`
package).
We need to add the content of the file to the file part, we use the
[`writer` interface](http://golang.org/pkg/io/#Writer) to do so.

```go
part, _ := writer.CreateFormFile(paramName, fi.Name())
part.Write(fileContents)
```

The `multipart.Writer` takes care of setting the boundary and formating
the form data for us, nice isn't it?!

Then for any extra params passed as a map of string keys to string
value, we use another function of the `multipart.Writer` type:

```go
writer.WriteField(key, val)
```

Once again, the writer takes care of creating the right headers, and to
add the passed value.

At this point, we just need to close our writer and use our body to
create a new request.

```go
writer.Close()
req, _ := http.NewRequest("POST", uri, body)
```

One last thing before triggering our request, we need to set the header
that contains the content type including the boundary being used. 
Once again, the Go lib has us covered:

```go
req.Header.Add("Content-Type", writer.FormDataContentType())
```


As a reference, here is the generated body:

```
--0d940a1e725445cd9192c14c5a3f3d30ea9c90f1f5fb9c08813b3fc2adee
Content-Disposition: form-data; name="file"; filename="doc.pdf"
Content-Type: application/octet-stream

%PDF-1.4
%????
4 0 obj
<</Type /Catalog
// removed for example
trailer
<</Size 18
/Root 4 0 R
>>
startxref
45054
%%EOF
--0d940a1e725445cd9192c14c5a3f3d30ea9c90f1f5fb9c08813b3fc2adee
Content-Disposition: form-data; name="title"

My Document
--0d940a1e725445cd9192c14c5a3f3d30ea9c90f1f5fb9c08813b3fc2adee
Content-Disposition: form-data; name="author"

Matt Aimonetti
--0d940a1e725445cd9192c14c5a3f3d30ea9c90f1f5fb9c08813b3fc2adee
Content-Disposition: form-data; name="description"

A document with all the Go programming language secrets
--0d940a1e725445cd9192c14c5a3f3d30ea9c90f1f5fb9c08813b3fc2adee--

```

Golang might not be as high level as Ruby or Python, but it's not too
far off and it certainly comes with some great std libs.
I know I caught myself writing a lot of the small scripts in Go,
something I used to do in Ruby. I think that this is mainly due to the
fact that Go is compiled, designed for concurrency, has great std libs and 
is quite easy to write.

_Hopefully this code sample illustrates how easy Go can be and can also
serve as a reference point if you are looking for a way to do multipart
upload._
