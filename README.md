[![Build Status](https://travis-ci.org/kamui/rack-accept_headers.png)](https://travis-ci.org/kamui/rack-accept_headers)

## I'm working on a replacement for this gem called [accept_headers](https://github.com/kamui/accept_headers).

**Rack::AcceptHeaders** is a suite of tools for Ruby/Rack applications that eases the
complexity of building and interpreting the Accept* family of [HTTP request headers][rfc].

This is a fork of [rack-accept](https://github.com/mjijackson/rack-accept). The
major addition being accept-extension parameter support.

Some features of the library are:

  * Strict adherence to [RFC 2616][rfc], specifically [section 14][rfc-sec14]
  * Full support for the [Accept][rfc-sec14-1], [Accept-Charset][rfc-sec14-2],
    [Accept-Encoding][rfc-sec14-3], and [Accept-Language][rfc-sec14-4] HTTP
    request headers
  * May be used as [Rack][rack] middleware or standalone
  * A comprehensive [test suite][test] that covers many edge cases

[rfc]: http://www.w3.org/Protocols/rfc2616/rfc2616.html
[rfc-sec14]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html
[rfc-sec14-1]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
[rfc-sec14-2]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.2
[rfc-sec14-3]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3
[rfc-sec14-4]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
[rack]: http://rack.rubyforge.org/
[test]: http://github.com/kamui/rack-accept_headers/tree/master/test/

## Installation

Add this line to your application's Gemfile:

    gem 'rack-accept_headers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-accept_headers

Or install it from a local copy:

    $ git clone git://github.com/kamui/rack-accept_headers.git
    $ cd rack-accept_headers
    $ rake package
    $ rake install

## Usage

**Rack::AcceptHeaders** implements the Rack middleware interface and may be used with any
Rack-based application. Simply insert the `Rack::AcceptHeaders` module in your Rack
middleware pipeline and access the `Rack::AcceptHeaders::Request` object in the
`rack-accept_headers.request` environment key, as in the following example.

```ruby
require 'rack/accept_headers'

use Rack::AcceptHeaders

app = lambda do |env|
  accept = env['rack-accept_headers.request']
  response = Rack::Response.new

  if accept.media_type?('text/html')
    response['Content-Type'] = 'text/html'
    response.write "<p>Hello. You accept text/html!</p>"
  else
    response['Content-Type'] = 'text/plain'
    response.write "Apparently you don't accept text/html. Too bad."
  end

  response.finish
end

run app
```

**Rack::AcceptHeaders** can also construct automatic [406][406] responses if you set up
the types of media, character sets, encoding, or languages your server is able
to serve ahead of time. If you pass a configuration block to your `use`
statement it will yield the `Rack::AcceptHeaders::Context` object that is used for that
invocation.

[406]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.7

```ruby
require 'rack/accept_headers'

use(Rack::AcceptHeaders) do |context|
  # We only ever serve content in English or Japanese from this site, so if
  # the user doesn't accept either of these we will respond with a 406.
  context.languages = %w< en jp >
end

app = ...

run app
```

**Note:** _You should think carefully before using Rack::AcceptHeaders in this way.
Many user agents are careless about the types of Accept headers they send, and
depend on apps not being too picky. Instead of automatically sending a 406, you
should probably only send one when absolutely necessary._

**Rack::AcceptHeaders** supports accept-extension parameter support. Here's an
example:

```ruby
require 'rack/accept_headers'

use Rack::AcceptHeaders

app = lambda do |env|
    SUPPORTED_MEDIA_TYPES = {
      "text/html" => :html
      "application/json" => :json,
      "text/xml" => :xml
    }

  accept = env['rack-accept_headers.request']
  response = Rack::Response.new

  if accept
    media_type = accept.media_type.best_of(SUPPORTED_MEDIA_TYPES.keys)

    # Here, I would return a 415 Unsupported media type, if media_type is nil
    # The unsupported_media_type call is left unimplemented here
    # unsupported_media_type unless media_type

    # To output the media_type symbol
    # puts SUPPORTED_MEDIA_TYPES[media_type]

    # To return a hash of accept-extension params for the given media type
    # puts accept.media_type.params(media_type)

    response['Content-Type'] = media_type
    response.write %Q{{ "message" : "Hello. You accept #{media_type}" }}
  else
    media_type = "*/*"
    response['Content-Type'] = SUPPORTED_MEDIA_TYPES.keys.first
    response.write "Defaulting to #{response['Content-Type']}."
  end

  response.finish
end

run app
```

So, given this `Accept` header:

```
Accept: application/json;version=1.0;q=0.1
```

```ruby
accept = env['rack-accept_headers.request']
params = accept.media_type.params['application/json')
```

The `params` hash will end up with this value:

```ruby
{
  "application/json" : {
    "q" : 0.1,
    "version" : "1.0"
  }
}
```

Additionally, **Rack::AcceptHeaders** may be used outside of a Rack context to provide
any Ruby app the ability to construct and interpret Accept headers.

```ruby
require 'rack/accept_headers'

mtype = Rack::AcceptHeaders::MediaType.new
mtype.qvalues = { 'text/html' => 1, 'text/*' => 0.8, '*/*' => 0.5 }
mtype.to_s # => "Accept: text/html, text/*;q=0.8, */*;q=0.5"

cset = Rack::AcceptHeaders::Charset.new('unicode-1-1, iso-8859-5;q=0.8')
cset.best_of(%w< iso-8859-5 unicode-1-1 >)  # => "unicode-1-1"
cset.accept?('iso-8859-1')                  # => true
```

The very last line in this example may look like a mistake to someone not
familiar with the intricacies of [the spec][rfc-sec14-3], but it's actually
correct. It just puts emphasis on the convenience of using this library so you
don't have to worry about these kinds of details.

## Four-letter Words

  - Spec: [http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html][rfc-sec14]
  - Code: [http://github.com/kamui/rack-accept_headers][code]
  - Bugs: [http://github.com/kamui/rack-accept_headers/issues][bugs]
  - Docs: [http://rdoc.info/github/kamui/rack-accept_headers][docs]

[code]: http://github.com/kamui/rack-accept_headers
[bugs]: http://github.com/kamui/rack-accept_headers/issues
[docs]: http://rdoc.info/github/kamui/rack-accept_headers
