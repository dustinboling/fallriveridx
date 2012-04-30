object @listing

attributes :ListingID, :ListingKey, :BuildingSize, :ListingDate, :PropertyType, :BathsTotal, :BedroomsTotal

node(:ListPrice) { |lp| number_to_currency(lp.ListPrice.to_s.to_f, :precision => 0) }
