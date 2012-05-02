# FALL RIVER IDX
Hello, this is the IDX backend for Dustin Boling Associates real estate sites. Just your basic RESTful JSON api. Post to our url, get back the data you requested. Data is updated every four hours with new properties.

# PROPERTY SEARCH API
The property search api takes requests here:

```ruby
http://fallriveridx.heroku.com/api/search.json?
```

Here is what a full request looks like:

```ruby
http://fallriveridx.heroku.com/api/search.json?ListAgentAgentID=A00000111&City=Newport%20Beach&Price=<750000
```

These are the acceptable parameters that are currently searchable from our property api:
* City
* ZipCode
* ListAgentAgentID
* ListPrice (ex: ListPrice=>450000)
* BedroomsTotal (returns greater than or equal to the number given)
* BathsTotal (returns greater than or equal to the number given)
* LotSizeSQFT (returns greater than or equal to the number given)

# SINGLE PROPERTY DETAILS
This is what a single property search looks like. It only takes one parameter, ListingID.

```ruby
http://fallriveridx.heroku.com/api/show.json?ListingID=P12345678
```
