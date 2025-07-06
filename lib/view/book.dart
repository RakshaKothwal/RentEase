import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:flutter_svg/svg.dart';

import '../common/common_form.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  List<Map<String, String>> amenities = [
    {"AC": "assets/svg/ac.svg"},
    {"TV": "assets/svg/tv.svg"},
    {"Wi-fi": "assets/svg/wifi.svg"},
    {"Cleaning": "assets/svg/roomCleaning.svg"},
    {"Fridge": "assets/svg/fridge.svg"},
    {"Water Cooler": "assets/svg/water-dispenser.svg"},
  ];

  List houseRules = [
    {"Smoking": "assets/svg/smoking.svg"},
    {"Alcohol": "assets/svg/alcohol.svg"},
    {"Loud Music": "assets/svg/loudMusic.svg"},
    {"Party": "assets/svg/party.svg"},
    {"Non Veg": "assets/svg/fish.svg"},
    {"Visitor Entry": "assets/svg/visitor.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "Book Property", showBackArrow: true, context: context),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage("assets/images/room1.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3 BHK Apartment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Color(0xff000000)
                                    .withAlpha((255 * 0.75).toInt()),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Adajan, Surat',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '₹35,000/month',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000)
                                    .withAlpha((255 * 0.75).toInt()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: "Spot on choice and perfect timing.",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text:
                            " Your home is just few miles away. Enquiry is absolutely free",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                input(hintText: "Enter your full name", icon: Icons.person),
                SizedBox(
                  height: 12,
                ),
                input(hintText: "Enter your phone number", icon: Icons.call),
                SizedBox(
                  height: 12,
                ),
                input(hintText: "Enter your email", icon: Icons.mail_outline),
                SizedBox(
                  height: 12,
                ),
                input(
                    hintText: "Add any additional rules or requirements",
                    maxLines: 3),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildNavbar(
        child: submit(
            data: "Enquire Now",
            onPressed: () {},
            width: double.infinity,
            height: 50),
      ),
    );
  }
}
