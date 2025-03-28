import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../common/global_widget.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  PageController pageController = PageController();
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
    {"Room Cleaning": "assets/svg/roomCleaning.svg"},
    {"Fridge": "assets/svg/fridge.svg"},
    {"Water Cooler": "assets/svg/water-dispenser.svg"},
  ];

  List houseRules = [
    {"Smoking": "assets/svg/smoking.svg"},
    {"Alcohol": "assets/svg/alcohol.svg"},
    {"Loud Music": "assets/svg/loudMusic.svg"},
    {"Party": "assets/svg/party.svg"},
    {"Non Veg": "assets/svg/fish.svg"},
    {"Visitor Entry": "assets/svg/visitor.svg"},
    // {"Non Veg": "assets/svg/fish2.svg"},
    // {"Opposite Gender": "assets/svg/oppositeGender.svg"},
    // {"gender": "assets/svg/persons.svg"},
  ];

  List houseRuleStatus = [
    false,
    false,
    false,
    true,
    false,
    true,
  ];

  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
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
                      return Image.asset(
                        images[index],
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isSaved = !isSaved;
                          });
                          commonToast(isSaved
                              ? "Property saved successfully"
                              : "Saved property has been removed");
                        },
                        icon: isSaved
                            ? Icon(
                                Icons.bookmark,
                                size: 26,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.bookmark_border,
                                size: 26,
                                color: Colors.white,
                              )),
                    IconButton(
                        onPressed: () {
                          Share.share("Check out this app");
                        },
                        icon: Icon(
                          Icons.share_outlined,
                          size: 26,
                          color: Colors.white,
                        ))
                  ],
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
                                "Star Paying Guest",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.black.withAlpha(210)
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
                                "15,000",
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
                              "Adajan, Surat",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ]),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 25,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffD32F2F)),
                            child: Center(
                              child: Text(
                                "For Boys",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    // DefaultTabController(
                    //     length: 2,
                    //     child: TabBar(
                    //         labelColor: Color(0xffD32F2F),
                    //         dividerColor: Color(0xffF5F5F5),
                    //         dividerHeight: 5,
                    //         indicatorColor: Color(0xffD32F2F),
                    //         tabs: [
                    //           Tab(
                    //             text: "Description",
                    //           ),
                    //           Tab(text: "Details")
                    //         ])),
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
                          Text(
                            "This Dormitory consists of 3 floors, Room type A (vip) is at the top with windows facing outside and towards the corridor.There is also a regular AC cleaning service every 3 months. If you need help, you can contact the guard on the duty 24/7.",
                            style: TextStyle(
                                color: Color(0xff808080),
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
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
                            "PG Details",
                            style: TextStyle(
                                // color: Color(0xff020403),
                                color: Colors.black.withAlpha(210),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 20,
                                      crossAxisCount: 2,
                                      childAspectRatio: 3),
                              itemCount: pgDetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                final details = pgDetails[index];
                                final title = details.keys.first;
                                final value = details.values.first;
                                return Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          title,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Inter",
                                              // color: Color(0xff696969),
                                              color: Color(0xff808080)
                                              // color: Color(0xff474747)
                                              ),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Inter",
                                              color:
                                                  Colors.black.withAlpha(200)),
                                        ))
                                  ],
                                );
                              }),
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
                          GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: amenities.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 1.4,
                                      crossAxisCount: 3),
                              itemBuilder: (BuildContext context, int index) {
                                final amenitiesIndex = amenities[index];
                                final amenityImg = amenitiesIndex.values.first;
                                final title = amenitiesIndex.keys.first;
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Color(0xffB2B2B2))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        amenityImg,
                                        height: 30,
                                        width: 30,
                                        colorFilter: ColorFilter.mode(
                                            Colors.grey, BlendMode.srcIn),
                                        // Color(0xffB2B2B2),
                                        // BlendMode.srcIn),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        title,
                                        style: TextStyle(
                                            color: Color(0xff808080),
                                            // color: Colors.black.withAlpha(160),
                                            // color: Color(0xffB2B2B2),
                                            fontFamily: "Inter",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                );
                              }),
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
                            "House Rules",
                            style: TextStyle(
                                color: Colors.black.withAlpha(210),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: houseRules.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 0.8,
                                      crossAxisCount: 4),
                              itemBuilder: (BuildContext context, int index) {
                                final rulesIndex = houseRules[index];
                                final rulesImg = rulesIndex.values.first;
                                final title = rulesIndex.keys.first;
                                final bool isAllowed = houseRuleStatus[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.transparent,
                                      )),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          rulesImg,
                                          height: 30,
                                          width: 30,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withAlpha(180),
                                              BlendMode.srcIn),
                                          // Color(0xffB2B2B2),
                                          // BlendMode.srcIn),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          title,
                                          style: TextStyle(
                                              color: Color(0xff808080),
                                              // color: Colors.black.withAlpha(160),
                                              // color: Color(0xffB2B2B2),
                                              fontFamily: "Inter",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        isAllowed
                                            ? Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: Colors.green,
                                                size: 20,
                                              )
                                            : Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
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
                                // color: Color(0xff2A2B3F),
                                size: 15,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Flexible(
                                child: Text(
                                  softWrap: true,
                                  "Aarya Swayam Bliss, Jalaramnager, Adajan, Surat",
                                  style: TextStyle(
                                      color: Color(0xff808080),
                                      // color: Color(0xff2A2B3F),
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
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
                                    // color: Colors.grey.shade400.withAlpha(120),
                                    color: Colors.grey.shade400.withAlpha(120),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))
                                    // borderRadius: BorderRadius.vertical(
                                    //   bottom: Radius.circular(10),
                                    // )
                                    ),
                                child: Center(
                                  child: Text(
                                    "View on Map",
                                    style: TextStyle(
                                        color: Colors.black.withAlpha(120),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: "Inter"),
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
                      child: submit(data: "Contact Owner", onPressed: () {}),
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
}
