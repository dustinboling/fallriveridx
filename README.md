# FALL RIVER IDX
Hello, this is the IDX backend for Dustin Boling Associates real estate sites.

- URI returns query string
- Updates from CARETS every four hours

# PROPERTY SEARCH API
The property search api takes requests here:

```
http://fallriveridx.heroku.com/api/search.json?
```

Here is what a full request looks like:

```
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

```
http://fallriveridx.heroku.com/api/show.json?ListingID=P12345678
```
