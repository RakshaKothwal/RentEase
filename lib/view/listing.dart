import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/details.dart';

class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  // bool isSaved = false;
  Set<int> savedItems = {};
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
            Flexible(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSaved = savedItems.contains(index);
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: Details(), withNavBar: false);
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
                                      child: Image.asset(
                                        "assets/images/room1.png",
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
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
                                            "15,000",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isSaved
                                                      ? savedItems.remove(index)
                                                      : savedItems.add(index);
                                                });
                                                commonToast(!isSaved
                                                    ? "Property saved successfully"
                                                    : "Saved property has been removed");
                                              },
                                              child: isSaved
                                                  ? Icon(
                                                      Icons.bookmark,
                                                      size: 24,
                                                      color: Colors.black
                                                          .withAlpha(200),
                                                    )
                                                  : Icon(
                                                      Icons.bookmark_border,
                                                      size: 24,
                                                      color: Colors.black
                                                          .withAlpha(200),
                                                    )),
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
                    itemCount: 5),
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
