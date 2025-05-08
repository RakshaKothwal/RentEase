class PropertyListing {
  // Basic Details
  String? propertyType;
  String? title;
  String? description;

  // Location Details
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? pinCode;

  // Property Profile
  String? furnishingStatus;
  List<String>? preferredTenant;
  String? preferredGender;
  String? mealAvailability;
  List<String>? selectedMeals;
  List<String>? sharingType;
  // String? sharingType;
  String? numberOfBedrooms;
  String? numberOfBathrooms;
  String? parkingAvailability;
  String? totalNumberOfBeds;
  String? noticePeriod;

  // Images: store file paths or URLs
  List<String>? propertyImages;

  // Amenities and House Rules
  List<String>? selectedAmenities;
  List<String>? selectedHouseRules;
  String? additionalRules;

  // Pricing & Other Details
  String? expectedRent;
  String? securityDeposit;
  String? maintenanceCharges;

  PropertyListing({
    this.propertyType,
    this.title,
    this.description,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.pinCode,
    this.furnishingStatus,
    this.preferredTenant,
    this.preferredGender,
    this.mealAvailability,
    this.selectedMeals,
    this.sharingType,
    this.numberOfBedrooms,
    this.numberOfBathrooms,
    this.parkingAvailability,
    this.totalNumberOfBeds,
    this.noticePeriod,
    this.propertyImages,
    this.selectedAmenities,
    this.selectedHouseRules,
    this.additionalRules,
    this.expectedRent,
    this.securityDeposit,
    this.maintenanceCharges,
  });

  factory PropertyListing.fromJson(Map<String, dynamic> json) {
    return PropertyListing(
      propertyType: json['propertyType'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      landmark: json['landmark'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      pinCode: json['pinCode'] as String?,
      furnishingStatus: json['furnishingStatus'] as String?,
      preferredTenant: json['preferredTenant'] != null
          ? List<String>.from(json['preferredTenant'])
          : null,
      preferredGender: json['preferredGender'] as String?,
      mealAvailability: json['mealAvailability'] as String?,
      selectedMeals: json['selectedMeals'] != null
          ? List<String>.from(json['selectedMeals'])
          : null,
      sharingType: json['sharingType'] != null
          ? List<String>.from(json['sharingType'])
          : null,
      //sharingType: json['sharingType'] as String?,
      numberOfBedrooms: json['numberOfBedrooms'] as String?,
      numberOfBathrooms: json['numberOfBathrooms'] as String?,
      parkingAvailability: json['parkingAvailability'] as String?,
      totalNumberOfBeds: json['totalNumberOfBeds'] as String?,
      noticePeriod: json['noticePeriod'] as String?,
      propertyImages: json['propertyImages'] != null
          ? List<String>.from(json['propertyImages'])
          : null,
      selectedAmenities: json['selectedAmenities'] != null
          ? List<String>.from(json['selectedAmenities'])
          : null,
      selectedHouseRules: json['selectedHouseRules'] != null
          ? List<String>.from(json['selectedHouseRules'])
          : null,
      additionalRules: json['additionalRules'] as String?,
      expectedRent: json['expectedRent'] as String?,
      securityDeposit: json['securityDeposit'] as String?,
      maintenanceCharges: json['maintenanceCharges'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyType': propertyType,
      'title': title,
      'description': description,
      'address': address,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'furnishingStatus': furnishingStatus,
      'preferredTenant': preferredTenant,
      'preferredGender': preferredGender,
      'mealAvailability': mealAvailability,
      'selectedMeals': selectedMeals,
      'sharingType': sharingType,
      'numberOfBedrooms': numberOfBedrooms,
      'numberOfBathrooms': numberOfBathrooms,
      'parkingAvailability': parkingAvailability,
      'totalNumberOfBeds': totalNumberOfBeds,
      'noticePeriod': noticePeriod,
      'propertyImages': propertyImages,
      'selectedAmenities': selectedAmenities,
      'selectedHouseRules': selectedHouseRules,
      'additionalRules': additionalRules,
      'expectedRent': expectedRent,
      'securityDeposit': securityDeposit,
      'maintenanceCharges': maintenanceCharges,
    };
  }
}
