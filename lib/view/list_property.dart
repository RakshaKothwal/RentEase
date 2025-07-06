import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:rentease/view/owner_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../common/common_form.dart';
import '../common/global_widget.dart';
import '../models/property_listing.dart';

class ListProperty extends StatefulWidget {
  final PropertyListing? property;

  const ListProperty({super.key, this.property});

  @override
  State<ListProperty> createState() => _ListPropertyState();
}

class _ListPropertyState extends State<ListProperty> {
  final formKey = GlobalKey<FormState>();

  int activeStep = 0;
  int lastStep = 5;

  List<File> propertyImages = [];
  List<String> existingImages = [];

  String? errorType;

  String? propertyType;

  String? furnishingStatus;
  List<String?> preferredTenant = [];
  List<String?> sharingType = [];
  String? preferredGender;
  List<String> selectedAmenities = [];
  List<String> selectedImages = [];
  List<String> selectedHouseRules = [];

  String? city;
  String? mealAvailability;

  String? numberOfBedrooms;
  String? numberOfBathrooms;
  String? parkingAvailability;

  Map<String, List<String>> amenitiesByPropertyType = {
    'PG': [
      'Air Conditioning',
      'Power Backup',
      'Internet',
      'Water Supply 24/7',
      'Security'
    ],
    'Hostel': ['Lift', 'Security', 'Internet', 'Power Backup', 'Gym'],
    'Flat': [
      'Balcony',
      'Gas Pipeline',
      'Parking',
      'Lift',
      'Swimming Pool',
      'Park'
    ],
    'House': ['Balcony', 'Parking', 'Garden', 'Gas Pipeline', 'Power Backup']
  };

  Map<String, List<String>> houseRulesByPropertyType = {
    'PG': ['Smoking', 'Pets', 'Visitors'],
    'Hostel': ['Drinking', 'Party', 'Visitors'],
    'Flat': ['Smoking', 'Drinking', 'Party'],
    'House': ['Smoking', 'Pets', 'Drinking', 'Party']
  };

  List<String> cities = [
    'surat',
    'pune',
    'ahmedabad',
    'mumbai',
    'bangalore',
    'chennai'
  ];
  List<String> types = ["PG", "Hostel", "Flat", "House"];

  List<String> meals = ['Morning', 'Afternoon', 'Evening'];
  List<String> selectedMeals = [];

  List<String> rooms = ["1BHK", "2BHK", "3BHK"];
  List<String> sharing = [
    "Single Room",
    "Double Sharing",
    "Triple Sharing",
    "3+ sharing"
  ];

  List<String> genderPreference = ["Male", "Female", "Both"];

