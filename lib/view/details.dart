import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentease/common/common_form.dart';
import 'package:rentease/view/book.dart';
import 'package:rentease/view/enquire.dart';
import 'package:rentease/view/reviews.dart';
import 'package:rentease/view/scheduleVisit.dart';
import 'package:rentease/view/stepForm.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'dart:io';

import '../common/global_widget.dart';
import '../common/common_book.dart';
import '../models/property_listing.dart';
import 'chat.dart';

class Details extends StatefulWidget {
  final String propertyId;
  const Details({super.key, required this.propertyId});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final PageController pageController = PageController();
  Map<String, dynamic>? propertyData;
  bool isSaved = false;
  int currentPage = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId {
    return _auth.currentUser?.uid ?? '';
  }

  @override
  void initState() {
    super.initState();
    fetchProperty();
    checkIfSaved();
  }

  void fetchProperty() async {
    final doc = await FirebaseFirestore.instance
        .collection('properties')
        .doc(widget.propertyId)
        .get();
    setState(() {
      propertyData = doc.data();
    });
  }

  void checkIfSaved() async {
    if (userId.isEmpty) {
      setState(() {
        isSaved = false;
      });
      return;
    }
    
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('savedProperties')
        .doc(widget.propertyId)
        .get();
    setState(() {
      isSaved = doc.exists;
    });
  }

  void toggleSave() async {
    if (userId.isEmpty) {
      commonToast('Please login to save properties');
      return;
    }
    
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('savedProperties')
        .doc(widget.propertyId);
    if (isSaved) {
      await ref.delete();
      setState(() {
        isSaved = false;
      });
      commonToast('Saved property has been removed');
    } else {
      await ref.set({'savedAt': FieldValue.serverTimestamp()});
      setState(() {
        isSaved = true;
      });
      commonToast('Property saved successfully');
    }
  }

  List images = [
    "assets/images/room1.png",
    "assets/images/room2.png",
    "assets/images/room1.png"
  ];

  List<Map<String, String>> pgDetails = [
    {"Type": "PG"},
    {"Maintenance": "Included"},
    {"Electricity charges": "Included"},
    {"Parking": "Included"},
    {"Available From": "Immediately"},
  ];

  List<Map<String, String>> amenities = [
    {"AC": "assets/svg/ac.svg"},
    {"TV": "assets/svg/tv.svg"},
    {"Wi-fi": "assets/svg/wifi.svg"},
    {"Cleaning": "assets/svg/roomCleaning.svg"},
    {"Fridge": "assets/svg/fridge.svg"},
    {"Water Cooler": "assets/svg/water-dispenser.svg"},
    {"Parking": "assets/svg/building.svg"},
    {"Gym": "assets/svg/building.svg"},
    {"Swimming Pool": "assets/svg/building.svg"},
    {"Garden": "assets/svg/building.svg"},
    {"Security": "assets/svg/lock.svg"},
    {"Lift": "assets/svg/building.svg"},
  ];

  List houseRules = [
    {"Smoking": "assets/svg/smoking.svg"},
    {"Alcohol": "assets/svg/alcohol.svg"},
    {"Loud Music": "assets/svg/loudMusic.svg"},
    {"Party": "assets/svg/party.svg"},
    {"Non Veg": "assets/svg/fish.svg"},
    {"Visitor Entry": "assets/svg/visitor.svg"},



  ];

  List houseRuleStatus = [
    false,
    false,
    false,
    true,
    false,
    true,
  ];



