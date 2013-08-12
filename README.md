# CroovyFinance

Brought to you by the good folks at [Croovy](http://croovy.com).

This gem provides a handful of functions useful for working with home
loans. Specifically provided are functions for calculating Internal Rate of
Return (irr) and Net Present Value (npv). Both are implemented as described in
Wikipedia, and using the secant method, also as described in Wikipedia.

* http://en.wikipedia.org/wiki/Internal_rate_of_return
* http://en.wikipedia.org/wiki/Net_present_value
* http://en.wikipedia.org/wiki/Secant_method

Also provided is an function for calculating the Annual Percentage Rate
(apr). It is basically sugar for the irr function, making it callable like the
RATE function found in a Google Docs Spreadsheet or Microsoft Excel.

* https://support.google.com/drive/table/25273?hl=en
* http://office.microsoft.com/en-us/excel-help/rate-function-HP010342819.aspx

## How CroovyFinance differs from Finance

The Finance gem uses Newton's method (while CroovyFinance uses the secant
method), and as a result, CroovyFinance's results are more inline with Excel
and Google Docs. In the author's experience, certain reasonable inputs, when
used with the Finance gem, produced obviously incorrect results.

## Installation

Add this line to your application's Gemfile:

    gem 'croovy_finance'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install croovy_finance

## Usage

```ruby
irb(main):001:0> require "croovy/finance"
=> true
irb(main):002:0> CroovyFinance::Apr.new(360, 1_044.50, 238_650).calc
=> 0.0027456868896171853
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
