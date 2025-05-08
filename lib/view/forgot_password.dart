import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "", showBackArrow: true, context: context),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: horizontalPadding,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Let's Reset Your Password",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withAlpha((255 * 0.8).toInt()),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Enter your email address and we'll send you a link to reset your password.",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Poppins",
                      color: Color(0xff6C7278),
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 30),
                  input(hintText: "Enter Your Email", icon: Icons.mail),
                  SizedBox(height: 20),
                  submit(
                      width: double.infinity,
                      data: "Send Reset Link",
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
