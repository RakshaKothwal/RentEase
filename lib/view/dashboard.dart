import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/changeCity.dart';
import 'package:rentease/view/details.dart';
import 'package:rentease/view/filter.dart';
import 'package:rentease/view/listing.dart';
import 'package:rentease/view/notifications.dart';

import 'navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchController = TextEditingController();
  List<String> propertyType = ["PG", "Hostel", "Flat", "House"];
  int selectedIndex = -1;

  List<String> occupancy = ["Single", "Twin Sharing", "Triple Sharing"];
  int occupancyIndex = -1;

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
        // leading: SvgPicture.asset(
        //   "assets/svg/menu.svg",
        //   height: 24,
        //   width: 24,
        //   clipBehavior: Clip.hardEdge,
        // ),
        // titleSpacing: -5,
        // centerTitle: true,
        /*title: Text(
          "RentEase",
          style: TextStyle(
              color: Color(0xffD32F2F),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w800,
              fontSize: 24),*/
        // ),
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
            // SizedBox(
            //   height: 5,
            // ),
            Padding(
              padding: horizontalPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child:
                          // input(
                          //     icon: Icons.search,
                          //     hintText: "Search through localities"),
                          TextSelectionTheme(
                        data: TextSelectionThemeData(
                            selectionHandleColor: Color(0xffD32F2F)),
                        child: TextField(
                          readOnly: false,
                          // onTap: () {
                          //   PersistentNavBarNavigator.pushNewScreen(context,
                          //       screen: Search(), withNavBar: false);
                          // },
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
                              // color: Color(0xff838383),
                              size: 24,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                // color: Color(0xff858585),
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
                  // Spacer(),
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
                        // width: 100,
                        decoration: selectedIndex == index
                            ? BoxDecoration(
                                color: Color(0xffD32F2F),
                                borderRadius: BorderRadius.circular(20),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Color(0xffECECEC), width: 1.2),

                                // color: Color(0xffF5F5F5)
                                // border: Border.all(
                                //     color: Color(0xffB2B2B2), width: 1.3),
                                // color: Color(0xffF5F4F8),
                              ),
                        // color: Color(0xffB2B2B2)),
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
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: horizontalPadding,
                        child: Row(
                          children: [
                            Text(
                              "Nearby Your Location",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway",
                                  color: Colors.black),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: Listing(), withNavBar: false);
                              },
                              child: Text(
                                "View all",
                                style: TextStyle(
                                    color: Color(0xffD32F2F),
                                    // color: Color(0xffA8A8A8),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 235,
                        child: ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: ListView.separated(
                              padding: horizontalPadding,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: GestureDetector(
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: Details(),
                                          withNavBar: false);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            child: Image.asset(
                                              height: 150,
                                              width: double.infinity,
                                              // width: 200,
                                              "assets/images/room1.png",
                                              fit: BoxFit.fill,
                                            )),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Star Paying Guest",
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "Adajan, Surat",
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey[600]),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
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
                                                    "15,000",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black
                                                            .withAlpha(230)),
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
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 8,
                                );
                              },
                              itemCount: 5),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: horizontalPadding,
                        child: Row(
                          children: [
                            Text(
                              "Most Popular",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway",
                                  color: Colors.black),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: Listing(), withNavBar: false);
                              },
                              child: Text(
                                "View all",
                                style: TextStyle(
                                    color: Color(0xffD32F2F),
                                    // color: Color(0xffA8A8A8),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: horizontalPadding,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: Details(), withNavBar: false);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(13),
                                        child: Image.asset(
                                          "assets/images/room1.png",
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width: 80,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Star Paying Guest",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Adajan, Surat",
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
                                                "15,000",
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: 3),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
