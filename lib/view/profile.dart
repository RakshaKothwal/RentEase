import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/edit_profile.dart';
import 'package:rentease/view/help.dart';
import 'package:rentease/view/login.dart';
import 'package:rentease/view/message.dart';
import 'package:rentease/view/myDormitory.dart';
import 'package:rentease/view/myEnquiry.dart';
import 'package:rentease/view/my_bookings.dart';
import 'package:rentease/view/roleSelection.dart';
import 'package:rentease/view/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'myScheduledVisits.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = true;
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        commonToast('Please login to view profile');
        return;
      }


      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data() ?? {};
          isLoading = false;
        });
      } else {

        setState(() {
          userData = {
            'fullName': user.displayName ?? 'No Name',
            'name': user.displayName ?? 'No Name',
            'email': user.email ?? 'No Email',
            'phone': user.phoneNumber ?? 'Phone not provided',
            'profileImage': user.photoURL,
          };
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      commonToast('Failed to load profile data');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Color(0xffF5F5F5),
          title: Text("Profile"),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: loadUserData,
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                                    backgroundImage: userData['profileImage'] !=
                                            null
                                        ? NetworkImage(userData['profileImage'])
                                        : AssetImage(
                                                "assets/images/profile4.png")
                                            as ImageProvider,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (userData['fullName'] != null &&
                                            userData['fullName'].isNotEmpty)
                                          Text(
                                            userData['fullName'] ??
                                                userData['name'] ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        if (userData['email'] != null &&
                                            userData['email'].isNotEmpty)
                                          Column(
                                            children: [
                                              SizedBox(height: 2),
                                              Text(
                                                userData['email'] ?? "",
                                                style: TextStyle(
                                                    color: Color(0xff919191),
                                                    fontSize: 12,
                                                    fontFamily: "Poppins",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        if (userData['phone'] != null &&
                                            userData['phone'] !=
                                                'Phone not provided' &&
                                            userData['phone'].isNotEmpty)
                                          Column(
                                            children: [
                                              SizedBox(height: 2),
                                              Text(
                                                userData['phone'] ?? "",
                                                style: TextStyle(
                                                    color: Color(0xff919191),
                                                    fontSize: 12,
                                                    fontFamily: "Poppins",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: EditProfile(userData: userData),
                                        withNavBar: false,
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 22,
                                      color: Colors.black
                                          .withAlpha((255 * 0.8).toInt()),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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
                                    icon: Icons.apartment,
                                    data: "My Dormitory",
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: Mydormitory(),
                                          withNavBar: false);
                                    }),
                                SizedBox(
                                  height: 14,
                                ),
                                primaryRow(
                                    icon: Icons.book_outlined,
                                    data: "My Bookings",
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: MyBookings(),
                                          withNavBar: false);
                                    }),
                                SizedBox(
                                  height: 14,
                                ),










                                primaryRow(
                                    icon: Icons.messenger_outline,
                                    data: "My Scheduled Visits",
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: MyScheduledVisits(),
                                          withNavBar: false);
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
                                primaryRow(
                                    icon: Icons.settings,
                                    data: "Settings",
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: Setting(),
                                          withNavBar: false);
                                    }),
                                SizedBox(
                                  height: 16,
                                ),
                                primaryRow(
                                    icon: Icons.article,
                                    data: "Terms and conditions"),
                                SizedBox(
                                  height: 16,
                                ),
                                primaryRow(
                                    icon: Icons.help,
                                    data: "Help",
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: Help());
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
                                    primaryDialogBox(
                                        context: context,
                                        title: Text("Log Out"),
                                        contentText:
                                            "Are you sure you want to logout ?",
                                        successText: "Logout",
                                        successTap: () async {
                                          await FirebaseAuth.instance.signOut();

                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            screen: Login(),
                                            withNavBar: false,
                                          );
                                        },
                                        unsuccessText: "Cancel");
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    ],
                                  ),
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
                ),
              ));
  }
}
