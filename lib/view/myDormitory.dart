import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/bills.dart';
import 'package:rentease/view/my_contract.dart';
import 'package:rentease/view/myreview.dart';

class Mydormitory extends StatefulWidget {
  const Mydormitory({super.key});

  @override
  State<Mydormitory> createState() => _MydormitoryState();
}

class _MydormitoryState extends State<Mydormitory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "My Dormitory"),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hello David!",
                      style: TextStyle(
                          color: Color(0xff000000).withAlpha((255 * 1).toInt()),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Dormitory you are currently staying in",
                      style: TextStyle(
                          color:
                              Color(0xff000000).withAlpha((255 * 0.9).toInt()),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(21),
                          child: Image.asset(
                            fit: BoxFit.fill,
                            "assets/images/room1.png",
                            height: 130,
                            width: 130,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                // height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffD32F2F)),
                                child: Text(
                                  "Girls",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Star Residence Apartment",
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black
                                        .withAlpha((255 * 0.7).toInt()),
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Colors.black
                                      .withAlpha((255 * 0.9).toInt()),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Adajan, Surat",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                          .withAlpha((255 * 0.9).toInt())),
                                ),
                              ]),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Wifi - AC - Attached bath - 24/7 UPS",
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color(0xff828282),
                                    fontSize: 10,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: Myreview());
                      },
                      child: Container(
                        width: double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(width: 1, color: Color(0xffB2B2B2))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/review.svg",
                              colorFilter: ColorFilter.mode(
                                  Color(0xff000000)
                                      .withAlpha((255 * 0.9).toInt()),
                                  BlendMode.srcIn),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "How was your Dormitory experience?",
                                  style: TextStyle(
                                      letterSpacing: 0,
                                      color: Color(0xff000000)
                                          .withAlpha((255 * 0.9).toInt()),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Is it fun or does it need to be improved?",
                                  style: TextStyle(
                                      color: Color(0xff000000)
                                          .withAlpha((255 * 0.7).toInt()),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                                Text(
                                  "Come on, write your review",
                                  style: TextStyle(
                                      color: Color(0xff000000)
                                          .withAlpha((255 * 0.7).toInt()),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Color(0xffF5F5F5),
                thickness: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "My Dormitory Activities",
                      style: TextStyle(
                          letterSpacing: 0,
                          color:
                              Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mycontract()));
                          },
                          child: dormContainer(
                              leading: SvgPicture.asset(
                                "assets/svg/contract.svg",
                                height: 34,
                                width: 34,
                              ),
                              data: "Contract"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Bills()));
                          },
                          child: dormContainer(
                              // leading: Icon(
                              //   Icons.monetization_on,
                              //   color:
                              //       Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                              //   size: 40,
                              // ),
                              // height: 12,
                              // data: "Your Bills"),
                              leading: SvgPicture.asset(
                                "assets/svg/bill2.svg",
                                colorFilter: ColorFilter.mode(
                                    Color(0xff000000)
                                        .withAlpha((255 * 0.8).toInt()),
                                    BlendMode.srcIn),
                                height: 38,
                                width: 34,
                              ),
                              data: "Your Bills"),
                        ),
                        dormContainer(
                            leading: SvgPicture.asset(
                              "assets/svg/chat.svg",
                              height: 36,
                              width: 30,
                            ),
                            data: "Owner Chat")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
