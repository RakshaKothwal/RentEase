import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/changeCity.dart';
import 'package:rentease/view/details.dart';
import 'package:rentease/view/filter.dart';

import 'package:rentease/view/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'dart:convert';

import 'navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchController = TextEditingController();
  List<String> propertyType = ["All", "PG", "Hostel", "Flat", "House"];
  int selectedIndex = 0;

  List<String> occupancy = ["Single", "Twin Sharing", "Triple Sharing"];
  int occupancyIndex = -1;

  String searchQuery = '';

  Stream<firestore.QuerySnapshot> getPropertyStream() {
    firestore.Query<Map<String, dynamic>> query =
        firestore.FirebaseFirestore.instance.collection('properties');
    if (selectedIndex > 0) {
      query =
          query.where('propertyType', isEqualTo: propertyType[selectedIndex]);
    }
    if (searchQuery.isNotEmpty) {
      query = query
          .where('title', isGreaterThanOrEqualTo: searchQuery)
          .where('title', isLessThanOrEqualTo: '$searchQuery\uf8ff');
    }
    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final navbarState = context.findAncestorStateOfType<NavbarState>();
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: GestureDetector(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: Changecity(), withNavBar: false);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Surat",
                style: TextStyle(
                    color: Colors.black.withAlpha((255 * 0.8).toInt()),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w800,
                    fontSize: 22),
              ),
              SizedBox(
                width: 2,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black.withAlpha((255 * 0.8).toInt()),
                size: 24,
              )
            ],
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: Notifications(), withNavBar: false);
                },
                icon: Icon(
                  Icons.notifications,
                  size: 24,
                  color: Color(0xff363C45),
                ),
              ),
              Positioned(
                top: 14,
                right: 16,
                child: Container(
                  height: 7,
                  width: 7,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        toolbarTextStyle: TextStyle(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: horizontalPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextSelectionTheme(
                        data: TextSelectionThemeData(
                            selectionHandleColor: Color(0xffD32F2F)),
                        child: TextField(
                          readOnly: false,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400),
                          controller: searchController,
                          cursorColor: Color(0xffD32F2F),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            fillColor: Color(0xffF5F5F5),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xffA8A8A8),
                              size: 24,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: Color(0xffA8A8A8),
                                fontSize: 16,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      customBottomSheet(
                          context: context,
                          toggleNavBar:
                              navbarState?.toggleNavBar ?? (bool _) {},
                          child: Filter());
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffD32F2F),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/svg/filter-horizontal.svg",
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 32,
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
                          ),
                        ),
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
              child: StreamBuilder<firestore.QuerySnapshot>(
                stream: getPropertyStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final properties = snapshot.data!.docs;
                  if (properties.isEmpty) {
                    return Center(child: Text('No properties found.'));
                  }
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.vertical,
                    itemCount: properties.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final data =
                          properties[index].data() as Map<String, dynamic>;
                      final docId = properties[index].id;
                      return GestureDetector(
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
                                      ? data['propertyImages'][0]
                                              .toString()
                                              .startsWith('data:image')
                                          ? Image.memory(
                                              base64Decode(
                                                  data['propertyImages'][0]
                                                      .split(',')[1]),
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/images/room1.png",
                                                  width: double.infinity,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                          : data['propertyImages'][0]
                                                  .toString()
                                                  .startsWith('http')
                                              ? Image.network(
                                                  data['propertyImages'][0],
                                                  width: double.infinity,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
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
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  data['city'] ?? '',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600],
                                  ),
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
                                        data['expectedRent']?.toString() ?? '-',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
