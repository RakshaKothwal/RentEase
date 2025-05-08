import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appbar(
        data: "",
        showBackArrow: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Help & Support",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Colors.black.withAlpha((255 * 0.8).toInt()),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "If you have any queries, feel free to contact us ",
              style: TextStyle(
                fontSize: 13,
                fontFamily: "Poppins",
                color: Color(0xff6C7278),
                letterSpacing: 0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(
                  Icons.mail_outline,
                  size: 20,
                  color: Colors.black.withAlpha((255 * 0.7).toInt()),
                ),
                SizedBox(
                  width: 14,
                ),
                Text(
                  "Email us",
                  style: TextStyle(
                      color: Colors.black.withAlpha((255 * 0.7).toInt()),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                )
              ],
            ),
            Divider(
              color: Color(0xffF5F5F5),
              thickness: 2,
            ),
            Row(
              children: [
                Icon(
                  Icons.call,
                  size: 20,
                  color: Colors.black.withAlpha((255 * 0.7).toInt()),
                ),
                SizedBox(
                  width: 14,
                ),
                Text(
                  "Call us",
                  style: TextStyle(
                      color: Colors.black.withAlpha((255 * 0.7).toInt()),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
