---
layout: post
title: "Practical guide to Graphite monitoring"
date: 2013-06-26 10:26
comments: true
categories: 
- monitoring
- tool
- tutorial
---

Most engineers love to improve things. Refactoring and optimizations
drives a lot of us. There is just a slight problem, we often do that in a vacuum.
Before optimizing, we need to *measure*. Without a solid base line, how
can you say that the time you invested in making things better wasn't a
total waste? Most refactoring is done with a solid test suite in place.
Developers know that their code behavior didn't change while they
cleaned things up. Performance optimization is the same thing, we need a
good set of metrics before tweaking things.

There are plenty of monitoring tools out there, they all have their pros
and cons. The point of this article isn't to argue about which one *you* should use, 
but instead to give you the some practical knowledge to better use [Graphite](http://graphite.readthedocs.org/en/latest/overview.html).

![Screenshot of the Graphite UI](/images/graphite_fullscreen_800.png)

Graphite is used to store and render time-series data. In other words,
you collect metrics and Graphite allows you to create pretty graphs with
your data. During my time at LivingSocial, I heavily used Graphite to
understand trends, issues and to help me optimize performance. As my coworkers
and I were talking my recently announced departure, I asked them how I
could help them during the transition period. Someone mentioned creating a 
Graphite cheatsheet. LivingSocial was nice enough to let me publicly publish this
short guide.

## Organizing metrics

There are [many ways](http://graphite.readthedocs.org/en/latest/tools.html) to feed Graphite, 
I personally used statsd which was being fed via the [statsd RubyGem](https://github.com/reinh/statsd).
The gem allows developers to push recorded metrics to a statsd server
via UDP. Using UDP instead of TCP makes the metrics collection operation
non blocking which means that while you might lose a few samples, your
instrumented code performance shouldn't be affected.

** Tip **: Doing DNS resolution on each call can be a bit expensive (a
few ms), target your statsd server using its ip or use Ruby's [resolv](http://www.ruby-doc.org/stdlib-2.0/libdoc/resolv/rdoc/Resolv/DNS.html#method-i-getaddress)
standard library to only do the lookup once at initialization.


(skipping the config settings about storage retention, resolution etc.. see the
manual)

### Namespacing

Always namespace your collected data, even if you only have one app for
now. If your app does two things at the same time like serving HTML and
providing an API, you might want to create two clients namespaced
differently.

### Naming metrics

Properly naming your metrics is critical to avoid conflicts,
confusing data and potentially wrong data interpretation later on.
I like to organize metrics using the following schema:

```
 <namespace>.<instrumented section>.<target>.<action>
```

Example:

```
accounts.authentication.password.attempted
accounts.authentication.password.succeeded
accounts.authentication.password.failed
```

I usually use nouns to define the target and past tensed verbs to define
the action. This becomes a useful convention when you need to nest
metrics. In the above example, let say I want to monitor the reasons for
the failed password authentications. Here is how I would organize the
extra stats:

```
accounts.authentication.password.failure.no_email_found
accounts.authentication.password.failure.password_check_failed
accounts.authentication.password.failure.password_reset_required
```

As you can see, I used `failure` instead of `failed` in the stat name.
The main reason is to avoid conflicting data. `failed` is an action and
already has a data series allocated, if I were to add nested data using
`failed`, the data would be collected but the result would be confusing.
The other reason is because when we will graph the data, we will often
want to use a wildcard `*` to collect all nested data in a series.

Graphite wild card usage example on counters:

```
accounts.authentication.password.failure.*
```

This should give us the same value as `accounts.authentication.password.failed`,
 so really, we should just collect the more detailed version and get rid
of `accounts.authentication.password.failed`.

Following this convention should really help your data stay clean and
easy to manage. 


## Counters and metrics

StatsD lets you record different types of metrics as illustrated [here](https://github.com/etsy/statsd/blob/master/docs/metric_types.md).
I'm going to focus on the 2 main types:

* counter
* timers

Use counters for metrics when you don't care about how long the code
your are instrumenting takes to run. Usually counters are used for data
that have more of a business sense . Examples include sales,
authentication, signups etc..

Timers are more powerful because they can be used to analyze the time
spent in a piece of code but also be used as a counters. Most of my work
involves timers because I care to detect system anomalies including performance 
changes and trend modifications in the way code is being used.

I usually use timers in a nested manner starting from whenever a request
comes in the system to all the way to the time spent in the various
datastores.


## Monitoring response time

It's a well known fact that the response time of your application will
affect the user experience and often the financial outcome of their
visits.
However understanding where time is being spent within a request is
hard, especially when the problems aren't obvious. Tools like
[NewRelic](http://newrelic.com/) will often get you a good overview of 
how your system behave but they also lack the granularity you might
need. For instance NewRelic aggregates and averages the data client side
before sending it to their server. While this is fine in a lot of cases,
if you care about outliers and more detailed metrics, you probably need
to run your own solution such as statsd + graphite.

It does however require you get your hands dirty. For most of my web
APIs I use [wd_sinatra](https://github.com/mattetti/wd-sinatra) which
has a `pre_dispatch_hook` method.

``` ruby
def pre_dispatch_hook
  api_client = extract_api_client_name(env)
  Thread.current[:stats_context] = "#{api_client}.http.#{env['wd.service'].verb}.#{env['wd.service'].url}".gsub('/', '.')
  # [...]
end
```

Then using Sinatra's global before/after filters, we can set a unique
request id (Rails does that automatically) and start a timer.

Before filter:

```ruby
require 'securerandom'

before do
  Thread.current[:request_id] = request.env['HTTP_X_REQUEST_ID'] || SecureRandom.hex(16)
  response['X-Request-Id'] = Thread.current[:request_id]
  @instrumentation_start = Time.now
end
```

After filter:

```ruby
after do
  stat = (Thread.current[:stats_context] || "http.skipped.#{env["REQUEST_METHOD"]}.#{request.path_info}") + ".response_time"
  $statsd.timing(stat, ((Time.now - @instrumentation_start) * 1000).round, 1) if @instrumentation_start
end
```

Note that I could/should have written a Rack middleware to do that. This is
the approach I would recommend if you want to instrument Rails (and
probably Sinatra).

A middleware would look something like that (untested code):

```ruby
# require whatever is needed and set statsd

class Stats
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      Thread.current[:request_id] = request.env['HTTP_X_REQUEST_ID'] || SecureRandom.hex(16)
      response['X-Request-Id'] = Thread.current[:request_id]
      api_client = extract_api_client_name(env)
      Thread.current[:stats_context] = "#{api_client}.http.#{request.request_method}.#{request.path_info}".gsub('/', '.')
      @instrumentation_start = Time.now

      response = @app.call(env)
      
      stat = (Thread.current[:stats_context] || "http.skipped.#{env["REQUEST_METHOD"]}.#{request.path_info}") + ".response_time"
      $statsd.timing(stat, ((Time.now - @instrumentation_start) * 1000).round, 1) if @instrumentation_start
      response
    end

  end
end
```


## Monitor time spent within a response

Now this is great, we're collecting stats regarding all our requests so
we can see request counts, medium, median average response times. 
But wouldn't be better if we could measure the time spent in specific
parts of our code base and compare that to the overall time spent in the
request? We could for instance compare the time spent in the DB vs Redis
vs Memcached vs the framework. And what's nice is that we could do that
per API endpoint and per API client.

In a simple website, you probably won't be extracting a client name, but
you might decide to monitor mobile vs desktop. The principle is the
same.

Let's hook into ActiveRecord's query generation to track the time spent
in AR within each request:

```ruby
module MysqlStats
  module Instrumentation
    SQL_INSERT_DELETE_PARSER_REGEXP = /^(\w+)\s(\w+)\s\W*(\w+)/
    SQL_SELECT_REGEXP = /select .*? FROM \W*(\w+)/i
    SQL_UPDATE_REGEXP = /update \W*(\w+)/i
 
    # Returns the table and query type
    def self.extract_from_sql_inserts_deletes(query)
      query =~ SQL_INSERT_DELETE_PARSER_REGEXP
      [$3, $1]
    end
 
    def self.extract_sql_selects(query)
      query =~ SQL_SELECT_REGEXP
      [$1, 'SELECT']
    end
 
    def self.guess_sql_content(query)
      if query =~ SQL_UPDATE_REGEXP 
        [$1, 'UPDATE']
      elsif query =~ SQL_SELECT_REGEXP
        extract_sql_selects(query)
      end
    end
  end
end
 
ActiveSupport::Notifications.subscribe "sql.active_record" do |name, start, finish, id, payload|
  if payload[:name] == "SQL"
    table, action = MysqlStats::Instrumentation.extract_from_sql_inserts_deletes(payload[:sql])
  elsif payload[:name] =~ /.* Load$/
    table, action = MysqlStats::Instrumentation.extract_sql_selects(payload[:sql])
  elsif !payload[:name]
    table, action = MysqlStats::Instrumentation.guess_sql_content(payload[:sql])
  end
 
  if table
    $statsd.timing("#{Thread.current[:stats_context] || 'wild'}.sql.#{table}.#{action}.query_time",
                        (finish - start) * 1000, 1)
 
  end
end
```

This code might not be pretty but it works (or should work).
We subscribe to `ActiveSupport::Noitifications` for `sql.active_record`
and we extract the info we need. Then we use the stats context set in
the thread and report the stats by adding
`.sql.#{table}.#{action}.query_time`

The final stats entry could look like that:
`auth_api.ios.http.post.v1.accounts.sql.users.SELECT.query_time`

* auth_api: the name of the monitored app
* ios: the client name
* http: the protocol used (you might want to monitor thrift, spdy etc..
* post: HTTP verb
* v1.accounts: the converted uri: /v1/accounts
* sql: the key for the SQL metrics
* users: the table being queried
* SELECT: the SQL query type
* query_time: the kind of data being collected.

As you can see, we are getting granular data. Depending on how you setup
statsd/graphite, you could have access to the following timer data for
each stat (and more):

* count
* lower
* mean
* mean_5
* mean_10
* mean_90
* mean_95
* median
* sum
* upper
* upper_5
* upper_10
* upper_90
* upper_95


## Dashboards



## Cheatsheet

Naming:

```
 <namespace>.<instrumented section (noun)>.<target (noun)>.<action (past tense)>
```

