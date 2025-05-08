import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/common_form.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/owner_bookings.dart';
import 'package:rentease/view/owner_enquiries_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../common/common_profile.dart';
import '../models/property_listing.dart';

class OwnerPropertyDetails extends StatelessWidget {
  final PropertyListing property;

  const OwnerPropertyDetails({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    bool isSaved = false;
    List images = [
      "assets/images/room1.png",
      "assets/images/room2.png",
      "assets/images/room1.png"
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(overscroll: false),
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: property.propertyImages!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(
                          File(property.propertyImages![index]),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        );
                        //   Image.asset(
                        //   images[index],
                        //   width: double.infinity,
                        //   fit: BoxFit.fill,
                        // );
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
                      count: property.propertyImages!.length,
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
                    padding: EdgeInsets.all(8.0),
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

                        // IconButton(
                        //          onPressed: () {
                        //            setState(() {
                        //              isSaved = !isSaved;
                        //            });
                        //            commonToast(isSaved
                        //                ? "Property saved successfully"
                        //                : "Saved property has been removed");
                        //          },
                        //          icon: isSaved
                        //              ? Icon(
                        //                  Icons.bookmark,
                        //                  size: 24,
                        //                  color: Colors.white,
                        //                )
                        //              : Icon(
                        //                  Icons.bookmark_border,
                        //                  size: 24,
                        //                  color: Colors.white,
                        //                )),

                        // iconHolder(
                        //   child: IconButton(
                        //       onPressed: () {
                        //         // setState(() {
                        //         //   isSaved = !isSaved;
                        //         // });
                        //         // ScaffoldMessenger.of(context).showSnackBar(
                        //         //   // SnackBar(
                        //         //   //   content:
                        //         //   //       Text(isSaved ? "saved" : "Not Saved"),
                        //         //   //   duration: Duration(seconds: 2),
                        //         //   //   behavior: SnackBarBehavior.floating,
                        //         //   //   backgroundColor: Color(0xff000000)
                        //         //   //       .withAlpha((255 * 0.70).toInt()),
                        //         //   // ),
                        //         // );
                        //         commonToast(isSaved
                        //             ? "Property saved successfully"
                        //             : "Saved property has been removed");
                        //       },
                        //       icon: isSaved
                        //           ? Icon(
                        //               Icons.bookmark,
                        //               size: 23,
                        //               color: Colors.white,
                        //             )
                        //           : Icon(
                        //               Icons.bookmark_border,
                        //               size: 23,
                        //               color: Colors.white,
                        //             )),
                        // ),
                        SizedBox(
                          width: 8,
                        ),
                        // IconButton(
                        //         onPressed: () {
                        //           Share.share("Check out this app");
                        //         },
                        //         icon: Icon(
                        //           Icons.share_outlined,
                        //           size: 22,
                        //           color: Colors.white,
                        //         )),

                        // iconHolder(
                        //   child: IconButton(
                        //       onPressed: () {
                        //         Share.share(
                        //             "Check out this property, ${property.title}");
                        //       },
                        //       icon: Icon(
                        //         Icons.share_outlined,
                        //         size: 22,
                        //         color: Colors.white,
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //'3 BHK Apartment in Adajan',
                        property.title ?? 'Property Title',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withAlpha((255 * 0.75).toInt()),
                            fontFamily: "Poppins",
                            letterSpacing: 0),
                      ),
                      SizedBox(height: 8),
                      Text(
                        // 'Adajan 4th Block, Surat',
                        property.address ?? 'Property Address',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),

                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatCard('Total Views', '245'),
                          GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: OwnerEnquiriesList(),
                                    withNavBar: false);
                              },
                              child: buildStatCard('Enquiries', '12')),
                          GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: OwnerBookings(), withNavBar: false);
                              },
                              child: buildStatCard('Bookings', '3')),
                        ],
                      ),

                      const SizedBox(height: 24),

                      header("Property Details"),
                      SizedBox(
                        height: 16,
                      ),
                      primaryInfo(
                          label: "Property Type",
                          value: property.propertyType ?? "Apartment"),

                      primaryInfo(
                          label: "Rent",
                          value: property.expectedRent ?? "₹35,000/month"),

                      primaryInfo(
                          label: "Deposit",
                          value: property.securityDeposit ?? "₹70,000"),

                      primaryInfo(
                          label: "Furnishing",
                          value: property.furnishingStatus ?? "Semi-Furnished"),

                      // Amenities
                      // SizedBox(height: 24),
                      // header("Property Details"),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // Wrap(
                      //   spacing: 8,
                      //   runSpacing: 8,
                      //   children:
                      //       ['WiFi', 'AC', 'Parking', 'Gym', 'Swimming Pool']
                      //           .map((amenity) => Container(
                      //                 padding: const EdgeInsets.symmetric(
                      //                   horizontal: 12,
                      //                   vertical: 6,
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.grey[100],
                      //                   borderRadius: BorderRadius.circular(20),
                      //                 ),
                      //                 child: Text(
                      //                   amenity,
                      //                   style: const TextStyle(fontSize: 12),
                      //                 ),
                      //               ))
                      //           .toList(),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: buildNavbar(
            child: submit(data: "Edit Details", onPressed: () {}, height: 50)));
  }
}
