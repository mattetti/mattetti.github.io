---
layout: post
title: "Sharing Rails Sessions with non-Ruby Apps"
date: 2013-11-30 12:01
comments: true
categories: 
- Ruby
- Golang
---

I wanted to do something I thought would be simple: share sessions between my Rails and Go applications. I wanted to let an authenticated Rails user make JavaScript API calls to an endpoint written in Go. 

Since I own both apps, I thought it would be as simple as sharing the secret session key and re-implementing Rails crypto process in Go. It turned out to be a lot more interesting.

In a nutshell, here is what I discovered:

   * It's totally doable! Here is my [Go package](http://godoc.org/github.com/mattetti/goRailsYourself/crypto) 
   * If you are using a version of Rails older than 4.0, you’d better upgrade ASAP!
   * Rails has been criticized for security issues, but the current solution has been vetted by many experts.
   * Rails serializes session data using Ruby Marshal which means that someone with the secret key can *inject arbitrary code in the session* and it will execute server side. Switch to JSON, MessagePack or other safe serialization formats.
   * Security is (still) hard.

## Rails Cookies are Dangerous

Because Rails serializes and deserializes the session and any encrypted/signed cookies using Ruby's Marshal library, someone with the app secret can wreak havoc. They can embed arbitrary Ruby code into the cookie, and the deserialization server side will execute that code without you noticing. Granted, this requires the attacker to have the app secret, but since 99% of the apps out there have the shared secret in their source code, anyone with access to the source code has this data. It’s not data you can easily rotate when employees leave or when you are done working with contractors. Anybody with the shared secret is a potential attacker. Start by moving this data out of the code base and into environment variables.

