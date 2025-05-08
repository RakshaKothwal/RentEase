import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class EmailOtp extends StatefulWidget {
  const EmailOtp({super.key});

  @override
  State<EmailOtp> createState() => _EmailOtpState();
}

class _EmailOtpState extends State<EmailOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(data: "", showBackArrow: true, context: context),
      backgroundColor: Color(0xffFFFFFF),
      body: Padding(
        padding: horizontalPadding,
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                  text: "Please enter the code we sent to ",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Color(0xff8E9398),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                      text: "raksha@gmail.com",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE1E6EB)),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    "5",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontFamily: "Poppins",
                        color: Colors.black),
                  )),
                ),
              ),
            ),
            SizedBox(height: 30),
            submit(data: "Verify", onPressed: () {}, width: double.infinity)
          ],
        ),
      ),
    );
  }
}
