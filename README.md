shipstation-ruby
================

This is a Ruby wrapper for [ShipStation](http://www.shipstation.com/)'s [OData API](http://api.shipstation.com/MainPage.ashx).

This is version 0.0.1 of the gem.  It currently only supports querying and filtering of ShipStation resources.

## Installation

ShipStation-Ruby is packaged as a Ruby gem. I recommend you install it with [Bundler](http://gembundler.com/) by adding the following line to your Gemfile:

``` ruby
gem 'shipstation-ruby', '~> 0.0.1'
```

## Rails Configuration

The ShipStation API uses basic HTTP authentication. Inside config/initializers, create a new configuration file and use the following template to pass in your ShipStation credentials:

``` ruby
ShipStationRuby.username  = ENV['SHIPSTATION_USERNAME']
ShipStationRuby.password  = ENV['SHIPSTATION_PASSWORD']
```

## Usage

### Set your credentials and create a new client:
``` ruby
ShipStationRuby.username  = "shipstation_username"
ShipStationRuby.password  = "shipstation_password"
client = ShipStationRuby::Client.new
```

### Or create a new client by passing credentials directly:
``` ruby
client = ShipStationRuby::Client.new("shipstation_username", "shipstation_password")
```
### Query a resource by record id:
``` ruby
order = client.order.find(12345)
```

### Get all records for any given resource in an array (paginated in batches of 100):
``` ruby
orders = client.order.all
```

### Query records for any resource by any attribute, returns an array:
``` ruby
open_texas_orders = client.order.where("active" => "true", "ship_state" => "TX")
```

### Other resources follow a similar pattern
``` ruby
all_warehouses = client.warehouse.all
customer_12345 = client.customer.find(12345)
texas_fedex_shipments = client.shipment.where("shipping_service_id" => 0001, "state" => "TX")
```
etc.

### Once returned, resources can be queried by field name
``` ruby
client = ShipStationRuby::Client.new
order = client.order.find(12345)

order.order_id ## 12345
order.ship_city ## Boise
order.order_total ## $343.32
```

## Requirements
This gem has been tested on Ruby 1.9.3 on version 1.1 of ShipStation's API.

## Bugs
Please report bugs at https://github.com/codyduval/shipstation-ruby/issues

## Note on Patches/Pull Requests
* Fork the project from https://github.com/codyduval/shipstation-ruby/
* Make your feature addition or bug fix.
* Add tests
* Commit
* Send me a pull request. Bonus points for topic branches.

## Thanks
Thanks to [Nate Berkopec](https://github.com/nateberkopec) for advice and guidance.

## License

(The MIT License.)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
