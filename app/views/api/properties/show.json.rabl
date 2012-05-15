object @listing

attributes :ListingID, :ListAgentAgentId, :SaleAgentAgentID, :ListingKey, :City, :County, :FullStreetAddress, :State, :ZipCode, :ZipCodePlusFour, :DistanceToBeachInMiles, :Area, :DirectionFaces, :Latitude, :Longitude, :BuildingSize, :LotSizeSQFT, :ListingDate, :PropertyType, :BathsTotal, :BedroomsTotal, :ListingModificationDate, :ListingStatus, :OriginalListPrice, :OtherStructures, :PricePerSqft, :UniqueID, :TotalPhotoCount, :LastPhotoDate, :LastMediaDate, :CookingAppliances, :DisabilityAccess, :Fence, :FireplaceRooms, :FloorMaterial, :FoundationDetails, :InteriorFeatures, :KitchenFeatures, :Roofing, :SecuritySafety, :SpaConstruction, :SpaDescriptions, :Sprinklers, :TVServices, :Levels, :Windows, :BedroomFeatures, :Rooms, :CoolingType, :HeatingType, :HeatingFuel, :LaundryLocations, :Sewer, :Water, :WaterDistrict, :WaterHeaterFeatures, :YearBuilt, :SpecialConditions, :BuildersName, :LotDescription, :ParkingFeatures, :GarageSpacesTotal, :CarportSpacesTotal, :CoveredSpacesTotal, :ParkingType, :BuildersTractName, :EntryFloorNumber, :EntryLocation, :Appliances, :CommonWalls, :Doors, :EatingAreas, :FireplaceFeatures, :FireplaceFuel, :FloorMaterial, :NumberOfRemoteControls, :TotalFloors, :DwellingStories, :GreenBuildingCertification, :GreenEnergyEfficient, :GreenIndoorAirQuality, :GreenLocation, :GreenSustainability, :GreenWaterConservation, :BathFull, :BathHalf, :BathOneQuarter, :BathThreeQuarter, :BuildingStructureStyle, :PropertySubType, :UnitsTotalInComplex, :LotSizeAcres, :PatioFeatures, :PropertyCondition, :GarageSpaces, :OpenOtherSpacesTotal, :ParkingFeatures, :PlayingCourts, :PoolAccessories, :PoolConstruction, :PoolDescriptions, :OtherStructuralFeatures, :View, :Volt220Location, :HOAFee1, :HOAFeeFrequency1, :OtherAssociationFees, :AssociationAmenities, :AssociationFeesInclude, :AssociationName, :AssociationName, :AssociationRules, :CommunityFeatures, :ElementarySchool, :HighSchool, :JuniorMiddleSchool, :PlayingCourts, :SchoolDistrict

node(:PublicRemarks){ |pr| pr.PublicRemarks.split('.').each { |s| s.capitalize }.join(".") }
node(:ListPrice) { |lp| number_to_currency(lp.ListPrice.to_s.to_f, :precision => 0) }
