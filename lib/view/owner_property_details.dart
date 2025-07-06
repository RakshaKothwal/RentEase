import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:convert';
import 'dart:io';

import '../common/common_form.dart';
import '../common/common_profile.dart';
import '../common/global_widget.dart';
import '../models/property_listing.dart';
import '../view/edit_property.dart';
import '../view/owner_scheduled_visits.dart';

class OwnerPropertyDetails extends StatefulWidget {
  final PropertyListing property;

  const OwnerPropertyDetails({super.key, required this.property});

  @override
  _OwnerPropertyDetailsState createState() => _OwnerPropertyDetailsState();
}

class _OwnerPropertyDetailsState extends State<OwnerPropertyDetails> {
  int visitCount = 0;

  @override
  void initState() {
    super.initState();
    _loadVisitCount();
  }

  Future<void> _loadVisitCount() async {
    try {
      final visitsSnapshot = await FirebaseFirestore.instance
          .collection('scheduledVisits')
          .where('propertyId', isEqualTo: widget.property.id)
          .get();
      
      setState(() {
        visitCount = visitsSnapshot.docs.length;
      });
    } catch (e) {
      print('Error loading visit count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    bool isSaved = false;
    List images = [
      "assets/images/room1.png",
      "assets/images/room2.png",
      "assets/images/room1.png",
      "assets/images/room2.png",
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
                      itemCount: widget.property.propertyImages!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return widget.property.propertyImages![index]
                                .startsWith('data:image')
                            ? Image.memory(
                                base64Decode(widget.property.propertyImages![index]
                                    .split(',')[1]),
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
                            : widget.property.propertyImages![index].startsWith('http')
                                ? Image.network(
                                    widget.property.propertyImages![index],
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
                                : Image.file(
                                    File(widget.property.propertyImages![index]),
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
                      count: widget.property.propertyImages!.length,
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
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.property.title ?? 'Property Title',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                              color:
                                  Colors.black.withAlpha((255 * 0.75).toInt()),
                            fontFamily: "Poppins",
                            letterSpacing: 0),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.property.address ?? 'Property Address',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                                  fontFamily: "Poppins",
                                ),
                              ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 18,
                                  weight: 900,
                                  applyTextScaling: true,
                                  grade: 50,
                                  color: Color(0xff030201),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expected Rent",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    Text(
                                      widget.property.expectedRent ?? "₹35,000/month",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff030201),
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 18,
                                  weight: 900,
                                  applyTextScaling: true,
                                  grade: 50,
                                  color: Color(0xff030201),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Security Deposit",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    Text(
                                      widget.property.securityDeposit ?? "₹70,000",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff030201),
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (widget.property.maintenanceCharges != null &&
                                widget.property.maintenanceCharges!.isNotEmpty) ...[
                              SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    size: 18,
                                    weight: 900,
                                    applyTextScaling: true,
                                    grade: 50,
                                    color: Color(0xff030201),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Maintenance Charges",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      Text(
                                        widget.property.maintenanceCharges!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff030201),
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      header("Property Details"),
                      SizedBox(
                        height: 16,
                      ),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              if (widget.property.propertyType != null &&
                                  widget.property.propertyType!.isNotEmpty)
                                _buildDetailRow(Icons.home, "Property Type",
                                    widget.property.propertyType!),
                              if (widget.property.furnishingStatus != null &&
                                  widget.property.furnishingStatus!.isNotEmpty)
                                _buildDetailRow(Icons.chair, "Furnishing",
                                    widget.property.furnishingStatus!),
                              if (widget.property.numberOfBedrooms != null &&
                                  widget.property.numberOfBedrooms
                                      .toString()
                                      .isNotEmpty)
                                _buildDetailRow(Icons.bed, "Bedrooms",
                                    widget.property.numberOfBedrooms.toString()),
                              if (widget.property.numberOfBathrooms != null &&
                                  widget.property.numberOfBathrooms
                                      .toString()
                                      .isNotEmpty)
                                _buildDetailRow(Icons.bathroom, "Bathrooms",
                                    widget.property.numberOfBathrooms.toString()),
                              if (widget.property.parkingAvailability != null &&
                                  widget.property.parkingAvailability!.isNotEmpty)
                                _buildDetailRow(Icons.local_parking, "Parking",
                                    widget.property.parkingAvailability!),
                              if (widget.property.mealAvailability != null &&
                                  widget.property.mealAvailability!.isNotEmpty)
                                _buildDetailRow(
                                    Icons.restaurant,
                                    "Meal Availability",
                                    widget.property.mealAvailability!),
                              if (widget.property.preferredGender != null &&
                                  widget.property.preferredGender!.isNotEmpty)
                                _buildDetailRow(
                                    Icons.person,
                                    "Preferred Gender",
                                    widget.property.preferredGender!),
                              if (widget.property.preferredTenant != null &&
                                  (widget.property.preferredTenant as List).isNotEmpty)
                                _buildDetailRow(
                                    Icons.people,
                                    "Preferred Tenant",
                                    (widget.property.preferredTenant as List)
                                        .join(', ')),
                              if (widget.property.selectedMeals != null &&
                                  (widget.property.selectedMeals as List).isNotEmpty)
                                _buildDetailRow(
                                    Icons.fastfood,
                                    "Selected Meals",
                                    (widget.property.selectedMeals as List)
                                        .join(', ')),
                              if (widget.property.sharingType != null &&
                                  (widget.property.sharingType as List).isNotEmpty)
                                _buildDetailRow(Icons.group, "Sharing Type",
                                    (widget.property.sharingType as List).join(', ')),
                              if (widget.property.totalNumberOfBeds != null &&
                                  widget.property.totalNumberOfBeds
                                      .toString()
                                      .isNotEmpty)
                                _buildDetailRow(
                                    Icons.bedroom_parent,
                                    "Total Beds",
                                    widget.property.totalNumberOfBeds.toString()),
                              if (widget.property.noticePeriod != null &&
                                  widget.property.noticePeriod!.isNotEmpty)
                                _buildDetailRow(Icons.schedule, "Notice Period",
                                    widget.property.noticePeriod!),
                              if (widget.property.landmark != null &&
                                  widget.property.landmark!.isNotEmpty)
                                _buildDetailRow(Icons.place, "Landmark",
                                    widget.property.landmark!),
                              if (widget.property.pinCode != null &&
                                  widget.property.pinCode!.isNotEmpty)
                                _buildDetailRow(Icons.location_on, "Pin Code",
                                    widget.property.pinCode!),
                            ],
                          ),
                        ),
                        if (widget.property.description != null &&
                            widget.property.description!.isNotEmpty) ...[
                          SizedBox(height: 24),
                          header("Description"),
                          SizedBox(height: 16),
                          Text(
                            widget.property.description!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                        ],
                        SizedBox(height: 24),
                        header("Amenities"),
                        SizedBox(height: 16),
                        if (widget.property.selectedAmenities != null &&
                            (widget.property.selectedAmenities as List).isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (var amenity
                                  in widget.property.selectedAmenities as List)
                                Chip(
                                  label: Text(
                                    amenity.toString(),
                                    style: TextStyle(
                                      color: Color(0xff808080),
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: Color(0xffF5F5F5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color: Color(0xffB2B2B2)),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                            ],
                          )
                        else
                          Text(
                            "No amenities listed.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        SizedBox(height: 24),
                        header("Allowed Activities"),
                        SizedBox(height: 16),
                        if (widget.property.selectedHouseRules != null &&
                            (widget.property.selectedHouseRules as List).isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (var rule
                                  in widget.property.selectedHouseRules as List)
                                Chip(
                                  label: Text(
                                    rule.toString(),
                                    style: TextStyle(
                                      color: Color(0xff808080),
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: Color(0xffF5F5F5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color: Color(0xffB2B2B2)),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                            ],
                          )
                        else
                          Text(
                            "No house rules listed.",
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: buildNavbar(
            child: submit(
                data: "Edit Details",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProperty(property: widget.property),
                    ),
                  );
                },
                height: 50)));
  }
}

Widget _buildDetailRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
