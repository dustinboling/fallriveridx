# FALL RIVER IDX
Hello, this is the IDX for Dustin Boling Associates real estate sites. Just your basic RESTful JSON api. Post to our url, get back the data you requested. Data is updated every four hours with new properties, so your feeds will always be up to date.

# PROPERTY SEARCH API
The property search api takes requests here:

```ruby
http://fallriveridx.heroku.com/api/search.json?[yourQuery]&[yourToken]
```

Here is what a full request looks like:

```ruby
http://fallriveridx.heroku.com/api/search.json?ListAgentAgentID=A00000111&City=Newport%20Beach&Price=<750000&Token=yourToken
```

These are the acceptable parameters that are currently searchable from our property api:
* City
* ZipCode
* ListAgentAgentID (This is the agent)
* SaleAgentAgentID (this is the broker)
* ListPrice (ex: ListPrice=>450000)
* BedroomsTotal (returns greater than or equal to the number given)
* BathsTotal (returns greater than or equal to the number given)
* LotSizeSQFT (returns greater than or equal to the number given)

# SINGLE PROPERTY DETAILS
This is what a single property search looks like. It only takes one parameter, ListingID, along with your token.

```ruby
http://fallriveridx.heroku.com/api/show.json?ListingID=P12345678&Token=yourToken
```
