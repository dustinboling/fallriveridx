# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120525215127) do

  create_table "agents", :force => true do |t|
    t.text     "AgentDesignations"
    t.text     "AgentDisplayName"
    t.text     "AgentEditor"
    t.text     "AgentFirstName"
    t.text     "AgentFullName"
    t.text     "AgentID"
    t.text     "AgentExternalSystemID"
    t.text     "AgentKey"
    t.datetime "AgentLastLoginDate"
    t.text     "AgentLastName"
    t.text     "AgentLicenseNumber"
    t.text     "AgentMiddleName"
    t.text     "AgentOfficeID"
    t.text     "OfficeKey"
    t.text     "AgentPassword"
    t.text     "AgentPrimaryAssociation"
    t.text     "AgentPrimaryAssociationLkp"
    t.datetime "AgentSourceCreationTimestamp"
    t.datetime "AgentSourceModificationTimestamp"
    t.text     "AgentStatus"
    t.date     "AgentStatusDate"
    t.text     "AgentType"
    t.text     "AgentRole"
    t.text     "AgentUserName"
    t.text     "NRDSMemberID"
    t.text     "AgentSystemLocale"
    t.text     "AgentSubSystemLocale"
    t.datetime "AgentModificationTimestamp"
    t.datetime "AgentPrimaryObjectModificationTs"
    t.boolean  "ListingAddEditYN"
    t.boolean  "AddEditOfficeYN"
    t.boolean  "AddEditSelfYN"
    t.boolean  "ViewRosterYN"
    t.boolean  "EditRosterYN"
    t.text     "AssistantTo"
    t.text     "AgentBlogAddress"
    t.text     "AgentCellPhone"
    t.text     "AgentContactOrder1"
    t.text     "AgentContactOrder2"
    t.text     "AgentContactOrder3"
    t.text     "AgentContactOrder4"
    t.text     "AgentContactOrder5"
    t.text     "AgentContactOrder6"
    t.text     "AgentDirectPhone"
    t.text     "AgentDirectPhoneExt"
    t.text     "AgentEmail"
    t.text     "AgentEmailSignature"
    t.text     "AgentFax"
    t.text     "AgentFullStreetAddress"
    t.text     "AgentHomePhone"
    t.text     "AgentHomePhoneExt"
    t.text     "AgentPager"
    t.text     "AgentPreferredLanguage"
    t.text     "AgentPreferredPhone"
    t.text     "AgentPreferredPhoneExt"
    t.text     "AgentRecordComments"
    t.text     "AgentTollFreePhone"
    t.text     "AgentTollFreePhoneExt"
    t.text     "AgentVoiceMail"
    t.text     "AgentVoiceMailExt"
    t.text     "AgentWWW"
    t.text     "AgentCarrierRoute"
    t.text     "AgentCityName"
    t.text     "AgentPostalCode"
    t.text     "AgentState"
    t.text     "AgentStreetAdditionalInfo"
    t.text     "AgentZip4"
    t.text     "OfficeName"
    t.text     "OfficeStatus"
    t.text     "OfficeOfficePhone"
    t.text     "OfficeOfficePhoneExt"
  end

  create_table "brokers", :force => true do |t|
    t.text     "AgentDesignations"
    t.text     "AgentDisplayName"
    t.text     "AgentEditor"
    t.text     "AgentFirstName"
    t.text     "AgentFullName"
    t.text     "AgentID"
    t.text     "AgentExternalSystemID"
    t.text     "AgentKey"
    t.datetime "AgentLastLoginDate"
    t.text     "AgentLastName"
    t.text     "AgentLicenseNumber"
    t.text     "AgentMiddleName"
    t.text     "AgentOfficeID"
    t.text     "OfficeKey"
    t.text     "AgentPassword"
    t.text     "AgentPrimaryAssociation"
    t.text     "AgentPrimaryAssociationLkp"
    t.datetime "AgentSourceCreationTimestamp"
    t.datetime "AgentSourceModificationTimestamp"
    t.text     "AgentStatus"
    t.date     "AgentStatusDate"
    t.text     "AgentType"
    t.text     "AgentRole"
    t.text     "AgentUserName"
    t.text     "NRDSMemberID"
    t.text     "AgentSystemLocale"
    t.text     "AgentSubSystemLocale"
    t.datetime "AgentModificationTimestamp"
    t.datetime "AgentPrimaryObjectModificationTs"
    t.boolean  "ListingAddEditYN"
    t.boolean  "AddEditOfficeYN"
    t.boolean  "AddEditSelfYN"
    t.boolean  "ViewRosterYN"
    t.boolean  "EditRosterYN"
    t.text     "AssistantTo"
    t.text     "AgentBlogAddress"
    t.text     "AgentCellPhone"
    t.text     "AgentContactOrder1"
    t.text     "AgentContactOrder2"
    t.text     "AgentContactOrder3"
    t.text     "AgentContactOrder4"
    t.text     "AgentContactOrder5"
    t.text     "AgentContactOrder6"
    t.text     "AgentDirectPhone"
    t.text     "AgentDirectPhoneExt"
    t.text     "AgentEmail"
    t.text     "AgentEmailSignature"
    t.text     "AgentFax"
    t.text     "AgentFullStreetAddress"
    t.text     "AgentHomePhone"
    t.text     "AgentHomePhoneExt"
    t.text     "AgentPager"
    t.text     "AgentPreferredLanguage"
    t.text     "AgentPreferredPhone"
    t.text     "AgentPreferredPhoneExt"
    t.text     "AgentRecordComments"
    t.text     "AgentTollFreePhone"
    t.text     "AgentTollFreePhoneExt"
    t.text     "AgentVoiceMail"
    t.text     "AgentVoiceMailExt"
    t.text     "AgentWWW"
    t.text     "AgentCarrierRoute"
    t.text     "AgentCityName"
    t.text     "AgentPostalCode"
    t.text     "AgentState"
    t.text     "AgentStreetAdditionalInfo"
    t.text     "AgentZip4"
    t.text     "OfficeName"
    t.text     "OfficeStatus"
    t.text     "OfficeOfficePhone"
    t.text     "OfficeOfficePhoneExt"
  end

  create_table "listings", :force => true do |t|
    t.text    "BuildingSize"
    t.date    "CancelledDate"
    t.text    "ClosePrice"
    t.date    "ClosingDate"
    t.text    "Country"
    t.boolean "DOMUpdateYN"
    t.date    "CDOMCalculatedDate"
    t.text    "CDOM"
    t.boolean "CDOMUpdateYN"
    t.text    "DOM"
    t.text    "ICDOM"
    t.text    "EntryFloorNumber"
    t.text    "EntryLocation"
    t.date    "ExpirationDate"
    t.text    "LandLeaseAmountPerYear"
    t.date    "LandLeaseExpirationDate"
    t.text    "LastModifiedBy"
    t.text    "ListPriceString"
    t.text    "ListingAgreement"
    t.text    "ListingDate"
    t.date    "ListingEntryDate"
    t.text    "ListingID"
    t.text    "ListingKey"
    t.date    "ListingModificationDate"
    t.date    "ModificationTimestamp"
    t.date    "PrimaryObjectModificationTimestamp"
    t.text    "ListingStatus"
    t.text    "CARETSListingStatus"
    t.text    "LotSizeSource"
    t.date    "OffMarketDate"
    t.text    "OriginalListPrice"
    t.text    "OtherStructures"
    t.date    "PendingDate"
    t.text    "PendingPrice"
    t.text    "PropertyType"
    t.text    "PricePerSqft"
    t.date    "ProjectedActivationDate"
    t.text    "PropertySubType"
    t.boolean "ReciprocalListingYN"
    t.text    "ServiceLevel"
    t.text    "SoldPricePerSqft"
    t.text    "SquareFootageSource"
    t.date    "StatusChangeDate"
    t.text    "TaxLegalBlockNumber"
    t.text    "UniqueID"
    t.text    "UnitsTotalInComplex"
    t.date    "WithdrawnDate"
    t.text    "SystemLocale"
    t.text    "SubSystemLocale"
    t.text    "ListingSubscriptionClassList"
    t.text    "ListingSubscriptionList"
    t.text    "TotalPhotoCount"
    t.date    "LastPhotoDate"
    t.date    "LastMediaDate"
    t.text    "GateCode"
    t.text    "RawCDOM"
    t.text    "RawDOM"
    t.boolean "VOWAutomatedValuationDisplay"
    t.boolean "VOWConsumerComment"
    t.boolean "RPRYN"
    t.boolean "ResetCDOMYN"
    t.date    "HoldDate"
    t.text    "AdNumber"
    t.date    "ActiveDate"
    t.date    "BackupOfferDate"
    t.text    "Appliances"
    t.text    "BuildingStructureStyle"
    t.text    "CommonWalls"
    t.text    "CookingAppliances"
    t.text    "DisabilityAccess"
    t.text    "Doors"
    t.text    "EatingAreas"
    t.text    "ExteriorConstruction"
    t.text    "Fence"
    t.text    "FirePlaceFuel"
    t.text    "FireplaceFeatures"
    t.text    "FireplaceRooms"
    t.text    "FloorMaterial"
    t.text    "FoundationDetails"
    t.text    "HighMidRiseAmenities"
    t.text    "InteriorFeatures"
    t.text    "KitchenFeatures"
    t.text    "NumberOfRemoteControls"
    t.text    "Roofing"
    t.text    "SecuritySafety"
    t.text    "SpaConstruction"
    t.text    "SpaDescriptions"
    t.text    "Sprinklers"
    t.text    "Levels"
    t.text    "TVServices"
    t.integer "TotalFloors"
    t.text    "Windows"
    t.text    "DwellingStories"
    t.text    "GreenBuildingCertification"
    t.text    "GreenEnergyEfficient"
    t.text    "GreenEnergyGeneration"
    t.text    "GreenIndoorAirQuality"
    t.text    "GreenLocation"
    t.text    "GreenSustainability"
    t.text    "GreenWaterConservation"
    t.integer "BathFull"
    t.integer "BathHalf"
    t.integer "BathOneQuarter"
    t.integer "BathThreeQuarter"
    t.text    "BathroomFeatures"
    t.text    "BathsTotal"
    t.text    "BedroomFeatures"
    t.text    "BedroomsTotal"
    t.text    "ShowingContactCompleteName"
    t.text    "ShowingContactType"
    t.text    "Rooms"
    t.text    "UnitFloorInBuilding"
    t.text    "CoolingType"
    t.text    "HeatingFuel"
    t.text    "HeatingType"
    t.text    "LaundryLocations"
    t.text    "Sewer"
    t.text    "Volt220Location"
    t.text    "Water"
    t.text    "WaterDistrict"
    t.text    "WaterHeaterFeatures"
    t.text    "HOAFee1"
    t.text    "HOAFee2"
    t.text    "HOAFeeFrequency1"
    t.text    "OtherAssociationFees"
    t.boolean "HOAYN"
    t.text    "BuyerFinancing"
    t.text    "SoldTerms"
    t.text    "TaxMelloRoos"
    t.text    "SoldTermsMulti"
    t.text    "Inclusions"
    t.boolean "LandLeasePurchaseYN"
    t.text    "LandLeaseType"
    t.text    "LegalDisclosures"
    t.text    "ListPriceLow"
    t.text    "ListingTerms"
    t.text    "Possession"
    t.text    "SellingOfficeCompensationRemarks"
    t.text    "SellingOfficeCompensation"
    t.text    "SellingOfficeCompensationType"
    t.text    "ShowInformationRemarks"
    t.text    "ShowingAccess"
    t.boolean "VariableRateCompensationYN"
    t.text    "YearBuiltSource"
    t.text    "SpecialConditions"
    t.text    "ConcessionsComments"
    t.text    "ConcessionsAmount"
    t.text    "Exclusions"
    t.text    "MemberRemarks"
    t.text    "PublicRemarks"
    t.text    "BuildersModelName"
    t.text    "BuildersName"
    t.text    "BuildersTractCode"
    t.text    "BuildersTractName"
    t.text    "BuildersTractNameOther"
    t.text    "LotDescription"
    t.text    "LotSizeAcres"
    t.text    "LotSizeDimensionDescription"
    t.text    "LotSizeSQFT"
    t.text    "PatioFeatures"
    t.text    "PropertyCondition"
    t.text    "YearBuilt"
    t.text    "Zoning"
    t.text    "GreenYearCertified"
    t.text    "GreenCertificationRating"
    t.text    "GreenCertifyingBody"
    t.text    "GreenHTAindex"
    t.text    "GreenWalkScore"
    t.text    "CarportSpacesTotal"
    t.text    "CoveredSpacesTotal"
    t.text    "GarageSpacesTotal"
    t.text    "OpenOtherSpacesTotal"
    t.text    "ParkingFeatures"
    t.text    "ParkingSpacesTotal"
    t.text    "ParkingType"
    t.text    "RVAccessDimensions"
    t.text    "AltAgentCellPhone"
    t.text    "AltAgentDirectPhone"
    t.text    "AltAgentDirectPhoneExt"
    t.text    "AltAgentEmail"
    t.text    "AltAgentFax"
    t.text    "AltAgentFirstName"
    t.text    "AltAgentHomePhone"
    t.text    "AltAgentHomePhoneExt"
    t.text    "AltAgentLanguages"
    t.text    "AltAgentLastName"
    t.text    "AltAgentID"
    t.text    "AltAgentKey"
    t.text    "AltAgentPager"
    t.text    "AltAgentPreferredFax"
    t.text    "AltAgentPreferredPhone"
    t.text    "AltAgentPreferredPhoneExt"
    t.text    "AltAgentPrimaryAssociation"
    t.text    "AltAgentTollFreePhone"
    t.text    "AltAgentTollFreePhoneExt"
    t.text    "AltAgentVoiceMailExt"
    t.text    "AltAgentVoiceMailPhone"
    t.text    "AltOfficeFax"
    t.text    "AltOfficeID"
    t.text    "AltOfficeName"
    t.text    "AltOfficePhone"
    t.text    "AltOfficePhoneExt"
    t.text    "AltSaleAgentCellPhone"
    t.text    "AltSaleAgentDirectPhone"
    t.text    "AltSaleAgentDirectPhoneExt"
    t.text    "AltSaleAgentEmail"
    t.text    "AltSaleAgentFax"
    t.text    "AltSaleAgentFirstName"
    t.text    "AltSaleAgentHomePhone"
    t.text    "AltSaleAgentHomePhoneExt"
    t.text    "AltSaleAgentLanguages"
    t.text    "AltSaleAgentLastName"
    t.text    "AltSaleAgentID"
    t.text    "AltSaleAgentKey"
    t.text    "AltSaleAgentPager"
    t.text    "AltSaleAgentPreferredFax"
    t.text    "AltSaleAgentPreferredPhone"
    t.text    "AltSaleAgentPreferredPhoneExt"
    t.text    "AltSaleAgentPrimaryAssociation"
    t.text    "AltSaleAgentTollFreePhone"
    t.text    "AltSaleAgentTollFreePhoneExt"
    t.text    "AltSaleAgentVoiceMailExt"
    t.text    "AltSaleAgentVoiceMailPhone"
    t.text    "AltSaleOfficeFax"
    t.text    "AltSaleOfficeID"
    t.text    "AltSaleOfficeName"
    t.text    "AltSaleOfficePhone"
    t.text    "AltSaleOfficePhoneExt"
    t.text    "ContactOrder1"
    t.text    "ContactOrder2"
    t.text    "ContactOrder3"
    t.text    "ContactOrder4"
    t.text    "ContactOrder5"
    t.text    "ContactOrder6"
    t.text    "ListAgentCellPhone"
    t.text    "ListAgentDirectPhone"
    t.text    "ListAgentDirectPhoneExt"
    t.text    "ListAgentEmail"
    t.text    "ListAgentFax"
    t.text    "ListAgentFirstName"
    t.text    "ListAgentHomePhone"
    t.text    "ListAgentHomePhoneExt"
    t.text    "ListAgentLanguages"
    t.text    "ListAgentLastName"
    t.text    "ListAgentAgentID"
    t.text    "ListAgentKey"
    t.text    "ListAgentPager"
    t.text    "ListAgentPreferredFax"
    t.text    "ListAgentPreferredPhone"
    t.text    "ListAgentPreferredPhoneExt"
    t.text    "ListAgentPrimaryAssociation"
    t.text    "ListAgentTollFreePhone"
    t.text    "ListAgentTollFreePhoneExt"
    t.text    "ListAgentVoiceMailExt"
    t.text    "ListAgentVoiceMailPhone"
    t.text    "ListOfficeFax"
    t.text    "ListOfficeId"
    t.text    "ListOfficeName"
    t.text    "ListOfficePhone"
    t.text    "ListOfficePhoneExt"
    t.text    "OtherPhoneDescription"
    t.text    "OtherPhoneExt"
    t.text    "OtherPhoneNumber"
    t.text    "ReciprocalMemberAreaCode"
    t.text    "ReciprocalMemberName"
    t.text    "ReciprocalMemberOfficeName"
    t.text    "ReciprocalMemberPhone"
    t.text    "ReciprocalMemberPhoneExt"
    t.text    "SaleAgentCellPhone"
    t.text    "SaleAgentDirectPhone"
    t.text    "SaleAgentDirectPhoneExt"
    t.text    "SaleAgentEmail"
    t.text    "SaleAgentFax"
    t.text    "SaleAgentFirstName"
    t.text    "SaleAgentHomePhone"
    t.text    "SaleAgentHomePhoneExt"
    t.text    "SaleAgentLanguages"
    t.text    "SaleAgentLastName"
    t.text    "SaleAgentAgentID"
    t.text    "SaleAgentKey"
    t.text    "SaleAgentPager"
    t.text    "SaleAgentPreferredFax"
    t.text    "SaleAgentPreferredPhone"
    t.text    "SaleAgentPreferredPhoneExt"
    t.text    "SaleAgentPrimaryAssociation"
    t.text    "SaleAgentTollFreePhone"
    t.text    "SaleAgentTollFreePhoneExt"
    t.text    "SaleAgentVoiceMailExt"
    t.text    "SaleAgentVoiceMailPhone"
    t.text    "SaleOfficeFax"
    t.text    "SaleOfficeID"
    t.text    "SaleOfficeName"
    t.text    "SaleOfficePhone"
    t.text    "SaleOfficePhoneExt"
    t.boolean "WillConsiderLeaseYN"
    t.text    "AltAgentOfficeKey"
    t.text    "AltSaleAgentOfficeKey"
    t.text    "ListAgentOfficeKey"
    t.text    "SaleAgentOfficeKey"
    t.text    "AltAgentLicenseNumber"
    t.text    "AltSaleAgentLicenseNumber"
    t.text    "ListAgentLicenseNumber"
    t.text    "SaleAgentLicenseNumber"
    t.text    "AltBrokerLicenseNumber"
    t.text    "AltSaleBrokerLicenseNumber"
    t.text    "ListBrokerLicenseNumber"
    t.text    "SaleBrokerLicenseNumber"
    t.text    "OwnersName"
    t.text    "AssociationPhoneNumber"
    t.text    "AssociationPhoneNumberExt"
    t.text    "ManagementCompanyName"
    t.text    "ManagementCompanyName2"
    t.text    "ManagementCompanyPhone"
    t.text    "ManagementCompanyPhoneExt"
    t.text    "ManagementCompanyPhone2"
    t.text    "ManagementCompanyPhone2Ext"
    t.text    "LockBoxLocation"
    t.text    "LockBoxType"
    t.text    "ShowingContactPhone"
    t.text    "ShowingContactPhoneExt"
    t.text    "City"
    t.text    "County"
    t.text    "CrossStreets"
    t.text    "FullStreetAddress"
    t.text    "State"
    t.text    "StreetDirPrefix"
    t.text    "StreetDirSuffix"
    t.text    "StreetName"
    t.integer "StreetNumber"
    t.text    "StreetNumberModifier"
    t.text    "StreetSuffix"
    t.text    "StreetSuffixModifier"
    t.text    "UnitNumber"
    t.text    "ZipCode"
    t.text    "ZipCodePlus4"
    t.text    "AssociationAmenities"
    t.text    "AssociationFeesInclude"
    t.text    "AssociationName"
    t.text    "AssociationRules"
    t.text    "BuildersModelCode"
    t.text    "CommunityFeatures"
    t.text    "ElementarySchool"
    t.text    "HOAFeeFrequency2"
    t.text    "HighSchool"
    t.text    "JuniorMiddleSchool"
    t.text    "PlayingCourts"
    t.text    "PoolAccessories"
    t.text    "PoolConstruction"
    t.text    "PoolDescriptions"
    t.text    "DistanceToBeachInMiles"
    t.text    "Area"
    t.text    "AreaOther"
    t.text    "CityOther"
    t.text    "DirectionFaces"
    t.text    "DrivingDirections"
    t.boolean "IsSignOnPropertyYN"
    t.text    "LotLocation"
    t.text    "OtherStructuralFeatures"
    t.text    "SchoolDistrict"
    t.text    "TaxLegalLotNumber"
    t.text    "TaxLegalTractNumber"
    t.text    "TaxParcelNumber"
    t.text    "UnitLocation"
    t.text    "View"
    t.text    "ThomasGuideFullMapString"
    t.integer "ThomasGuideMapPage"
    t.text    "ThomasMapXLetter"
    t.text    "ThomasMapYNumber"
    t.text    "MatchCode"
    t.boolean "GeocodeOverrideYN"
    t.decimal "ListPrice",                          :precision => 14, :scale => 2
    t.decimal "Latitude"
    t.decimal "Longitude"
  end

  add_index "listings", ["BathsTotal"], :name => "index_listings_on_BathsTotal"
  add_index "listings", ["BedroomsTotal"], :name => "index_listings_on_BedroomsTotal"
  add_index "listings", ["City"], :name => "index_listings_on_City"
  add_index "listings", ["FullStreetAddress"], :name => "index_listings_on_FullStreetAddress"
  add_index "listings", ["Latitude"], :name => "index_listings_on_Latitude"
  add_index "listings", ["ListAgentAgentID"], :name => "index_listings_on_ListAgentAgentID"
  add_index "listings", ["ListPrice"], :name => "index_listings_on_ListPrice"
  add_index "listings", ["ListingID"], :name => "index_listings_on_ListingID"
  add_index "listings", ["ListingKey"], :name => "index_listings_on_ListingKey"
  add_index "listings", ["Longitude"], :name => "index_listings_on_Longitude"
  add_index "listings", ["LotSizeSQFT"], :name => "index_listings_on_LotSizeSQFT"
  add_index "listings", ["SaleAgentAgentID"], :name => "index_listings_on_SaleAgentAgentID"
  add_index "listings", ["ZipCode"], :name => "index_listings_on_ZipCode"

  create_table "property_media", :force => true do |t|
    t.text    "PropObjectKey"
    t.text    "PropMediaKey"
    t.text    "PropMediaType"
    t.text    "PropMediaExternalKey"
    t.integer "PropItemNumber"
    t.text    "PropMediaDisplayOrder"
    t.text    "PropMediaSize"
    t.text    "PropMimeType"
    t.text    "PropMediaBytes"
    t.text    "PropMediaFileName"
    t.text    "PropMediaCaption"
    t.text    "PropMediaDescription"
    t.text    "PropMediaURL"
    t.string  "PropMediaCreatedTimestamp"
    t.date    "PropMediaModificationTimestamp"
    t.text    "County"
    t.text    "PropMediaSystemLocale"
    t.text    "PropMediaSubSystemLocale"
    t.text    "UniqueID"
    t.text    "ListingID"
    t.text    "PropertyType"
    t.text    "PropMediaPixelLength"
    t.text    "PropMediaPixelWidth"
  end

  create_table "subscribers", :force => true do |t|
    t.boolean  "active"
    t.text     "website_url"
    t.string   "website_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                       :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "authentication_token"
    t.text     "site_url"
    t.string   "site_ip_address",                 :limit => nil
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
