# FALL RIVER IDX
Hello, this is the IDX for Dustin Boling Associates real estate sites. Just your basic RESTful JSON api. Post to our url, get back the data you requested. Property data is updated every four hours with new properties, along with all of the active agents in the CARETS system.

## PROPERTY API

### Search
The property search api takes requests here:

```ruby
http://fallriveridx.heroku.com/api/properties/search.json?[yourQuery][yourToken]
```

Here is what a full request looks like:

```ruby
http://fallriveridx.heroku.com/api/properties/search.json?ListAgentAgentID=A00000111&City=Newport%20Beach&Price=<750000&Token=yourToken
```

These are the acceptable parameters that are currently searchable from our property api:
* City
* ZipCode
* BuildersTractName
* ListAgentAgentID (This is the agent)
* SaleAgentAgentID (This is the broker)
* ListPrice (Must provide greater than or equal to. ex: ListPrice=>450000 will return houses listed at $450,000 or more)
* BedroomsTotal (returns greater than or equal to the number given)
* BathsTotal (returns greater than or equal to the number given)
* BuildingSizeSQFT (returns greater than or equal to the number given)

### Show (Single Property Details)
This is what a single property search looks like. It only takes one parameter, ListingID, along with your token.

```ruby
http://fallriveridx.heroku.com/api/properties/show.json?ListingID=P12345678&Token=yourToken
```

## GEOCODE API
The geocode api takes requests here at the index action:

```ruby
http://fallriveridx.heroku.com/api/geocode/index.json?[yourQuery][yourToken]
```

### Boundary Search
It requires the following parameters, using only these will return at maximum 40 homes from within the boundary area. 
* ne_long 
* ne_lat 
* sw_long
* sw_lat

In addition to the required parameters you can also pass in the following:
* ListPrice
* BedroomsTotal
* BathsTotal
* BuildingSizeSQFT

### Search by City


## ACCOUNTS API
The accounts api takes requests here:

```ruby
http://fallriveridx.heroku.com/api/accounts/
```

There are currently 3 types of requests: show, create and update. Create is **disabled**!

### Show
Gets basic details for an account. Anything needed for verifying that an account is valid. It accepts the following fields:
* Token

Example:
``` ruby
http://fallriveridx.heroku.com/api/accounts.show.json?Token=yourToken
```

### Update
Updates an account. Right now all you can do is update the site_url field. This also updates the ip address.
* UpdateSiteUrl =  true

Here is an example request which updates a customer's active site url. It uses the referrer from the header, so whatever site is sending the request will be the site & ip which is written to the database.

```ruby
http://fallriveridx.heroku.com/api/accounts/update.json?UpdateSiteUrl=true&Token=yourToken
```

### Create
**Currently Disabled**
Creates a new account. This request requires that **all** of the following parameters be passed:
* username
* email (customer's email)
* some method of verifying that the request is coming from our plugin, and authentic.

Here is an example request that creates a new account:

```ruby
http://fallriveridx.heroku.com/api/accounts/create.json?username=whatever&email=example@foo.com
```
