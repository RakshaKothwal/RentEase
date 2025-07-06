























































































































































import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/signup.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                "Hi there, how can we help you?",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black.withAlpha((255 * 0.9).toInt()),
                  fontWeight: FontWeight.w900,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "To get started, let us know what brings you to RentEase",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withAlpha((255 * 0.75).toInt()),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(role: 'owner'),
                    ),
                  );
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: Padding(
                    padding: horizontalPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/tent.svg",
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            "I want to publish a listing",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Colors.black.withAlpha((255 * 0.90).toInt()),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                            ),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(role: 'user'),
                    ),
                  );
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: Padding(
                    padding: horizontalPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/map.svg",
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            "I am looking for a place to live",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Colors.black.withAlpha((255 * 0.90).toInt()),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                            ),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
