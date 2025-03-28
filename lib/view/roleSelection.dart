import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/login.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //   scrolledUnderElevation: 0,
        //   // leading: SvgPicture.asset(
        //   //   "assets/svg/menu.svg",
        //   //   height: 24,
        //   //   width: 24,
        //   //   clipBehavior: Clip.hardEdge,
        //   // ),
        //   // titleSpacing: -5,
        //   // centerTitle: true,
        //   title: Text(
        //     "RentEase",
        //     style: TextStyle(
        //         color: Color(0xffD32F2F),
        //         fontFamily: "Montserrat",
        //         fontWeight: FontWeight.w800,
        //         fontSize: 24),
        //   ),
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        //   toolbarTextStyle: TextStyle(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 50,
            // ),
            Text(
              "How would you like \nto use the app?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withAlpha(210),
                fontWeight: FontWeight.w700,
                fontFamily: "Inter",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black.withAlpha(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(20, 0, 0, 0),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(2, 2),
                      ),
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(-2, -2),
                        color: Color.fromARGB(20, 0, 0, 0),
                      ),
                    ]),
                child: Padding(
                  padding: horizontalPadding,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center(
                      //   child: Icon(
                      //     Icons.info,
                      //     color: Color(0xffD32F2F).withAlpha(240),
                      //     size: 30,
                      //   ),
                      // ),
                      // SizedBox(),
                      // SizedBox(
                      //   width: 30,
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Center(
                          child: Text(
                            "Find a place to stay",
                            style: TextStyle(
                              fontSize: 16,
                              // color: Color(0xffD32F2F),
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black.withAlpha(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(20, 0, 0, 0),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(2, 2),
                    ),
                    BoxShadow(
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(-2, -2),
                      color: Color.fromARGB(20, 0, 0, 0),
                    ),
                  ]),
              child: Center(
                child: Text(
                  "Rent out a place",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffD32F2F),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Inter",
                  ),
                  // child: Padding(
                  //   padding: horizontalPadding,
                  //   child: Row(
                  //     children: [
                  //       // Icon(
                  //       //   Icons.real_estate_agent,
                  //       //   size: 33,
                  //       //   color: Color(0xffD32F2F),
                  //       // ),
                  //       SizedBox(
                  //         width: 30,
                  //       ),
                  //       Center(
                  //         child: Text(
                  //           "Rent out a place",
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             color: Color(0xffD32F2F),
                  //             fontWeight: FontWeight.w700,
                  //             fontFamily: "Inter",
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
