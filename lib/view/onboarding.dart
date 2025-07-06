import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/roleSelection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  Future<void> onboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setBool('onboarding_done', true);
    print('onboarding status saved: $success');

    bool checkFlag = prefs.getBool('onboarding_done') ?? false;
    print('Onboarding completed: $checkFlag');
  }

  void onDone() async {
    await onboardingCompleted();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RoleSelection()));
  }

  List<PageViewModel> buildPages(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return [
      PageViewModel(
        title: "",
        bodyWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/location_search_bro2.png",
              height: screenHeight * 0.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24),
            Padding(
              padding: horizontalPadding,
              child: Text(
                "Find rentals that match your vibe and budget.",

                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/Events.png",
              height: screenHeight * 0.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24),
            Padding(
              padding: horizontalPadding,
              child: Text(
                "Book property visits when it works for you—zero back-and-forth.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/ob3.png",
              height: screenHeight * 0.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24),
            Padding(
              padding: horizontalPadding,
              child: Text(
                "Smooth, stress-free, and smart—just the way finding a home should be.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: buildPages(context),
        onDone: onDone,
        showSkipButton: true,
        skip: Text(
          "SKIP",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xffD32F2F),
          ),
        ),
        next: Text(
          "NEXT",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xffD32F2F),
          ),
        ),
        done: Text(
          "DONE",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xffD32F2F),
          ),
        ),
        globalBackgroundColor: const Color(0xffFFFFFF),
        dotsDecorator: DotsDecorator(
          activeSize: const Size(10, 10),
          size: const Size(10, 10),
          spacing: const EdgeInsets.symmetric(horizontal: 5),
          activeColor: const Color(0xffD32F2F),
          color: Colors.grey.shade300,
        ),
        dotsContainerDecorator: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        controlsPadding: const EdgeInsets.only(top: 10, bottom: 5),
      ),
    );
  }
}
