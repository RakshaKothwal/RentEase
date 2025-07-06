import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rentease/view/onboarding.dart';

import 'package:rentease/view/roleSelection.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingDone = prefs.getBool('onboarding_done') ?? false;

  if (kDebugMode) {
    print('Onboarding status at startup: $onboardingDone');
  }

  runApp(MyApp(
    onboardingDone: onboardingDone,
  ));
}

class MyApp extends StatelessWidget {
  final bool onboardingDone;

  const MyApp({super.key, required this.onboardingDone});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffD32F2F),
      ),
      title: 'Rent Ease',
      debugShowCheckedModeBanner: false,
      home: onboardingDone ? RoleSelection() : Onboarding(),
    );
  }
}
