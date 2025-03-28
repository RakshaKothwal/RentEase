import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/dashboard.dart';
import 'package:rentease/view/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  bool isObscure = true;
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
      //   //       fontFamily: "Inter",
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
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Let's Sign in ",
                //   style: TextStyle(
                //       fontSize: 24,
                //       fontFamily: "Inter",
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
                    colorFilter:
                        ColorFilter.mode(Color(0xffD32F2F), BlendMode.srcIn),
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

                input(icon: Icons.mail, hintText: "Enter Your Email"),
                SizedBox(height: 16),

                input(
                  suffixIcon: IconButton(
                      style: IconButton.styleFrom(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: isObscure
                          ? Icon(
                              Icons.visibility_off,
                              color: Color(0xffB2B2B2),
                              size: 18,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Color(0xffB2B2B2),
                              size: 18,
                            )),
                  obscureText: isObscure,
                  icon: Icons.lock,
                  hintText: "Enter Your Password",
                ),
                // suffixIcon: Icons.visibility_off),
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
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    ),
                    Spacer(),
                    Text(
                      "Forgot  Password?",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xffD32F2F),
                        fontSize: 13,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                submit(
                    data: "Login",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    }),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                        text: "Don’t have an account? ",
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
                                          builder: (context) => Signup()));
                                },
                              text: "Sign up now",
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
                          fontFamily: "Roboto",
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
                    border: Border.all(color: Colors.grey.shade300, width: 0.6),
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
                            fontFamily: 'Inter',
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
                //                 fontFamily: "Inter",
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
