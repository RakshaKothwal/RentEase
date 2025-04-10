import 'package:flutter/material.dart';

import '../common/global_widget.dart';
import 'navbar.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<String> propertyType = ["All", "PG", "Hostel", "Flat", "House"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final navbarState = context.findAncestorStateOfType<NavbarState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "Saved"),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   scrolledUnderElevation: 0,
      //   title: Text(
      //     "Saved",
      //     style: TextStyle(
      //         fontWeight: FontWeight.w600, fontSize: 18, fontFamily: "Poppins"),
      //   ),
      // ),
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
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: horizontalPadding,
              itemBuilder: (BuildContext context, int index) {
                return Container(
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
                          child: Image.asset(
                            "assets/images/room1.png",
                            height: MediaQuery.of(context).size.height,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Star Paying Guest",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  // Text("hello")
                                  GestureDetector(
                                      onTap: () {
                                        customBottomSheet(
                                          context: context,
                                          toggleNavBar:
                                              navbarState?.toggleNavBar ??
                                                  (bool _) {},

                                          // showModalBottomSheet(
                                          //     backgroundColor: Color(0xffEDEDED),
                                          //     // backgroundColor: Colors.white,
                                          //     context: context,
                                          //     builder: (BuildContext context) {
                                          //       return Wrap(children: [
                                          //         SizedBox(
                                          //           width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Remove from Saved?",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xff2A2B3F)),
                                                  ),
                                                  SizedBox(height: 12),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style: TextButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xffD32F2F),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                            ),
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                        child: TextButton(
                                                            onPressed: () {},
                                                            style: TextButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xffD32F2F),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                            ),
                                                            child: Text(
                                                              "Yes, Remove",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                        //     ),
                                        //   ]);
                                        // });
                                      },
                                      child: Icon(Icons.more_vert))
                                ],
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
                          ),
                        )
                      ],
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
        ],
      ),
    );
  }
}