  final steps = [
    "Basic Details",
    "Location",
    "Property Profile",
    "Photos",
    "Amenities",
    "Pricing",
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController depositController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController noticePeriodController = TextEditingController();
  TextEditingController totalBedController = TextEditingController();
  TextEditingController additionalController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.property != null) {
      _prefillFormData();
    }
  }

  void _prefillFormData() {
    final property = widget.property!;
    

    titleController.text = property.title ?? '';
    descriptionController.text = property.description ?? '';
    addressController.text = property.address ?? '';
    landmarkController.text = property.landmark ?? '';
    cityController.text = property.city ?? '';
    pinCodeController.text = property.pinCode ?? '';
    rentController.text = property.expectedRent ?? '';
    depositController.text = property.securityDeposit ?? '';
    maintenanceController.text = property.maintenanceCharges ?? '';
    noticePeriodController.text = property.noticePeriod ?? '';
    totalBedController.text = property.totalNumberOfBeds?.toString() ?? '';


    propertyType = property.propertyType;
    furnishingStatus = property.furnishingStatus;
    city = property.city;
    mealAvailability = property.mealAvailability;
    numberOfBedrooms = property.numberOfBedrooms?.toString();
    numberOfBathrooms = property.numberOfBathrooms?.toString();
    parkingAvailability = property.parkingAvailability;
    preferredGender = property.preferredGender;


    if (property.selectedAmenities != null) {
      selectedAmenities = List<String>.from(property.selectedAmenities!);
    }
    if (property.selectedHouseRules != null) {
      selectedHouseRules = List<String>.from(property.selectedHouseRules!);
    }
    if (property.selectedMeals != null) {
      selectedMeals = List<String>.from(property.selectedMeals!);
    }
    if (property.preferredTenant != null) {
      preferredTenant = List<String?>.from(property.preferredTenant!);
    }
    if (property.sharingType != null) {
      sharingType = List<String?>.from(property.sharingType!);
    }
    

    if (property.propertyImages != null) {
      existingImages = List<String>.from(property.propertyImages!);
      print('Loaded ${existingImages.length} existing images for editing');
      if (existingImages.isNotEmpty) {
        print('First image data type: ${existingImages.first.runtimeType}');
        print('First image length: ${existingImages.first.length}');
        print('First image starts with: ${existingImages.first.substring(0, min(50, existingImages.first.length))}');
        print('First image contains "data:image": ${existingImages.first.contains("data:image")}');
        print('First image contains ",": ${existingImages.first.contains(",")}');
      }
    } else {
      print('No existing images found in property');
    }
  }

  void showAddImageOptions(BuildContext context) {
    customBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey.shade400,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Choose from below options",
                        style: TextStyle(
                          color: Color(0xff2A2B3F),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);

                          final pickedImage = await ImagePicker().pickImage(
                            maxWidth: 600,
                            maxHeight: 600,
                            source: ImageSource.camera,
                          );
                          if (pickedImage != null) {
                            setState(() {
                              propertyImages.add(File(pickedImage.path));
                            });
                            commonToast("Photo successfully added");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Color(0xffD32F2F),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Camera",
                        style: TextStyle(
                          color: Color(0xffA1A0A0),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);

                          final pickedImages =
                              await ImagePicker().pickMultiImage();

                          if (pickedImages.isNotEmpty) {
                            setState(() {
                              propertyImages.addAll(
                                pickedImages.map(
                                    (pickedImage) => File(pickedImage.path)),
                              );
                            });
                            commonToast("Photos successfully added");
                          }



                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            child: Center(
                              child: Icon(
                                Icons.photo_library,
                                color: Color(0xffD32F2F),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Gallery",
                        style: TextStyle(
                          color: Color(0xffA1A0A0),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    rentController.dispose();
    depositController.dispose();
    maintenanceController.dispose();
    noticePeriodController.dispose();
    totalBedController.dispose();
    additionalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(
        data: widget.property != null ? "Edit Property" : "Add Property Details",
        showBackArrow: true,
        context: context,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              height: 100,

              decoration: sectionDecoration(),
              child: EasyStepper(
                enableStepTapping: false,
                internalPadding: 10,
                showStepBorder: false,
                activeStep: activeStep,
                lineStyle: LineStyle(
                  lineLength: 50,
                  lineType: LineType.normal,
                  defaultLineColor: Colors.grey[300],
                  finishedLineColor: Color(0xffD32F2F),
                ),
                stepShape: StepShape.circle,
                stepRadius: 18,
                unreachedStepIconColor: Colors.grey[600],
                finishedStepBackgroundColor: Color(0xffD32F2F),
                activeStepBackgroundColor: Color(0xffD32F2F),
                unreachedStepBackgroundColor: Color(0xffE0E0E0),
                activeStepIconColor: Colors.white,
                finishedStepIconColor: Colors.white,
                activeStepTextColor:
                    Colors.black.withAlpha((255 * 0.9).toInt()),
                finishedStepTextColor:
                    Colors.black.withAlpha((255 * 0.9).toInt()),
                unreachedStepTextColor: Color(0xff808080),

                showLoadingAnimation: false,
                steps: [
                  EasyStep(
                    icon: Icon(Icons.description_outlined),
                    title: 'Basic\nDetails',
                  ),
                  EasyStep(
                    icon: Icon(Icons.location_on_outlined),
                    title: 'Location',
                  ),
                  EasyStep(
                    icon: Icon(Icons.home_outlined),
                    title: 'Property\nDetails',
                  ),
                  EasyStep(
                    icon: Icon(
                      Icons.image_outlined,
                    ),
                    title: 'Upload\nImages',
                  ),
                  EasyStep(
                    icon: Icon(Icons.rule_outlined),
                    title: 'House\nRules',
                  ),
                  EasyStep(
                    icon: Icon(Icons.currency_rupee),
                    title: 'Pricing',
                  ),
                ],
                onStepReached: (index) => setState(() => activeStep = index),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: buildCurrentStep(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildNavbar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (activeStep > 0)
              Expanded(
                  child: outlinedSubmit(
                      data: 'Previous',
                      onPressed: () {
                        setState(() {
                          if (activeStep > 0) activeStep--;
                        });
                      })),
            if (activeStep > 0) SizedBox(width: 16),
            Expanded(
              child: submit(
                data: activeStep == lastStep 
                    ? (widget.property != null ? 'Update' : 'Submit') 
                    : 'Next',
                onPressed: () async {
                  setState(() {
                    errorType = null;
                  });

                  if (propertyType == null || propertyType!.isEmpty) {
                    setState(() {
                      errorType = "Please select property type";
                    });
                    commonToast(errorType!);
                    return;
                  }

                  formKey.currentState!.validate();

                  if (activeStep == 2) {
                    if (propertyType == "PG") {
                      if (totalBedController.text.isEmpty) {
                        setState(
                            () => errorType = "Enter Total number of beds");
                      } else if (sharingType.isEmpty) {
                        setState(() => errorType = "Please select room type");
                      } else if (preferredGender == null ||
                          preferredGender!.isEmpty) {
                        setState(
                            () => errorType = "Please select preferred gender");
                      } else if (preferredTenant.isEmpty) {
                        setState(
                            () => errorType = "Please select preferred tenant");
                      } else if (mealAvailability == null ||
                          mealAvailability!.isEmpty) {
                        setState(() =>
                            errorType = "Please select meals availability");
                      } else if (mealAvailability == "Yes" &&
                          selectedMeals.isEmpty) {
                        setState(
                            () => errorType = "Please select meals offered");
                      }
                    } else if (propertyType == "Hostel") {
                      if (sharingType.isEmpty) {
                        setState(
                            () => errorType = "Please select a sharing type");
                      } else if (preferredGender == null ||
                          preferredGender!.isEmpty) {
                        setState(() =>
                            errorType = "Please select a gender preference");
                      } else if (mealAvailability == null ||
                          mealAvailability!.isEmpty) {
                        setState(() => errorType =
                            "Please specify if meals are available");
                      } else if (mealAvailability == "Yes" &&
                          selectedMeals.isEmpty) {
                        setState(
                            () => errorType = "Please select meals offered");
                      }
                    } else if (propertyType == "Flat" ||
                        propertyType == "House") {
                      if (furnishingStatus == null ||
                          furnishingStatus!.isEmpty) {
                        setState(() =>
                            errorType = "Please select furnishing status");
                      } else if (preferredTenant.isEmpty) {
                        setState(() =>
                            errorType = "Please select a preferred tenant");
                      } else if (numberOfBedrooms == null ||
                          numberOfBedrooms!.isEmpty) {
                        setState(() =>
                            errorType = "Please select the number of bedrooms");
                      } else if (numberOfBathrooms == null ||
                          numberOfBathrooms!.isEmpty) {
                        setState(() => errorType =
                            "Please select the number of bathrooms");
                      } else if (parkingAvailability == null ||
                          parkingAvailability!.isEmpty) {
                        setState(() =>
                            errorType = "Please specify parking availability");
                      }
                    }
                  }

                  if (activeStep == 3) {
                    if (propertyImages.isEmpty && existingImages.isEmpty) {
                      setState(
                          () => errorType = "Please upload at least one image");
                    }
                  }

                  if (activeStep == 4) {
                    if (selectedAmenities.isEmpty) {
                      setState(() =>
                          errorType = "Please select at least one amenity");
                    } else if (selectedHouseRules.isEmpty) {
                      setState(() =>
                          errorType = "Please select at least one house rule");
                    }
                  }

                  if (errorType != null) {
                    commonToast(errorType!);
                    return;
                  }

                  if (activeStep < lastStep) {
                    setState(() {
                      activeStep++;
                    });
                  } else {
                    submitProperty();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentStep() {
    switch (activeStep) {
      case 0:
        return buildBasicDetails();
      case 1:
        return buildLocation();
      case 2:
        return buildPropertyProfile();
      case 3:
        return buildPhotos();
      case 4:
        return buildAmenities();
      case 5:
        return buildPricing();
      default:
        return Container();
    }
  }

  Widget buildBasicDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: sectionDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  sectionTitle(data: "Property Type"),
                ],
              ),
              SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 3.2,
                ),
                itemCount: types.length,
                itemBuilder: (context, index) {
                  final type = types[index];
                  return buildCard(
                    title: type,
                    isSelected: propertyType == type,
                    onTap: () => setState(() {
                      propertyType = type;

                      sharingType.clear();
                      preferredTenant.clear();
                      preferredGender = null;
                      furnishingStatus = null;
                      mealAvailability = null;
                      selectedMeals.clear();
                      selectedAmenities.clear();
                      selectedHouseRules.clear();
                      numberOfBedrooms = null;
                      numberOfBathrooms = null;
                      parkingAvailability = null;
                    }),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: sectionDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  sectionTitle(data: "Property Details"),
                ],
              ),
              SizedBox(height: 16),
              input(
                controller: titleController,
                icon: Icons.home_outlined,
                hintText: "Property Title",
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(200),
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[A-Za-z\s]'),
                  ),
                  FilteringTextInputFormatter.deny(RegExp(r'\s\s'))
                ],
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    errorType ??= "Please enter property title";
                    return null;
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  input(
                    controller: descriptionController,
                    maxLines: 6,
                    keyboardType: TextInputType.text,

                    hintText: "Describe about your property here",








                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(data: "Location Details"),
        SizedBox(height: 24),
        input(
          keyboardType: TextInputType.text,
          validation: (value) {
            if (value == null || value.isEmpty) {
              errorType ??= "Please enter address";
              return null;
            }
            return null;
          },
          controller: addressController,
          icon: Icons.location_on_outlined,
          hintText: "Address",
        ),
        SizedBox(height: 12),
        input(
            controller: landmarkController,
            icon: Icons.location_city_outlined,
            hintText: "Landmark",
            keyboardType: TextInputType.text),
        SizedBox(height: 12),
        Row(
          children: [
            Flexible(
              child: buildDropdownWithIcon(
                hint: "Select city",
                icon: Icons.location_city,
                value: city,
                items: cities,
                onChanged: (value) => setState(() => city = value),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    errorType ??= "Please select city";
                    return null;
                  }
                  return null;
                },
              ),












            ),
            SizedBox(width: 12),
            Flexible(
              child: input(
                controller: pinCodeController,
                icon: Icons.pin_drop_outlined,
                hintText: "Pin code",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly
                ],
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    errorType ??= "Please enter pin code";
                    return null;
                  }

                  if (value.length != 6) {
                    errorType ??= "Pin Code must be of 6 digits";
                    return null;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMealAvailabilityRadio() {
    return Row(
      children: [
        title("Meals Available ?"),
        SizedBox(width: 10),
        Radio(
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xffD32F2F);
            }
            return Colors.grey;
          }),
          value: "Yes",
          groupValue: mealAvailability,
          onChanged: (value) {
            setState(() {
              mealAvailability = value;
            });
          },
        ),
        Text("Yes",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: Colors.black)),
        Radio(
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xffD32F2F);
            }
            return Colors.grey;
          }),
          value: "No",
          groupValue: mealAvailability,
          onChanged: (value) {
            setState(() {
              mealAvailability = value;
            });
          },
        ),
        Text("No",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: Colors.black)),
      ],
    );
  }

  Widget buildPropertyProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(data: "Property Profile"),
        SizedBox(height: 24),
        if (propertyType == "PG") ...[
          title("Total number of beds"),
          SizedBox(height: 8),
          input(
              controller: totalBedController,
              hintText: "Enter Total number of beds",
              icon: Icons.bed,
              keyboardType: TextInputType.number,







              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                FilteringTextInputFormatter.digitsOnly
              ]),
          SizedBox(
            height: 16,
          ),
          title("Room Type"),
          SizedBox(height: 8),
          Wrap(
            children: sharing.map((option) {
              final isSelected = sharingType.contains(option);
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  if (isSelected) {
                    sharingType.remove(option);
                  } else {
                    sharingType.add(option);
                  }

                });
              });
            }).toList(),
          ),
          SizedBox(height: 16),
          title("Gender Preference"),
          SizedBox(height: 8),
          Wrap(
            children: genderPreference.map((option) {
              final isSelected = preferredGender == option;
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  preferredGender = option;
                });
              });
            }).toList(),
          ),
          SizedBox(height: 16),
          title("Preferred Tenant"),
          SizedBox(height: 8),
          Wrap(
            children: [
              "Students",
              "Professionals",
            ].map((option) {
              final isSelected = preferredTenant.contains(option);
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  if (isSelected) {
                    preferredTenant.remove(option);
                  } else {
                    preferredTenant.add(option);
                  }


                });
              });
            }).toList(),
          ),
          SizedBox(height: 8),
          buildMealAvailabilityRadio(),
          SizedBox(
            height: 10,
          ),
          if (mealAvailability == "Yes") ...[
            title("Meals offered"),
            SizedBox(height: 8),
            Wrap(
              children: meals.map((meal) {
                final isSelected = selectedMeals.contains(meal);
                return buildSelectableCard(meal, isSelected, () {
                  setState(() {
                    if (isSelected) {
                      selectedMeals.remove(meal);
                    } else {
                      selectedMeals.add(meal);
                    }
                  });
                });
              }).toList(),
            ),
            SizedBox(
              height: 16,
            ),
          ],
          title("Notice Period"),
          SizedBox(height: 8),
          input(
              controller: noticePeriodController,
              hintText: "Notice period",
              icon: Icons.lock_clock_rounded,
              keyboardType: TextInputType.number,
              suffixText: "days",
              validation: (value) {
                if (value == null || value.isEmpty) {
                  errorType ??= "Please enter notice period days";
                  return null;
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                FilteringTextInputFormatter.digitsOnly
              ])
        ] else if (propertyType == "Hostel") ...[
          title("Sharing Type"),
          SizedBox(height: 8),
          Wrap(
            children: sharing.map((option) {
              final isSelected = sharingType.contains(option);
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  if (isSelected) {
                    sharingType.remove(option);
                  } else {
                    sharingType.add(option);
                  }

                });
              });
            }).toList(),
          ),
          SizedBox(height: 16),
          title("Gender Preference"),
          SizedBox(height: 8),
          Wrap(
            children: genderPreference.map((option) {
              final isSelected = preferredGender == option;
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  preferredGender = option;
                });
              });
            }).toList(),
          ),
          SizedBox(height: 8),
          buildMealAvailabilityRadio(),
          SizedBox(
            height: 10,
          ),
          if (mealAvailability == "Yes") ...[
            title("Meals offered"),
            SizedBox(height: 15),
            Wrap(
              children: meals.map((meal) {
                final isSelected = selectedMeals.contains(meal);
                return buildSelectableCard(meal, isSelected, () {
                  setState(() {
                    if (isSelected) {
                      selectedMeals.remove(meal);
                    } else {
                      selectedMeals.add(meal);
                    }
                  });
                });
              }).toList(),
            ),
          ],
        ] else if (propertyType == "Flat" || propertyType == "House") ...[
          title("Furnishing Status"),
          SizedBox(height: 8),
          Wrap(
            children: ["Fully Furnished", "Semi Furnished", "Unfurnished"]
                .map((option) {
              final isSelected = furnishingStatus == option;
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  furnishingStatus = option;
                });
              });
            }).toList(),
          ),
          SizedBox(height: 16),
          title("Preferred Tenant"),
          SizedBox(height: 8),
          Wrap(
            children: ["Anyone", "Family", "Bachelor", "Company"].map((option) {
              final isSelected = preferredTenant.contains(option);
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  if (isSelected) {
                    preferredTenant.remove(option);
                  } else {
                    preferredTenant.add(option);
                  }


                });
              });
            }).toList(),
          ),
          SizedBox(height: 16),
          title("Number of Bedrooms"),
          SizedBox(height: 8),
          Wrap(
            children: rooms.map((option) {
              final isSelected = numberOfBedrooms == option;
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  numberOfBedrooms = option;
                });
              });
            }).toList(),
          ),
          SizedBox(height: 16),
          title("Number of Bathrooms"),
          SizedBox(height: 8),
          Wrap(
            children: ["1", "2", "3", "4", "5+"].map((option) {
              final isSelected = numberOfBathrooms == option;
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  numberOfBathrooms = option;
                });
              });
            }).toList(),
          ),
          SizedBox(height: 16),
          title("Parking Availability"),
          SizedBox(height: 8),
          Wrap(
            children: ["Available", "Not Available"].map((option) {
              final isSelected = parkingAvailability == option;
              return buildSelectableCard(option, isSelected, () {
                setState(() {
                  parkingAvailability = option;
                });
              });
            }).toList(),
          ),
        ]











































































      ],
    );
  }

  Widget buildPhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(data: "Photos"),
        SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffE0E0E0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              (propertyImages.isNotEmpty || existingImages.isNotEmpty)
                  ? GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: propertyImages.length + existingImages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () async {
                              showAddImageOptions(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Color(0xffF5F4F8)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 38,
                                    width: 38,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Color(0xffD32F2F),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Add More",
                                    style: TextStyle(
                                        color: Color(0xffD32F2F),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          final adjustedIndex = index - 1;
                          final isExistingImage = adjustedIndex < existingImages.length;
                          final imageIndex = isExistingImage ? adjustedIndex : adjustedIndex - existingImages.length;
                          
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Color(0xffF5F4F8)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: isExistingImage
                                      ? Builder(
                                          builder: (context) {
                                            try {
                                              final imageData = existingImages[imageIndex];
                                              
                                              if (imageData == null || imageData.isEmpty) {
                                                print('Image data is null or empty at index $imageIndex');
                                                return Container(
                                                  height: 160,
                                                  width: double.infinity,
                                                  color: Colors.grey[300],
                                                  child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
                                                );
                                              }
                                              
                                              print('Displaying image at index $imageIndex');
                                              print('Image data starts with: ${imageData.substring(0, min(30, imageData.length))}');
                                              
                                              if (imageData.startsWith('data:image')) {
                                                final base64Data = imageData.split(',')[1];
                                                print('Base64 data length: ${base64Data.length}');
                                                return Image.memory(
                                                  height: 160,
                                                  width: double.infinity,
                                                  base64Decode(base64Data),
                                                  fit: BoxFit.fill,
                                                );
                                              } else {

                                                print('Treating as pure base64 data');
                                                return Image.memory(
                                                  height: 160,
                                                  width: double.infinity,
                                                  base64Decode(imageData),
                                                  fit: BoxFit.fill,
                                                );
                                              }
                                            } catch (e) {
                                              print('Error decoding image at index $imageIndex: $e');
                                              return Container(
                                                height: 160,
                                                width: double.infinity,
                                                color: Colors.grey[300],
                                                child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
                                              );
                                            }
                                          },
                                        )
                                      : Image.file(
                                          height: 160,
                                          width: double.infinity,
                                          propertyImages[imageIndex],
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              Positioned(
                                right: -3,
                                top: -1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isExistingImage) {
                                        existingImages.removeAt(imageIndex);
                                      } else {
                                        propertyImages.removeAt(imageIndex);
                                      }
                                    });
                                    commonToast("Photo removed");
                                  },
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffD32F2F)),
                                    child: Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    )
                  : Column(
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 48,
                          color: Color(0xffD32F2F),
                        ),
                        SizedBox(height: 16),
                        submit(
                          data: "Add Photos",
                          onPressed: () {
                            showAddImageOptions(context);
                          },
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "(Click from camera or browse to upload)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAmenities() {
    if (propertyType == null || propertyType!.isEmpty) {
      return SizedBox();
    }

    List<String> amenities = amenitiesByPropertyType[propertyType!] ?? [];
    List<String> houseRules = houseRulesByPropertyType[propertyType!] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: sectionDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              sectionTitle(data: "Amenities & Features"),
              SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: amenities.map((amenity) {
                  final isSelected = selectedAmenities.contains(amenity);
                  return buildSelectableCard(
                    amenity,
                    isSelected,
                    () {
                      setState(() {
                        if (isSelected) {
                          selectedAmenities.remove(amenity);
                        } else {
                          selectedAmenities.add(amenity);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: sectionDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              sectionTitle(data: "House Rules"),
              SizedBox(height: 8),
              Text(
                "Select what is allowed in your property",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff757575),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: houseRules.map((rule) {
                  final isSelected = selectedHouseRules.contains(rule);
                  return FilterChip(
                    label: Text(
                      rule,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xff757575),
                        fontFamily: "Poppins",
                        fontSize: 13,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedHouseRules.add(rule);
                        } else {
                          selectedHouseRules.remove(rule);
                        }
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Color(0xffD32F2F),
                    checkmarkColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color:
                            isSelected ? Color(0xffD32F2F) : Color(0xffE0E0E0),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),
              Text(
                "Additional Rules",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Color(0xff2A2B3F),
                ),
              ),
              SizedBox(height: 8),
              input(
                controller: additionalController,
                hintText: "Add any additional rules or requirements",
                maxLines: 3,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildPricing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(data: "Pricing & Other Details"),
        SizedBox(height: 24),
        input(
            icon: Icons.currency_rupee,
            hintText: "Expected Rent",
            controller: rentController,
            keyboardType: TextInputType.number,
            validation: (value) {
              if (value == null || value.isEmpty) {
                errorType ??= "Please enter rent amount";
                return null;
              }
              return null;
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly
            ]),
        SizedBox(height: 12),
        input(
            icon: Icons.currency_rupee,
            hintText: "Security Deposit",
            controller: depositController,
            keyboardType: TextInputType.number,
            validation: (value) {
              if (value == null || value.isEmpty) {
                errorType ??= "Please enter security deposit amount";
                return null;
              }
              return null;
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly
            ]),
        SizedBox(height: 12),
        input(
            icon: Icons.currency_rupee,
            hintText: "Maintenance Charges",
            controller: maintenanceController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly
            ]),
      ],
    );
  }

  Future<void> submitProperty() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        commonToast('User not authenticated');
        return;
      }


      List<String> imageBase64List = [];
      if (propertyImages.isNotEmpty) {
        commonToast('Processing images...');
        for (int i = 0; i < propertyImages.length; i++) {
          String base64String = await convertImageToBase64(propertyImages[i]);
          imageBase64List.add(base64String);
        }
      }

      PropertyListing propertyListing = PropertyListing(
                  id: widget.property?.id,
        propertyType: propertyType,
        title: titleController.text,
        description: descriptionController.text,
        address: addressController.text,
        landmark: landmarkController.text,
        city: city,
        state: stateController.text,
        pinCode: pinCodeController.text,
        furnishingStatus: furnishingStatus,
        preferredTenant: preferredTenant.cast<String>(),
        preferredGender: preferredGender,
        mealAvailability: mealAvailability,
        selectedMeals: selectedMeals.cast<String>(),
        sharingType: sharingType.cast<String>(),
        numberOfBedrooms: numberOfBedrooms,
        numberOfBathrooms: numberOfBathrooms,
        parkingAvailability: parkingAvailability,
        totalNumberOfBeds: totalBedController.text,
        noticePeriod: noticePeriodController.text,
        propertyImages: imageBase64List.isNotEmpty 
            ? [...existingImages, ...imageBase64List] 
            : existingImages.isNotEmpty 
                ? existingImages 
                : [],
        selectedAmenities: selectedAmenities,
        selectedHouseRules: selectedHouseRules,
        additionalRules: additionalController.text,
        expectedRent: rentController.text,
        securityDeposit: depositController.text,
        maintenanceCharges: maintenanceController.text,
        ownerId: userId,
        createdAt: widget.property?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
      );

      if (widget.property != null) {

        await FirebaseFirestore.instance
            .collection('properties')
            .doc(widget.property!.id)
            .update(propertyListing.toFirestore());
        
        commonToast("Property updated successfully!");
        
        if (!context.mounted) return;
        

        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OwnerNavbar(initialIndex: 1)),
          (route) => false,
        );
      } else {

        await FirebaseFirestore.instance
            .collection('properties')
            .add(propertyListing.toFirestore());

        commonToast("Property submitted successfully!");

        if (!context.mounted) return;
        
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OwnerNavbar(initialIndex: 1)),
          (route) => false,
        );


        setState(() {
          titleController.clear();
          descriptionController.clear();
          addressController.clear();
          landmarkController.clear();
          cityController.clear();
          stateController.clear();
          pinCodeController.clear();
          rentController.clear();
          depositController.clear();
          maintenanceController.clear();
          noticePeriodController.clear();
          totalBedController.clear();
          additionalController.clear();
          propertyImages.clear();
          propertyType = null;
          furnishingStatus = null;
          preferredTenant.clear();
          preferredGender = null;
          mealAvailability = null;
          selectedMeals.clear();
          selectedAmenities.clear();
          selectedHouseRules.clear();
          sharingType.clear();
          numberOfBedrooms = null;
          numberOfBathrooms = null;
          parkingAvailability = null;
          activeStep = 0;
        });
      }
    } catch (e) {
      commonToast('Error ${widget.property != null ? 'updating' : 'submitting'} property: $e');
    }
  }

  Future<String> convertImageToBase64(File imageFile) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);
      return 'data:image/jpeg;base64,$base64String';
    } catch (e) {
      print('Error converting image to base64: $e');
      throw Exception('Failed to convert image: $e');
    }
  }
}
