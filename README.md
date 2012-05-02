# FALL RIVER IDX
Hello, this is the IDX for Dustin Boling Associates real estate sites. Just your basic RESTful JSON api. Post to our url, get back the data you requested. Data is updated every four hours with new properties, so your feeds will always be up to date.

# PROPERTY SEARCH API

## Search
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
* ListAgentAgentID (This is the agent)
* SaleAgentAgentID (This is the broker)
* ListPrice (Must provide greater than or equal to. ex: ListPrice=>450000 will return houses listed at $450,000 or more)
* BedroomsTotal (returns greater than or equal to the number given)
* BathsTotal (returns greater than or equal to the number given)
* LotSizeSQFT (returns greater than or equal to the number given)

## Show (Single Property Details)
This is what a single property search looks like. It only takes one parameter, ListingID, along with your token.

```ruby
http://fallriveridx.heroku.com/api/properties/show.json?ListingID=P12345678&Token=yourToken
```

ACCOUNTS API
The property search api takes requests here:

```ruby
http://fallriveridx.heroku.com/api/accounts/
```

There are currently 2 types of requests, create and update

## Create
Creates a new account. This request requires that **all** of the following parameters be passed:
* username
* email (customer's email)
* some method of verifying that the request is coming from our plugin, and authentic.

Here is an example request that creates a new account:

```ruby
http://fallriveridx.heroku.com/api/accounts/create.json?username=whatever&email=example@foo.com
```

## Update
Updates an account. Here is an example request which deactivates a customer's active site url:

```ruby
http://fallriveridx.heroku.com/api/accounts/update.json?site_url=NULL
```
