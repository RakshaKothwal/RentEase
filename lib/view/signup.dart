import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/login.dart';

class Signup extends StatefulWidget {
  final String role;
  const Signup({super.key, required this.role});

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

  bool isObscure = true;

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUp() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await firestore.collection('users').doc(uid).set({
        'fullName': fullNameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'role': widget.role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      commonToast('Signup successful!');

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      log('Error: $e', name: 'FirebaseAuth');
      String errorMessage = 'Signup failed';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Email is already in use.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address.';
      }
      commonToast(errorMessage);
    } catch (e) {
      log('Error: $e', name: 'FirebaseAuth');
      commonToast('An error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  const SizedBox(height: 90),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const Text(
                    "Create your account",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  label("Full Name"),
                  input(
                    hintText: "Enter your full name",
                    controller: fullNameController,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\s]')),
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  label("Create a password"),
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
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        errorType ??= "Password is required";
                        return null;
                      } else if (value.length < 6) {
                        errorType ??= "Password must be at least 6 characters";
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
                    },
                  ),
                  const SizedBox(height: 25),
                  submit(
                    width: double.infinity,
                    height: 50,
                    data: "Sign Up",
                    onPressed: () async {
                      setState(() {
                        errorType = null;
                      });

                      if (fullNameController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        setState(() {
                          errorType = "Please enter all fields";
                        });
                      }

                      formKey.currentState!.validate();
                      if (errorType != null) {
                        commonToast(errorType!);
                      } else {
                        await signUp();
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xff000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                            text: "Sign in now",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xffD32F2F),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
      ),
    );
  }
}
