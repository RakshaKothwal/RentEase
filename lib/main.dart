import 'package:flutter/material.dart';
import 'package:rentease/view/addProperty.dart';
import 'package:rentease/view/addPropertyInfo.dart';
import 'package:rentease/view/bills.dart';
import 'package:rentease/view/chat.dart';
import 'package:rentease/view/dashboard.dart';
import 'package:rentease/view/details.dart';
import 'package:rentease/view/edit_profile.dart';
import 'package:rentease/view/filter.dart';

import 'package:rentease/view/listing.dart';
import 'package:rentease/view/login.dart';
import 'package:rentease/view/message.dart';
import 'package:rentease/view/my_contract.dart';
import 'package:rentease/view/myDormitory.dart';
import 'package:rentease/view/myreview.dart';
import 'package:rentease/view/navbar.dart';
import 'package:rentease/view/notifications.dart';
import 'package:rentease/view/profile.dart';
import 'package:rentease/view/reviews.dart';
import 'package:rentease/view/roleSelection.dart';
import 'package:rentease/view/saved.dart';
import 'package:rentease/view/search.dart';
import 'package:rentease/view/setting.dart';
import 'package:rentease/view/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Ease',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: Setting(),
    );
  }
}
