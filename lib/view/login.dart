import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/dashboard.dart';
import 'package:rentease/view/navbar.dart';
import 'package:rentease/view/signup.dart';
import 'package:rentease/view/forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isObscure = true;
  String? errorType;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString('user');

    if (userJson != null) {
      return UserModel.fromJson((userJson));
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   titleSpacing: -5,
      //   // title: Text(
      //   //   "Sign in ",
      //   //   style: TextStyle(
      //   //       fontSize: 20,
      //   //       fontFamily: "Poppins",
      //   //       fontWeight: FontWeight.w500,
      //   //       color: Colors.black),
      //   // ),
      //   backgroundColor: Colors.white,
      //   // toolbarHeight: 20,
      //   // leading: IconButton(
      //   //     onPressed: () {},
      //   //     icon: Icon(
      //   //       Icons.arrow_back_ios,
      //   //       size: 20,
      //   //     )),
      // ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Let's Sign in ",
                    //   style: TextStyle(
                    //       fontSize: 24,
                    //       fontFamily: "Poppins",
                    //       fontWeight: FontWeight.w700,
                    //       color: Colors.black),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        height: 50,
                        width: 50,
                        "assets/svg/house.svg",
                        colorFilter: ColorFilter.mode(
                            Color(0xffD32F2F), BlendMode.srcIn),
                      ),
                    ),
                    Center(
                      child: Text(
                        "RentEase",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffD32F2F),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 35,
                    ),

                    input(
                      controller: emailController,
                      icon: Icons.mail,
                      hintText: "Enter Your Email",
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(254),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9@._-]'))
                      ],
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          errorType ??= "Email Address is required";

                          return null;
                        }
                        final emailRegex = RegExp(
                            r'^[A-Za-z0-9._-]+@[A-Za-z]+\.[A-Za-z]{2,}$');
                        if (!emailRegex.hasMatch(value)) {
                          errorType ??= "Enter a valid email address";
                          return null;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    input(
                        suffixIcon: passwordIcon(isObscure, () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        }),
                        // suffixIcon: IconButton(
                        //   style: IconButton.styleFrom(
                        //       splashFactory: NoSplash.splashFactory),
                        //   onPressed: () {
                        //     setState(() {
                        //       isObscure = !isObscure;
                        //     });
                        //   },
                        //   icon: Icon(
                        //     isObscure ? Icons.visibility : Icons.visibility_off,
                        //     color: Color(0xffB2B2B2),
                        //     size: 18,
                        //   ),
                        // ),
                        controller: passwordController,
                        obscureText: isObscure,
                        icon: Icons.lock,
                        hintText: "Enter Your Password",
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            errorType ??= "Password is required";
                            return null;
                          } else if (value.length < 6) {
                            errorType ??=
                                "Password must be at least 6 characters";
                            return null;
                          } else if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                            errorType ??= "Password must contain letters";
                            return null;
                          } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                            errorType ??= "Password must contain a digit";
                            return null;
                          } else if (!RegExp(r'[@#$%^&+=!_-]')
                              .hasMatch(value)) {
                            errorType ??=
                                "Password must contain a special character";
                            return null;
                          }

                          return null;
                        }),

                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                              activeColor: Color(0xffD32F2F),
                              side: BorderSide(
                                color: Color(0xffB2B2B2),
                                width: 1,
                              ),
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              }),
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(
                              color: Color(0XFF0C0D34),
                              // color: Color(0xff6C7278),
                              fontSize: 13,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            );
                          },
                          child: Text(
                            "Forgot  Password?",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xffD32F2F),
                              fontSize: 13,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    submit(
                        width: double.infinity,
                        height: 50,
                        data: "Login",
                        onPressed: () async {
                          if (!mounted) return;
                          setState(() {
                            errorType = null;
                          });

                          if (emailController.text.isEmpty &&
                              passwordController.text.isEmpty) {
                            setState(() {
                              errorType = "Please enter all fields";
                            });
                          }

                          formKey.currentState!.validate();
                          if (errorType != null) {
                            commonToast(errorType!);
                          } else {
                            UserModel? user = await getData();

                            if (user == null) {
                              commonToast(
                                  "No user found. Please sign up first.");
                            } else if (emailController.text == user.email &&
                                passwordController.text == user.password) {
                              if (!context.mounted) {
                                return;
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Navbar()));
                              }
                            } else {
                              commonToast(
                                  "Login failed. Incorrect email or password.");
                            }
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                fontFamily: 'Poppins',
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
                                              builder: (context) => Signup()));
                                    },
                                  text: "Sign up now",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xffD32F2F),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500)),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xffB2B2B2),
                            // color: Color(0xffEDF1F3),
                            thickness: 1,
                            indent: 15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              color: Color(0xffB2B2B2),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: "Poppins",
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xffB2B2B2),
                            thickness: 1,
                            endIndent: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(shape: BoxShape.circle),
                    //   child: Image.asset(
                    //     "assets/images/Google_Logo.png",
                    //     width: 25,
                    //     height: 25,
                    //   ),
                    // ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 0.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/Google_Logo.png",
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                    // SizedBox(
                    //   height: 50,
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //       style:
                    //           ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    //       onPressed: () {},
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             "assets/images/Google_Logo.png",
                    //             width: 24,
                    //             height: 24,
                    //           ),
                    //           SizedBox(
                    //             width: 17,
                    //           ),
                    //           Text(
                    //             "Sign in with Google",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w600,
                    //                 letterSpacing: 0,
                    //                 fontFamily: "Poppins",
                    //                 color: Colors.black),
                    //           )
                    //         ],
                    //       )),
                    // ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