Rails doesn’t let you change the default serializer directly. But Rails relies on ActiveSupport for its crypto work and AS supports swapping the serializer. Some people in the community are aware of this issue and monkey patch Rails to serialize their sessions using JSON or other. Here is an [Airbnb article](http://nerds.airbnb.com/upgrading-from-ree-187-to-ruby-193/) mentioning why and how they did it.  
[Airbnb’s patch](https://gist.github.com/jeffyip/4091166) is Rails 3 only and to avoid logging off their users, they convert all Marshalled session to JSON, but if you use their patch, you are still vulnerable to an attack. (Airbnb probably stopped converting sessions after they migrated most of their user base). 
[Here is my Rails 4 monkey patch](https://gist.github.com/mattetti/7624413
) to switch the serialization to JSON (used in production with Rails 4, untested on Rails 3). 
https://gist.github.com/mattetti/7624413

You can modify those solutions to use [MessagePack]( http://msgpack.org/) instead of JSON if you want to fit more data in the 4K cookie size. 

## Understanding Rails Session Encryption

Once I addressed the serialization issue, I had to reimplement the crypto work done by Rails to encode and/or sign the data.
Most of us just rely on our frameworks/libraries to do the right thing, but we rarely look under the hood. I ported the logic to Golang which has an amazing support for crypto (albeit lower level than Ruby).
My [Go package](http://godoc.org/github.com/mattetti/goRailsYourself/crypto)  contains an explanation of the code logic and [the examples](http://godoc.org/github.com/mattetti/goRailsYourself/crypto#pkg-examples) needed to decode/verify as well as encode/sign sessions that are compatible with Rails.

Here is a high level summary of what Rails does when it encodes and signs your session data:

```ruby
key_generator = ActiveSupport::CachingKeyGenerator.new(ActiveSupport::KeyGenerator.new(app_secret_key, iterations: 1000))
derived_secret = key_generator.generate_key("encrypted cookie")
sign_secret = key_generator.generate_key("signed encrypted cookie")
 
encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret) 
session_content = encryptor.encrypt_and_sign({hello: "world"})
```

The `session_content` string is then set as the session cookie value.
Note that you could do that in any Ruby app using `ActiveSupport`. So sharings sessions between Ruby applications (like Rails & Sinatra) is easy.

Technically, there are a lot of things going on. To avoid using the same secret to sign and encode data, Rails relies on derived keys using [PBKDF2](http://en.wikipedia.org/wiki/PBKDF2) (password based key derivation function).
It treats the app secret as a password and applies a pseudorandom function 1000 times (Rails default) using a default salt. The result is a derived key so the original password isn’t shared. The derived key can be regenerated identically if the salt and secret are known (because the function is pseudorandom).

The two derived keys are then passed to the [`MessageEncryptor`](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/message_encryptor.rb) class which uses [`MessageVerifier`](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/message_verifier.rb) to do the signing. The generated keys are 64 bytes long and a key goes to the encryptor while the other goes to the verifier.

The verification is done via [HMAC (SHA1)](http://en.wikipedia.org/wiki/Hash-based_message_authentication_code) and it uses the full 64 byte key.
The encoding is done via [AES 256 CBC](http://en.wikipedia.org/wiki/Advanced_Encryption_Standard) only using the first 32 bytes of the encryption derived key. (Rails will only generate a 32-bytes key for that since that's the expected key length)

The session data is therefore serialized (using Marshal by default) then encoded via AES, then both the encoded string and the [IV](http://en.wikipedia.org/wiki/Initialization_vector) are encoded using base64 and joined in a string using a predefined format.

At this point, the session is encoded but it could be tampered with. To avoid that, Rails signs the encoded data using the verifier (HMAC) and appends the base 64 encoded signature to the encoded data. 

To decode and verify the data, Rails does the same process in reverse using the serializer to deserialize the data.

Note that you can also rely on the the same crypto process to safely encode/sign any data you want to share. If you're ok with the data being user-readable, sign it to make sure it isn't tampered with along the way. If you don't want it to be user-readable, encrypt it first then sign the encrypted data.

## Sharing the Session with Non-Ruby Apps

As apps grow many are moving to a SOA approach. That often means multiple languages living together in production. Sharing a web session can be very useful, especially until you switch to a SSO solution.

The key is to start by having the session data serialized in a format that is available in all your relevent languages. JSON, XML MessagePack, and protobuf are good examples.

The second step is to reimplement the crypto dance I just explained above. The good news is that I’ve already done it for Go so you should be able to port it to other languages (Node, Scala/Clojure/Java, Rust, Elixir, Python or whatever you fancy).

https://github.com/mattetti/goRailsYourself/tree/master/crypto

Even though the test suite isn’t perfect (yet), it should greatly help you through the porting process. To be honest the hardest part was to understand the process, not writing the code. Most languages have decent crypto libraries to do the hard parts for you. But in some cases, like for Go, I had to implement lower level pieces like the PKCS7 padding so I could implement the AES CBC encryption/decryption.

Hopefully this article was helpful and you now better understand how Rails does its session encryption. Once you understand the process Rails uses, you can implement it in any language.

















Rails sessions and signed cookies are serialized using Marshal!

This is an issue for 2 main reasons:


   * Marshal isn’t a standard, it’s often not even compatible between versions of Ruby, I really don’t want to implement a partial version of Marshal in Go.
   * If you have the session secret key, you can put whatever Ruby code in your session and it will execute server side.


The first reason on its own pushed me to look at the code and I noticed a few things, first there isn’t a way to do that even though the underlying elements do support a change of serializer. Secondly, many people in the community are aware of this issue ( http://nerds.airbnb.com/upgrading-from-ree-187-to-ruby-193/ ) and run monkey patched versions of Rails.

The second issue is also quite problematic. In theory, the cookie secret key shouldn’t be in your source code (even though Rails generate a file for that) and nobody should know the prod key. However, in practice, most of your dev team has access to this info. Even with a different serializer, it’s a serious vector of attack since anyone with the key can forge a cookie and login as someone else. But because of the cookie Marshaling, a malicious (ex) employee can execute arbitrary code server side by signing it and putting it in a cookie and letting Rails unmarshal automatically.

This is why I recommend we all quickly switch away from using an unsafe serializer for our Rails cookies and switch to a better default like JSON.

I discussed the issue with the Rails team who understands the problem and would in theory accept a PR to change the default. 
I myself wrote a monkey patch for Rails 4  but I don’t currently have time to prepare a proper pull request (airbnb published a Rails 3 only patch, but I recommend against it since it still unmarshals the cookies).


If you agree that this is a problem, consider two things: 


   * switch your serializer (all your users will need to re-login but you can also take airbnb’s approach temporarily) 

   * help getting this change in the next Rails release by working on a pull request.

