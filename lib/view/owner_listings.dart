import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/models/property_listing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'owner_property_details.dart';

class OwnerListings extends StatefulWidget {
  const OwnerListings({super.key});

  @override
  State<OwnerListings> createState() => _OwnerListingsState();
}

class _OwnerListingsState extends State<OwnerListings> {
  bool isLoading = true;
  List<PropertyListing> propertyListings = [];

  @override
  void initState() {
    super.initState();
    loadPropertyListings();
  }

  Future<void> loadPropertyListings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('property_listings');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      setState(() {
        propertyListings =
            jsonList.map((json) => PropertyListing.fromJson(json)).toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: appbar(
        data: "My Listings",
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  buildStatCard(
                    'Listings',
                    '12',
                    Icons.home_work_outlined,
                  ),
                  buildStatCard(
                    'Active',
                    '8',
                    Icons.check_circle_outline,
                  ),
                  buildStatCard(
                    'Total Views',
                    '245',
                    Icons.visibility_outlined,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search properties...',
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF757575)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : propertyListings.isEmpty
                    ? Center(child: Text("You don't hve any listings"))
                    : Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: propertyListings.length,
                          itemBuilder: (context, index) {
                            final property = propertyListings[index];
                            return GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: OwnerPropertyDetails(
                                        property: property),
                                    withNavBar: false);
                              },
                              child: primaryBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(12)),
                                          child:
                                              property.propertyImages != null &&
                                                      property.propertyImages!
                                                          .isNotEmpty
                                                  ? Image.file(
                                                      File(property
                                                          .propertyImages!
                                                          .first),
                                                      height: 200,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/room1.png",
                                                      height: 200,
                                                      width: double.infinity,
                                                      fit: BoxFit.fill,
                                                    ),
                                        ),
                                        Positioned(
                                          top: 12,
                                          right: 12,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color:
                                                  // property['status'] == 'Active'
                                                  // ?
                                                  const Color(0xFF4CAF50),
                                              // : const Color(0xFFFFA000),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'Active',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                property.title ?? 'No Title',
                                                //  "3 BHK Luxury Apartment",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              Text(
                                                //  "₹35000",
                                                property.expectedRent != null
                                                    ? "₹${property.expectedRent}"
                                                    : "N/A",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFE31B23),
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on_outlined,
                                                  size: 16,
                                                  color: Color(0xFF757575)),
                                              SizedBox(width: 4),
                                              Text(
                                                // "Whitefield, Bangalore",
                                                property.city ?? 'Unknown City',
                                                style: TextStyle(
                                                  color: Color(0xFF757575),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              buildPropertyInfo(
                                                  Icons.remove_red_eye_outlined,
                                                  '45 views'),
                                              buildPropertyInfo(
                                                  Icons.message_outlined,
                                                  '8 responses'),
                                              buildPropertyInfo(
                                                  Icons.access_time,
                                                  '2 days ago '),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: OutlinedButton.icon(
                                                  onPressed: () {
                                                    PersistentNavBarNavigator
                                                        .pushNewScreen(context,
                                                            screen:
                                                                OwnerPropertyDetails(
                                                                    property:
                                                                        property),
                                                            withNavBar: false);
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             OwnerPropertyDetails(
                                                    //                 property:
                                                    //                     property)));
                                                  },
                                                  icon: Icon(
                                                      Icons.edit_outlined,
                                                      color: Color(0xFFE31B23)),
                                                  label: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFE31B23)),
                                                  ),
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xFFE31B23)),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: ElevatedButton.icon(
                                                  onPressed: () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? jsonString =
                                                        prefs.getString(
                                                            'property_listings');
                                                    List<PropertyListing>
                                                        propertyList = [];

                                                    if (jsonString != null) {
                                                      List<dynamic> jsonList =
                                                          jsonDecode(
                                                              jsonString);
                                                      propertyList = jsonList
                                                          .map((json) =>
                                                              PropertyListing
                                                                  .fromJson(
                                                                      json))
                                                          .toList();
                                                    }

                                                    if (propertyList.any(
                                                        (listing) =>
                                                            listing.title ==
                                                            property.title)) {
                                                      propertyList.removeWhere(
                                                          (listing) =>
                                                              listing.title ==
                                                              property.title);

                                                      String updatedJsonString =
                                                          jsonEncode(
                                                              propertyList
                                                                  .map((e) => e
                                                                      .toJson())
                                                                  .toList());
                                                      await prefs.setString(
                                                          'property_listings',
                                                          updatedJsonString);

                                                      setState(() {
                                                        propertyListings
                                                            .remove(property);
                                                      });

                                                      commonToast(
                                                          "Property deleted successfully!");
                                                    } else {
                                                      commonToast(
                                                          "Property not found!");
                                                    }
                                                  },
                                                  icon: Icon(Icons.delete,
                                                      color: Colors.white),
                                                  label: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFE31B23),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: const Text('Add Property',
      //       style: TextStyle(
      //           fontFamily: 'Poppins',
      //           fontWeight: FontWeight.w500,
      //           color: Colors.white)),
      //   icon: const Icon(Icons.add, color: Colors.white),
      //   backgroundColor: const Color(0xFFE31B23),
      // ),
    );
  }

  Widget buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: primaryBox(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Color(0xFFE31B23)),
                SizedBox(height: 8),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.black),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPropertyInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Color(0xFF757575)),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Color(0xFF757575),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
