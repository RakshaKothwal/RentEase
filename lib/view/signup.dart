import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();

  String? errorType;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      //         fontFamily: "Poppins"),
      //   ),
      // ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: horizontalPadding,
            child: Form(
              key: formKey,
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
                  label("Full Name"),
                  input(
                    hintText: "Enter your full name",
                    controller: fullNameController,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[A-Za-z\s]'),
                      ),
                      FilteringTextInputFormatter.deny(RegExp(r'\s\s')),
                    ],
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        errorType ??= "Please enter your name";
                        return null;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  label("Phone Number"),
                  input(
                    hintText: "Enter your phone number",
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        errorType ??= "Phone number is required";
                        return null;
                      }

                      if (value.length != 10) {
                        errorType ??= "Phone number must be of 10 digits";
                        return null;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  label("Email"),
                  input(
                    hintText: "Enter your email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(254),
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-z0-9@._-]')),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        errorType ??= "Email Address is required";

                        return null;
                      }
                      final emailRegex =
                          RegExp(r'^[A-Za-z0-9._-]+@[A-Za-z]+\.[A-Za-z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        errorType ??= "Enter a valid email address";
                        return null;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  label(
                    "Create a password",
                  ),
                  input(
                      hintText: "Create Password",
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscure,
                      suffixIcon: passwordIcon(isObscure, () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      }),
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       isObscure = !isObscure;
                      //     });
                      //   },
                      //   icon: Icon(
                      //     isObscure ? Icons.visibility : Icons.visibility_off,
                      //     color: Color(0xffB2B2B2),
                      //     size: 20,
                      //   ),
                      // ),
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
                        } else if (!RegExp(r'[@#$%^&+=!_-]').hasMatch(value)) {
                          errorType ??=
                              "Password must contain a special character";
                          return null;
                        }

                        return null;
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  submit(
                      width: double.infinity,
                      height: 50,
                      data: "Sign Up",
                      onPressed: () async {
                        setState(() {
                          errorType = null;
                        });

                        if (fullNameController.text.isEmpty &&
                            phoneController.text.isEmpty &&
                            emailController.text.isEmpty &&
                            passwordController.text.isEmpty) {
                          setState(() {
                            errorType = "Please enter all fields";
                          });
                        }

                        formKey.currentState!.validate();
                        if (errorType != null) {
                          commonToast(errorType!);
                        } else {
                          UserModel newUser = UserModel(
                            fullName: fullNameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            password: passwordController.text,
                          );

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          await prefs.setString('user', newUser.toJson());

                          log('UserModel created: $newUser', name: 'UserModel');
                          if (!context.mounted) {
                            return;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          }
                        }
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account? ",
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
                                            builder: (context) => Login()));
                                  },
                                text: "Sign in now",
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
