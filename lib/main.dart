import 'package:flutter/material.dart';

import 'package:rentease/view/addLocation.dart';

import 'package:rentease/view/book.dart';
import 'package:rentease/view/booking_requests.dart';
import 'package:rentease/view/calendar.dart';

import 'package:rentease/view/edit_profile.dart';
import 'package:rentease/view/email_otp.dart';
import 'package:rentease/view/enquire.dart';
import 'package:rentease/view/forgot_password.dart';
import 'package:rentease/view/help.dart';
import 'package:rentease/view/list_property.dart';
import 'package:rentease/view/listing.dart';
import 'package:rentease/view/myEnquiry.dart';
import 'package:rentease/view/myreview.dart';
import 'package:rentease/view/owner_booking_details.dart';
import 'package:rentease/view/owner_change_password.dart';
import 'package:rentease/view/owner_enquiries_list.dart';
import 'package:rentease/view/owner_listings.dart';
import 'package:rentease/view/owner_property_details.dart';

import 'package:rentease/view/profile.dart';
import 'package:rentease/view/roleSelection.dart';
import 'package:rentease/view/saved.dart';
import 'package:rentease/view/search.dart';

import 'package:rentease/view/signup.dart';
import 'package:rentease/view/stepForm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffD32F2F),
        // radioTheme: RadioThemeData(
        //   fillColor: WidgetStateProperty.all(Color(0xffD32F2F)),
        // ),
      ),
      title: 'Rent Ease',
      debugShowCheckedModeBanner: false,
      home: RoleSelection(),
    );
  }
}
