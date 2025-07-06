import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  Set<String> savedItems = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(
          data: "Nearby your location", showBackArrow: true, context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('properties')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final properties = snapshot.data!.docs;
                  if (properties.isEmpty) {
                    return Center(child: Text('No properties found.'));
                  }
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: properties.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data =
                          properties[index].data() as Map<String, dynamic>;
                      final docId = properties[index].id;
                      final isSaved = savedItems.contains(docId);
                      return Column(
                        children: [
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: Details(propertyId: docId),
                                withNavBar: false,
                              );
                            },
                            child: Container(
                              height: 260,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: data['propertyImages'] != null &&
                                              data['propertyImages'].isNotEmpty
                                          ? data['propertyImages'][0].toString().startsWith('data:image')
                                              ? Image.memory(
                                                  base64Decode(data['propertyImages'][0].split(',')[1]),
                                                  width: double.infinity,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Image.asset(
                                                      "assets/images/room1.png",
                                                      width: double.infinity,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                )
                                              : data['propertyImages'][0].toString().startsWith('http')
                                                  ? Image.network(
                                                      data['propertyImages'][0],
                                                      width: double.infinity,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Image.asset(
                                                          "assets/images/room1.png",
                                                          width: double.infinity,
                                                          height: 150,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    )
                                                  : Image.asset(
                                                      "assets/images/room1.png",
                                                      width: double.infinity,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                    )
                                          : Image.asset(
                                              "assets/images/room1.png",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      data['title'] ?? 'No Title',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      data['city'] ?? '',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            size: 18,
                                            weight: 900,
                                            applyTextScaling: true,
                                            grade: 50,
                                            color: Color(0xff030201),
                                          ),
                                          Text(
                                            data['expectedRent']?.toString() ??
                                                '-',
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Spacer(),






















                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5,
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
