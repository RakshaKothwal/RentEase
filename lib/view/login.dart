import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentease/view/dashboard.dart';
import 'package:rentease/view/forgot_password.dart';
import 'package:rentease/view/navbar.dart';
import 'package:rentease/view/owner_navbar.dart';
import 'package:rentease/view/roleSelection.dart';
import 'package:rentease/view/signup.dart';

import '../common/global_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isObscure = true;
  String? errorType;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    setState(() {
      errorType = null;
    });

    if (!formKey.currentState!.validate()) return;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        String userRole = userDoc.get('role');

        if (userRole == 'owner') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OwnerNavbar()));
        } else if (userRole == 'user') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Navbar()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RoleSelection()));
        }
      } else {
        commonToast("User data not found");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          errorType = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorType = 'Wrong password provided.';
        } else {
          errorType = 'Login failed. Please try again.';
        }
      });
      commonToast(errorType!);
    } catch (e) {
      setState(() {
        errorType = 'An error occurred. Please try again.';
      });
      commonToast(errorType!);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();

      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        String role = userDoc.get('role');
        if (role == 'owner') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OwnerNavbar()));
        } else if (role == 'user') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Navbar()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RoleSelection()));
        }
      } else {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': userCredential.user!.email,
          'role': 'user',
          'createdAt': FieldValue.serverTimestamp(),
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RoleSelection()));
      }
    } catch (e) {
      commonToast('Google sign-in failed. Please try again.');
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Center(
                    child: SvgPicture.asset(
                      "assets/svg/house.svg",
                      height: 50,
                      width: 50,
                      colorFilter: const ColorFilter.mode(
                          Color(0xffD32F2F), BlendMode.srcIn),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "RentEase",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffD32F2F),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
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
                        return "Email Address is required";
                      }
                      final emailRegex =
                          RegExp(r'^[A-Za-z0-9._-]+@[A-Za-z]+\.[A-Za-z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  input(
                      suffixIcon: passwordIcon(isObscure, () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      }),
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
                        } else if (!RegExp(r'[@#$%^&+=!_-]').hasMatch(value)) {
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
                  const SizedBox(height: 20),
                  submit(
                    width: double.infinity,
                    height: 50,
                    data: "Login",
                    onPressed: () {
                      signIn();
                    },
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup(
                                              role: '',
                                            )));
                              },
                            text: "Sign up now",
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
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(0xffB2B2B2),

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








                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: Container(
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
                    ),
                  )
































                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
