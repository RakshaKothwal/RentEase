import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/edit_profile.dart';
import 'package:rentease/view/message.dart';
import 'package:rentease/view/myDormitory.dart';
import 'package:rentease/view/setting.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Color(0xffF5F5F5),
          title: Text("Profile"),
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: horizontalPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  primaryBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              maxRadius: 30,
                              minRadius: 30,
                              backgroundImage: AssetImage(
                                "assets/images/profile4.png",
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Raksha Kothwal",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(
                              //   height: 1,
                              // ),
                              // Text(
                              //   "rakshakothwal@gmail.com",
                              //   style: TextStyle(
                              //       color: Color(0xff919191),
                              //       fontSize: 12,
                              //       fontFamily: "Poppins",
                              //       fontWeight: FontWeight.w500),
                              // ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "+91 9837839299",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: EditProfile(),
                                withNavBar: false,
                              );
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => EditProfile()));
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 22,
                              // color: Color(0xff919191),
                              color:
                                  Colors.black.withAlpha((255 * 0.8).toInt()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //             color: Color(0xff000000)
                  //                 .withAlpha((255 * 0.1).toInt()),
                  //             blurRadius: 10,
                  //             spreadRadius: 0,
                  //             offset: Offset(2, 2))
                  //       ],
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Color(0xffFFFFFF)),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 14, horizontal: 15),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         CircleAvatar(
                  //             maxRadius: 30,
                  //             minRadius: 30,
                  //             backgroundImage: AssetImage(
                  //               "assets/images/profile4.png",
                  //             )),
                  //         SizedBox(
                  //           width: 15,
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Raksha Kothwal",
                  //               style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 16,
                  //                   fontFamily: "Poppins",
                  //                   fontWeight: FontWeight.w600),
                  //             ),
                  //             // SizedBox(
                  //             //   height: 1,
                  //             // ),
                  //             // Text(
                  //             //   "rakshakothwal@gmail.com",
                  //             //   style: TextStyle(
                  //             //       color: Color(0xff919191),
                  //             //       fontSize: 12,
                  //             //       fontFamily: "Poppins",
                  //             //       fontWeight: FontWeight.w500),
                  //             // ),
                  //             SizedBox(
                  //               height: 2,
                  //             ),
                  //             Text(
                  //               "+91 9837839299",
                  //               style: TextStyle(
                  //                   color: Color(0xff919191),
                  //                   fontSize: 12,
                  //                   fontFamily: "Poppins",
                  //                   fontWeight: FontWeight.w500),
                  //             )
                  //           ],
                  //         ),
                  //         Spacer(),
                  //         GestureDetector(
                  //           onTap: () {
                  //             PersistentNavBarNavigator.pushNewScreen(
                  //               context,
                  //               screen: EditProfile(),
                  //               withNavBar: false,
                  //             );
                  //             // Navigator.push(
                  //             //     context,
                  //             //     MaterialPageRoute(
                  //             //         builder: (context) => EditProfile()));
                  //           },
                  //           child: Icon(
                  //             Icons.arrow_forward_ios,
                  //             size: 22,
                  //             // color: Color(0xff919191),
                  //             color:
                  //                 Colors.black.withAlpha((255 * 0.8).toInt()),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  primaryBox(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      children: [
                        primaryRow(
                            icon: Icons.home_outlined,
                            data: "Rental Application History"),
                        SizedBox(
                          height: 16,
                        ),
                        primaryRow(
                            icon: Icons.history, data: "Transaction history"),
                        SizedBox(
                          height: 16,
                        ),
                        primaryRow(
                            icon: Icons.apartment,
                            data: "My Dormitory",
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: Mydormitory(), withNavBar: false);
                            }),
                        SizedBox(
                          height: 14,
                        ),
                        primaryRow(
                            icon: Icons.messenger_outline,
                            data: "Message",
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: Message(), withNavBar: false);
                            }),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  primaryBox(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: Setting(), withNavBar: false);
                            },
                            child: primaryRow(
                                icon: Icons.settings, data: "Settings")),
                        SizedBox(
                          height: 16,
                        ),
                        primaryRow(
                            icon: Icons.article, data: "Terms and conditions"),
                        SizedBox(
                          height: 16,
                        ),
                        primaryRow(icon: Icons.help, data: "Help"),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  primaryBox(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      children: [
                        // primaryRow(icon: Icons.logout_rounded, data: "LogOut"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              size: 24,
                              color: Color(0xffD32F2F),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                  color: Color(0xffD32F2F),
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                primaryDialogBox(
                                    context: context,
                                    contentText:
                                        "Are you sure you want to logout?",
                                    successText: "Log Out",
                                    secondaryText: "Cancel");
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 22,
                                color: Color(0xffD32F2F),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