  @override
  Widget build(BuildContext context) {
    if (propertyData == null) {
      return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final rawImages = propertyData!['propertyImages'] as List?;
    final images = (rawImages
            ?.where((e) => e != null && e.toString().isNotEmpty)
            .toList() ??
        []);
    if (images.isEmpty) {
      images.add('assets/images/room1.png');
    }
    final title = propertyData!['title'] ?? '';
    final city = propertyData!['city'] ?? '';
    final expectedRent = propertyData!['expectedRent']?.toString() ?? '-';
    final description = propertyData!['description'] ?? '';

    final propertyType = propertyData!['propertyType'] ?? '';
    final furnishingStatus = propertyData!['furnishingStatus'] ?? '-';
    final numberOfBedrooms = propertyData!['numberOfBedrooms'] ?? '-';
    final numberOfBathrooms = propertyData!['numberOfBathrooms'] ?? '-';
    final parkingAvailability = propertyData!['parkingAvailability'] ?? '-';
    final mealAvailability = propertyData!['mealAvailability'] ?? '-';
    final preferredGender = propertyData!['preferredGender'] ?? '-';
    final preferredTenant =
        (propertyData!['preferredTenant'] as List?)?.join(', ') ?? '-';
    final selectedMeals =
        (propertyData!['selectedMeals'] as List?)?.join(', ') ?? '-';
    final sharingType =
        (propertyData!['sharingType'] as List?)?.join(', ') ?? '-';
    final totalNumberOfBeds = propertyData!['totalNumberOfBeds'] ?? '-';
    final noticePeriod = propertyData!['noticePeriod'] ?? '-';
    final securityDeposit = propertyData!['securityDeposit'] ?? '-';
    final maintenanceCharges = propertyData!['maintenanceCharges'] ?? '-';
    final address = propertyData!['address'] ?? '-';
    final landmark = propertyData!['landmark'] ?? '-';
    final pinCode = propertyData!['pinCode'] ?? '-';
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(overscroll: false),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return images[index].toString().startsWith('data:image')
                          ? Image.memory(
                              base64Decode(images[index].split(',')[1]),
                              width: double.infinity,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/room1.png",
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                );
                              },
                            )
                          : images[index].toString().startsWith('http')
                              ? Image.network(
                                  images[index],
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/room1.png",
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    );
                                  },
                                )
                              : Image.asset(
                                  "assets/images/room1.png",
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: images.length,
                    effect: ScrollingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Color(0xffD32F2F),
                        dotColor: Colors.grey),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconHolder(
                          child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 23,
                            ),
                          ),
                        ),
                      )),
                      Spacer(),
                      iconHolder(
                        child: IconButton(
                            onPressed: toggleSave,
                            icon: isSaved
                                ? Icon(
                                    Icons.bookmark,
                                    size: 23,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.bookmark_border,
                                    size: 23,
                                    color: Colors.white,
                                  )),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      iconHolder(
                        child: IconButton(
                            onPressed: () {
                              Share.share("Check out this app");
                            },
                            icon: Icon(
                              Icons.share_outlined,
                              size: 22,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: horizontalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2A2B3F)),
                              ),
                              Spacer(),
                              Icon(
                                Icons.currency_rupee,
                                size: 18,
                                weight: 900,
                                applyTextScaling: true,
                                grade: 50,
                                color: Color(0xff030201),
                              ),
                              Text(
                                expectedRent,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              city,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ]),
                          SizedBox(height: 8),

                          SizedBox(
                            height: 8,
                          ),




















                        ],
                      ),
                    ),













                    Divider(
                      height: 10,
                      color: Color(0xffF5F5F5),
                      thickness: 5,
                    ),
                    Padding(
                      padding: horizontalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.black.withAlpha(210),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              description,
                              style: TextStyle(
                                  color: Color(0xff808080),
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Color(0xffF5F5F5),
                      thickness: 5,
                    ),
                    Padding(
                      padding: horizontalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Property Details",
                            style: TextStyle(
                                color: Colors.black.withAlpha(210),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(height: 10),
                          Builder(
                            builder: (context) {
                              final details = [
                                ["Type", propertyType],
                                ["Furnishing", furnishingStatus],
                                ["Bedrooms", numberOfBedrooms],
                                ["Bathrooms", numberOfBathrooms],
                                ["Parking", parkingAvailability],
                                ["Meals", mealAvailability],
                                ["Preferred Gender", preferredGender],
                                ["Preferred Tenant", preferredTenant],
                                ["Sharing Type", sharingType],
                                ["Total Beds", totalNumberOfBeds],
                                ["Notice Period", noticePeriod],
                                ["Security Deposit", securityDeposit],
                                ["Maintenance", maintenanceCharges],
                              ]
                                  .where((item) =>
                                      item[1] != null &&
                                      item[1].toString().trim().isNotEmpty &&
                                      item[1].toString().trim() != '-')
                                  .toList();
                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 20,
                                        crossAxisCount: 2,
                                        childAspectRatio: 3),
                                itemCount: details.length,
                                itemBuilder: (context, index) {
                                  return _propertyDetailTile(details[index][0], details[index][1]);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Color(0xffF5F5F5),
                      thickness: 5,
                    ),
                    Padding(
                      padding: horizontalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Amenities",
                            style: TextStyle(
                                color: Colors.black.withAlpha(210),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Builder(
                              builder: (context) {
                                final selectedAmenities =
                                    propertyData!['selectedAmenities'] as List?;
                                
                                if (selectedAmenities == null || selectedAmenities.isEmpty) {
                                  return Text("No amenities listed.",
                                      style: TextStyle(color: Colors.grey));
                                }
                                

                                List<Map<String, String>> filteredAmenities = [];
                                for (var selectedAmenity in selectedAmenities) {
                                  bool found = false;
                                  String selectedAmenityStr = selectedAmenity.toString();
                                  
                                  for (var amenity in amenities) {
                                    if (amenity.keys.first.toLowerCase() == selectedAmenityStr.toLowerCase()) {
                                      filteredAmenities.add(amenity);
                                      found = true;
                                      print('Found amenity: ${selectedAmenity} with SVG: ${amenity.values.first}');
                                      break;
                                    }
                                  }
                                  

                                  if (!found) {
                                    for (var amenity in amenities) {
                                      if (amenity.keys.first.toLowerCase().contains(selectedAmenityStr.toLowerCase()) ||
                                          selectedAmenityStr.toLowerCase().contains(amenity.keys.first.toLowerCase())) {
                                        filteredAmenities.add(amenity);
                                        found = true;
                                        print('Found partial match amenity: ${selectedAmenity} with SVG: ${amenity.values.first}');
                                        break;
                                      }
                                    }
                                  }
                                  

                                  if (!found) {
                                    String iconPath = _getAmenitySvgPath(selectedAmenityStr);
                                    filteredAmenities.add({
                                      selectedAmenityStr: iconPath
                                    });
                                    print('Added custom icon for: ${selectedAmenityStr} -> ${iconPath}');
                                  }
                                }
                                
                                return Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: [
                                    for (var amenitiesIndex in filteredAmenities)
                                      Chip(
                                        label: Text(
                                          amenitiesIndex.keys.first,
                                          style: TextStyle(
                                            color: Color(0xff808080),
                                            fontFamily: "Poppins",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        backgroundColor: Color(0xffF5F5F5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: BorderSide(color: Color(0xffB2B2B2)),
                                        ),
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Color(0xffF5F5F5),
                      thickness: 5,
                    ),
                    Padding(
                      padding: horizontalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Allowed Activities",
                            style: TextStyle(
                                color: Colors.black.withAlpha(210),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Builder(
                              builder: (context) {
                                final selectedHouseRules =
                                    propertyData!['selectedHouseRules'] as List?;
                                
                                if (selectedHouseRules == null || selectedHouseRules.isEmpty) {
                                  return Text("No house rules listed.",
                                      style: TextStyle(color: Colors.grey));
                                }
                                

                                List<Map<String, String>> filteredHouseRules = [];
                                for (var selectedRule in selectedHouseRules) {
                                  bool found = false;
                                  String selectedRuleStr = selectedRule.toString();
                                  
                                  for (var rule in houseRules) {
                                    if (rule.keys.first.toLowerCase() == selectedRuleStr.toLowerCase()) {
                                      filteredHouseRules.add(rule);
                                      found = true;
                                      print('Found house rule: ${selectedRule} with SVG: ${rule.values.first}');
                                      break;
                                    }
                                  }
                                  

                                  if (!found) {
                                    for (var rule in houseRules) {
                                      if (rule.keys.first.toLowerCase().contains(selectedRuleStr.toLowerCase()) ||
                                          selectedRuleStr.toLowerCase().contains(rule.keys.first.toLowerCase())) {
                                        filteredHouseRules.add(rule);
                                        found = true;
                                        print('Found partial match house rule: ${selectedRule} with SVG: ${rule.values.first}');
                                        break;
                                      }
                                    }
                                  }
                                  

                                  if (!found) {
                                    String iconPath = _getHouseRuleSvgPath(selectedRuleStr);
                                    filteredHouseRules.add({
                                      selectedRuleStr: iconPath
                                    });
                                    print('Added custom icon for house rule: ${selectedRuleStr} -> ${iconPath}');
                                  }
                                }
                                
                                return Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: [
                                    for (var ruleIndex in filteredHouseRules)
                                      Chip(
                                        label: Text(
                                          ruleIndex.keys.first,
                                          style: TextStyle(
                                            color: Color(0xff808080),
                                            fontFamily: "Poppins",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        backgroundColor: Color(0xffF5F5F5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: BorderSide(color: Color(0xffB2B2B2)),
                                        ),
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Color(0xffF5F5F5),
                      thickness: 5,
                    ),
                    Padding(
                      padding: horizontalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Rating and Reviews",
                                style: TextStyle(
                                    color: Colors.black.withAlpha(210),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: "Poppins"),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "4.2",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 22,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          Icons.star,
                                          size: 26,
                                          color: Colors.amber,
                                        );
                                      })),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "120 Reviews",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),










                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Reviews()));
                            },
                            child: Text(
                              "See all reviews",
                              style: TextStyle(

                                  color: Color(0xffD32F2F),

                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Color(0xffF5F5F5),
                      thickness: 5,
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Schedule a visit?",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    color: Colors.black.withAlpha(210),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "You can pick a slot to check out the property",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          submit(
                            data: "Schedule",
                            onPressed: () async {
                              final userId =
                                  FirebaseAuth.instance.currentUser?.uid;
                              final propertyId = widget.propertyId;
                              if (userId == null) {
                                commonToast('User not authenticated');
                                return;
                              }
                              final existing = await FirebaseFirestore.instance
                                  .collection('scheduledVisits')
                                  .where('userId', isEqualTo: userId)
                                  .where('propertyId', isEqualTo: propertyId)
                                  .where('status',
                                      whereIn: ['pending', 'confirmed']).get();
                              if (existing.docs.isNotEmpty) {
                                commonToast(
                                    'You have already scheduled a visit for this property.');
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Schedulevisit(propertyId: propertyId ?? ''),
                                ),
                              );
                            },











                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 10,
                      color: Color(0xffF5F5F5),
                      thickness: 5,
                    ),

                    Padding(
                      padding: horizontalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Address",
                            style: TextStyle(
                                color: Colors.black.withAlpha(210),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                color: Color(0xff808080),
                                size: 15,
                              ),
                              SizedBox(width: 2),
                              Flexible(
                                child: Text(
                                  softWrap: true,
                                  maxLines: 3,
                                  [
                                    propertyData!['address'],
                                    propertyData!['landmark'],
                                    propertyData!['city'],
                                    propertyData!['pinCode']
                                  ]
                                      .where((e) =>
                                          e != null &&
                                          e.toString().trim().isNotEmpty)
                                      .join(', '),
                                  style: TextStyle(
                                    color: Color(0xff808080),
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/map6.png"),
                                  fit: BoxFit.cover,
                                )),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                height: 30,
                                decoration: BoxDecoration(

                                    color: Colors.grey.shade400.withAlpha(120),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))



                                    ),
                                child: Center(
                                  child: Text(
                                    "View on Map",
                                    style: TextStyle(
                                        color: Colors.black.withAlpha(120),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: horizontalPadding,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: submit(
                                height: 45,
                                data: "Book",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Stepform(
                                            propertyId: widget.propertyId,
                                            propertyTitle: propertyData?['title'] ?? propertyData?['propertyName'],
                                            propertyOwnerId: propertyData?['ownerId'],
                                            propertyImage: (propertyData?['images'] as List?)?.isNotEmpty == true 
                                                ? propertyData!['images'][0] 
                                                : null,
                                            propertyCity: propertyData?['city'],
                                            propertyRent: propertyData?['expectedRent']?.toString(),
                                          )));
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: submit(
                                height: 45,
                                data: "Enquire",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Enquire(
                                            propertyId: widget.propertyId,
                                            propertyTitle: propertyData?['title'] ?? propertyData?['propertyName'],
                                            ownerId: propertyData?['ownerId'],
                                          )));
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _propertyDetailTile(String title, String value) {
    if (value == null || value.trim().isEmpty || value.trim() == '-') {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: Color(0xff808080))),
        Flexible(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: Colors.black.withAlpha(200)),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              softWrap: true),
        ),
      ],
    );
  }

  String _getAmenitySvgPath(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'ac':
      case 'air conditioning':
        return 'assets/svg/ac.svg';
      case 'tv':
      case 'television':
        return 'assets/svg/tv.svg';
      case 'wi-fi':
      case 'wifi':
      case 'internet':
        return 'assets/svg/wifi.svg';
      case 'cleaning':
      case 'room cleaning':
        return 'assets/svg/roomCleaning.svg';
      case 'fridge':
      case 'refrigerator':
        return 'assets/svg/fridge.svg';
      case 'water cooler':
      case 'water dispenser':
        return 'assets/svg/water-dispenser.svg';
      case 'parking':
        return 'assets/svg/building.svg';
      case 'gym':
      case 'fitness':
        return 'assets/svg/building.svg';
      case 'swimming pool':
      case 'pool':
        return 'assets/svg/building.svg';
      case 'garden':
        return 'assets/svg/building.svg';
      case 'security':
        return 'assets/svg/lock.svg';
      case 'lift':
      case 'elevator':
        return 'assets/svg/building.svg';
      case 'fan':
        return 'assets/svg/fan.svg';
      case 'bill':
        return 'assets/svg/bill.svg';
      case 'contract':
        return 'assets/svg/contract.svg';
      default:
        return 'assets/svg/building.svg';
    }
  }

  String _getHouseRuleSvgPath(String rule) {
    switch (rule.toLowerCase()) {
      case 'smoking':
        return 'assets/svg/smoking.svg';
      case 'alcohol':
        return 'assets/svg/alcohol.svg';
      case 'loud music':
      case 'music':
        return 'assets/svg/loudMusic.svg';
      case 'party':
        return 'assets/svg/party.svg';
      case 'non veg':
      case 'non-veg':
      case 'non vegetarian':
        return 'assets/svg/fish.svg';
      case 'visitor entry':
      case 'visitor':
      case 'visitors':
        return 'assets/svg/visitor.svg';
      case 'opposite gender':
        return 'assets/svg/oppositeGender.svg';
      case 'fish':
        return 'assets/svg/fish.svg';
      default:
        return 'assets/svg/building.svg';
    }
  }

  IconData _getAmenityIcon(String title) {
    switch (title.toLowerCase()) {
      case 'ac':
        return Icons.ac_unit;
      case 'tv':
        return Icons.tv;
      case 'wi-fi':
      case 'wifi':
        return Icons.wifi;
      case 'cleaning':
        return Icons.cleaning_services;
      case 'fridge':
        return Icons.kitchen;
      case 'water cooler':
        return Icons.local_drink;
      case 'parking':
        return Icons.local_parking;
      case 'gym':
        return Icons.fitness_center;
      case 'swimming pool':
        return Icons.pool;
      case 'garden':
        return Icons.park;
      case 'security':
        return Icons.security;
      case 'lift':
        return Icons.elevator;

      case 'smoking':
        return Icons.smoking_rooms;
      case 'alcohol':
        return Icons.local_bar;
      case 'loud music':
        return Icons.volume_up;
      case 'party':
        return Icons.celebration;
      case 'non veg':
        return Icons.restaurant;
      case 'visitor entry':
        return Icons.people;
      default:
        return Icons.home;
    }
  }
}

