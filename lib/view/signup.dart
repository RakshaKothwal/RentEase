import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/login.dart';

import 'dashboard.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   titleSpacing: -5,
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(
      //         Icons.arrow_back_ios,
      //         size: 20,
      //       )),
      //   title: Text(
      //     "Sign Up Account",
      //     style: TextStyle(
      //         color: Colors.black.withAlpha(210),
      //         fontSize: 18,
      //         fontWeight: FontWeight.w600,
      //         fontFamily: "Inter"),
      //   ),
      // ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: horizontalPadding,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    "Create your account",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  // SizedBox(
                  //   height: 100,
                  // ),
                  // Center(
                  //   child: SvgPicture.asset(
                  //     height: 50,
                  //     width: 50,
                  //     "assets/svg/house.svg",
                  //     colorFilter:
                  //         ColorFilter.mode(Color(0xffD32F2F), BlendMode.srcIn),
                  //   ),
                  // ),
                  // Center(
                  //   child: Text(
                  //     "RentEase",
                  //     style: TextStyle(
                  //       fontSize: 32,
                  //       fontWeight: FontWeight.bold,
                  //       color: Color(0xffD32F2F),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 35,
                  // ),
                  label("Full Name"),
                  input(hintText: "Enter your full name"),
                  SizedBox(
                    height: 10,
                  ),
                  label("Phone Number"),
                  input(hintText: "Enter your phone number"),
                  SizedBox(
                    height: 10,
                  ),
                  label("Email"),
                  input(hintText: "Enter your email"),
                  SizedBox(
                    height: 10,
                  ),
                  label("Create a password"),
                  input(hintText: "Create Password"),
                  SizedBox(
                    height: 25,
                  ),
                  submit(
                      data: "Sign Up",
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xff000000),
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w300),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                text: "Sign in now",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xffD32F2F),
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500)),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
