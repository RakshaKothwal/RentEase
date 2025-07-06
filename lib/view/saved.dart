import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'dart:convert';

import '../common/global_widget.dart';
import 'navbar.dart';
import 'details.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<String> propertyType = ["All", "PG", "Hostel", "Flat", "House"];
  int selectedIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId {
    return _auth.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (userId.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(data: "Saved"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.login,
                size: 64,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'Please login to view saved properties',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "Saved"),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 34,
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: ListView.separated(
                padding: horizontalPadding,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: selectedIndex == index
                          ? BoxDecoration(
                              color: Color(0xffD32F2F),
                              borderRadius: BorderRadius.circular(20),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Color(0xffECECEC), width: 1.2),
                            ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          propertyType[index],
                          style: selectedIndex == index
                              ? TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)
                              : TextStyle(
                                  color: Color(0xff606060),
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                        ),
                      )),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 8,
                  );
                },
                itemCount: propertyType.length,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .collection('savedProperties')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final savedDocs = snapshot.data!.docs;
                if (savedDocs.isEmpty) {
                  return Center(
                    child: Text(
                      'No saved properties.',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  );
                }
                final savedIds = savedDocs.map((doc) => doc.id).toList();
                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('properties')
                      .where(FieldPath.documentId, whereIn: savedIds)
                      .get(),
                  builder: (context, propSnapshot) {
                    if (!propSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final properties = propSnapshot.data!.docs;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: horizontalPadding,
                      itemCount: properties.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data =
                            properties[index].data() as Map<String, dynamic>;
                        final docId = properties[index].id;
                        return GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: Details(propertyId: docId),
                                withNavBar: false);
                            
                          },
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 6, left: 8, bottom: 6, right: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: data['propertyImages'] != null &&
                                            data['propertyImages'].isNotEmpty
                                        ? data['propertyImages'][0]
                                                .toString()
                                                .startsWith('data:image')
                                            ? Image.memory(
                                                base64Decode(
                                                    data['propertyImages'][0]
                                                        .split(',')[1]),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.12,
                                                width: 80,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    "assets/images/room1.png",
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.12,
                                                    width: 80,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                            : data['propertyImages'][0]
                                                    .toString()
                                                    .startsWith('http')
                                                ? Image.network(
                                                    data['propertyImages'][0],
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.12,
                                                    width: 80,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        "assets/images/room1.png",
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.12,
                                                        width: 80,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  )
                                                : Image.asset(
                                                    "assets/images/room1.png",
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.12,
                                                    width: 80,
                                                    fit: BoxFit.cover,
                                                  )
                                        : Image.asset(
                                            "assets/images/room1.png",
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.12,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data['title'] ?? '',
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                primaryDialogBox(
                                                  context: context,
                                                  title:
                                                      Text("Remove from saved"),
                                                  contentText:
                                                      "Are you sure you want to remove this property from your saved list?",
                                                  successText: "Remove",
                                                  unsuccessText: "Cancel",
                                                  successTap: () async {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(userId)
                                                        .collection(
                                                            'savedProperties')
                                                        .doc(docId)
                                                        .delete();
                                                    commonToast(
                                                        'Saved property has been removed');
                                                  },
                                                );
                                              },
                                              child: Icon(Icons.more_vert),
                                            ),
                                          ],
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
                                        Row(
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
                                              data['expectedRent']
                                                      ?.toString() ??
                                                  '-',
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
