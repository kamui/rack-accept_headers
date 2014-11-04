## 0.5.1

  * Fix test path in rake test task
  * Lock rack at 1.5.2 and up.

## 0.5.0

  * Add accept-extension parameter support
  * Add Guardfile
  * Add Gemfile
  * Switch from Test::Unit to Minitest
  * Added travis-ci support

## 0.4.3 / July 29, 2010

  * Added support for Ruby 1.9.2

## 0.4 / April 5, 2010

  * Added support for media type queries with multiple range parameters
  * Changed Rack::AcceptHeaders::Header#sort method to return only single values
    and moved previous functionality to Rack::AcceptHeaders::Header#sort_with_qvalues

## 0.3 / April 3, 2010

  * Enhanced Rack middleware component to be able to automatically send a 406
    response when the request is not acceptable

## 0.2 / April 2, 2010

  * Moved all common header methods into Rack::AcceptHeaders::Header module
  * Many improvements to the documentation

## 0.1.1 / April 1, 2010

  * Whoops, forgot to require Rack. :]

## 0.1 / April 1, 2010

  * Initial release
