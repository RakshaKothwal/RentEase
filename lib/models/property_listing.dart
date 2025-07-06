import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyListing {

  String? id;
  

  String? propertyType;
  String? title;
  String? description;


  String? address;
  String? landmark;
  String? city;
  String? state;
  String? pinCode;


  String? furnishingStatus;
  List<String>? preferredTenant;
  String? preferredGender;
  String? mealAvailability;
  List<String>? selectedMeals;
  List<String>? sharingType;
  String? numberOfBedrooms;
  String? numberOfBathrooms;
  String? parkingAvailability;
  String? totalNumberOfBeds;
  String? noticePeriod;


  List<String>? propertyImages;


  List<String>? selectedAmenities;
  List<String>? selectedHouseRules;
  String? additionalRules;


  String? expectedRent;
  String? securityDeposit;
  String? maintenanceCharges;


  String? ownerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isActive;

  PropertyListing({
    this.id,
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
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  factory PropertyListing.fromFirestore(Map<String, dynamic> data, String docId) {
    return PropertyListing(
      id: docId,
      propertyType: data['propertyType'] as String?,
      title: data['title'] as String?,
      description: data['description'] as String?,
      address: data['address'] as String?,
      landmark: data['landmark'] as String?,
      city: data['city'] as String?,
      state: data['state'] as String?,
      pinCode: data['pinCode'] as String?,
      furnishingStatus: data['furnishingStatus'] as String?,
      preferredTenant: data['preferredTenant'] != null
          ? List<String>.from(data['preferredTenant'])
          : null,
      preferredGender: data['preferredGender'] as String?,
      mealAvailability: data['mealAvailability'] as String?,
      selectedMeals: data['selectedMeals'] != null
          ? List<String>.from(data['selectedMeals'])
          : null,
      sharingType: data['sharingType'] != null
          ? List<String>.from(data['sharingType'])
          : null,
      numberOfBedrooms: data['numberOfBedrooms'] as String?,
      numberOfBathrooms: data['numberOfBathrooms'] as String?,
      parkingAvailability: data['parkingAvailability'] as String?,
      totalNumberOfBeds: data['totalNumberOfBeds'] as String?,
      noticePeriod: data['noticePeriod'] as String?,
      propertyImages: data['propertyImages'] != null
          ? List<String>.from(data['propertyImages'])
          : null,
      selectedAmenities: data['selectedAmenities'] != null
          ? List<String>.from(data['selectedAmenities'])
          : null,
      selectedHouseRules: data['selectedHouseRules'] != null
          ? List<String>.from(data['selectedHouseRules'])
          : null,
      additionalRules: data['additionalRules'] as String?,
      expectedRent: data['expectedRent'] as String?,
      securityDeposit: data['securityDeposit'] as String?,
      maintenanceCharges: data['maintenanceCharges'] as String?,
      ownerId: data['ownerId'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      isActive: data['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
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
      'ownerId': ownerId,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'isActive': isActive,
    };
  }
}
