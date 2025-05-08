import 'package:flutter/material.dart';
import 'package:rentease/common/common_form.dart';
import 'package:rentease/common/common_profile.dart';

import '../common/global_widget.dart';

class OwnerBookingDetails extends StatelessWidget {
  const OwnerBookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(
            data: "Booking Request", showBackArrow: true, context: context),
        body: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: sectionDecoration(),
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
                  SizedBox(height: 24),
                  header("Tenant Details"),
                  SizedBox(
                    height: 16,
                  ),
                  primaryInfo(label: "Name", value: "Raksha Kothwal"),
                  SizedBox(
                    height: 2,
                  ),
                  primaryInfo(
                      label: "Phone", value: "+91 9876543210@example.com"),
                  SizedBox(
                    height: 2,
                  ),
                  primaryInfo(label: "Email", value: "example123@example.com"),
                  SizedBox(
                    height: 2,
                  ),
                  primaryInfo(label: "Occupation", value: "Software Engineer"),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(height: 24),
                  header("Visit Details"),
                  SizedBox(
                    height: 16,
                  ),
                  primaryInfo(label: "Date", value: "15 March 2024"),
                  SizedBox(
                    height: 2,
                  ),
                  primaryInfo(label: "Time", value: "10:00 AM"),
                  SizedBox(
                    height: 2,
                  ),
                  primaryInfo(label: "Status", value: "Pending"),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: buildNavbar(
            child: Row(
          children: [
            Expanded(child: outlinedSubmit(data: "Reject", onPressed: () {})),
            SizedBox(width: 16),
            Expanded(child: submit(data: "Accept", onPressed: () {})),
          ],
        )));
  }
}
