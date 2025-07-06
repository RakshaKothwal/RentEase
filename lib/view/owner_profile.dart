import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/common_book.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/edit_profile.dart';
import 'package:rentease/view/help.dart';
import 'package:rentease/view/login.dart';
import 'package:rentease/view/mydormitory.dart';
import 'package:rentease/view/myenquiry.dart';
import 'package:rentease/view/owner_bookings.dart';
import 'package:rentease/view/owner_scheduled_visits.dart';
import 'package:rentease/view/setting.dart';

class OwnerProfile extends StatefulWidget {
  const OwnerProfile({super.key});

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
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
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        title: const Text("Profile"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Padding(
                  padding: horizontalPadding,
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
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
                                backgroundImage:
                                    userData['profileImage'] != null
                                        ? NetworkImage(userData['profileImage'])
                                        : const AssetImage(
                                                "assets/images/profile4.png")
                                            as ImageProvider,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (userData['fullName'] != null &&
                                      userData['fullName'].isNotEmpty)
                                    Text(
                                      userData['fullName'] ??
                                          userData['name'] ??
                                          "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  if (userData['email'] != null &&
                                      userData['email'].isNotEmpty)
                                    Column(
                                      children: [
                                        const SizedBox(height: 2),
                                        Text(
                                          userData['email'] ?? "",
                                          style: const TextStyle(
                                            color: Color(0xff919191),
                                            fontSize: 12,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (userData['phone'] != null &&
                                      userData['phone'] !=
                                          'Phone not provided' &&
                                      userData['phone'].isNotEmpty)
                                    Column(
                                      children: [
                                        const SizedBox(height: 2),
                                        Text(
                                          userData['phone'] ?? "",
                                          style: const TextStyle(
                                            color: Color(0xff919191),
                                            fontSize: 12,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const Spacer(),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      primaryBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Column(
                            children: [
                              primaryRow(
                                icon: Icons.book_outlined,
                                data: "My Bookings",
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: const OwnerBookings(),
                                    withNavBar: false,
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              primaryRow(
                                icon: Icons.calendar_today_outlined,
                                data: "Scheduled Visits",
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: const OwnerScheduledVisits(),
                                    withNavBar: false,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                    screen: const Setting(),
                                    withNavBar: false,
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              primaryRow(
                                icon: Icons.article,
                                data: "Terms and conditions",
                              ),
                              const SizedBox(height: 16),
                              primaryRow(
                                icon: Icons.help,
                                data: "Help",
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: const Help(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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

                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: Login(),
                                          withNavBar: false,
                                        );
                                      },
                                      unsuccessText: "Cancel");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
