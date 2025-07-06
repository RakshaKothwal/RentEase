import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Myenquiry extends StatefulWidget {
  const Myenquiry({super.key});

  @override
  State<Myenquiry> createState() => _MyenquiryState();
}

class _MyenquiryState extends State<Myenquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: appbar(data: "My Enquiry", showBackArrow: true, context: context),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [



                primaryBox(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: horizontalPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pending",
                              style: TextStyle(
                                color: Color(0xffF23333),

                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "05 Sep 2023",
                              style: TextStyle(
                                color: Color(0xffB2B2B2),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            )
                          ],
                        ),
                      ),



                      Divider(
                        color: Color(0xffF5F5F5),
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: horizontalPadding,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                fit: BoxFit.cover,
                                "assets/images/room1.png",
                                height: 80,
                                width: 80,
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
                                  Text(
                                    "Star Residence Apartment",
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black
                                            .withAlpha((255 * 0.9).toInt()),
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400),
                                  ),



                                  Row(children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 16,
                                      color: Colors.grey,
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
                                          color: Color(0xff818181)),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 17,
                                        weight: 900,
                                        applyTextScaling: true,
                                        grade: 50,
                                        color: Colors.black
                                            .withAlpha((255 * 0.75).toInt()),
                                      ),
                                      Text(
                                        "15,000",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black.withAlpha(
                                                (255 * 0.75).toInt())),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),



              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: 6,
        ),
      ),
    );
  }
}
