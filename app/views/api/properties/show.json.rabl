object @listing

attributes :ListingID, :ListAgentAgentId, :SaleAgentAgentID, :ListingKey, :City, :County, :FullStreetAddress, :State, :ZipCode, :ZipCodePlusFour, :DistanceToBeachInMiles, :Area, :DirectionFaces, :Latitude, :Longitude, :BuildingSize, :LotSizeSQFT, :ListingDate, :PropertyType, :BathsTotal, :BedroomsTotal, :ListingModificationDate, :ListingStatus, :OriginalListPrice, :OtherStructures, :PricePerSqft, :UniqueID, :TotalPhotoCount, :LastPhotoDate, :LastMediaDate, :CookingAppliances, :DisabilityAccess, :Fence, :FireplaceRooms, :FloorMaterial, :FoundationDetails, :InteriorFeatures, :KitchenFeatures, :Roofing, :SecuritySafety, :SpaConstruction, :SpaDescriptions, :Sprinklers, :TVServices, :Levels, :Windows, :BedroomFeatures, :Rooms, :CoolingType, :HeatingType, :HeatingFuel, :LaundryLocations, :Sewer, :Water, :WaterDistrict, :WaterHeaterFeatures, :YearBuilt, :SpecialConditions, :BuildersName, :LotDescription, :ParkingFeatures, :GarageSpacesTotal, :CarportSpacesTotal, :CoveredSpacesTotal, :ParkingType, :BuildersTractName

node(:PublicRemarks){ |pr| pr.PublicRemarks.capitalize }
node(:ListPrice) { |lp| number_to_currency(lp.ListPrice.to_s.to_f, :precision => 0) }
