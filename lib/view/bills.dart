import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appbar(data: "Your Bills", showBackArrow: true, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff000000)
                                      .withAlpha((255 * 0.2).toInt()),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  offset: Offset(0.8, 0.8)),
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Not paid yet",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Color(0xff919191).withAlpha(210),
                                        letterSpacing: 0),
                                  ),
                                  Text(
                                    "Late Payment",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Color(0xffD32F2F),
                                        letterSpacing: 0),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 10,
                              color: Color(0xffF5F5F5),
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Due 05 October",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Color(0xff919191),
                                            letterSpacing: 0),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            color: Color(0xff000000)
                                                .withAlpha(210),
                                            size: 20,
                                          ),
                                          Text(
                                            "128",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: Color(0xff000000)
                                                    .withAlpha(210),
                                                letterSpacing: 0),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 18),
                                    decoration: BoxDecoration(
                                      color: Color(0xff009900).withAlpha(230),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Pay",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xffFFFFFF),
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 6,
                    );
                  },
                  itemCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
