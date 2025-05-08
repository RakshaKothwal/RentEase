import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentease/common/global_widget.dart';

class Changecity extends StatefulWidget {
  const Changecity({super.key});

  @override
  State<Changecity> createState() => _ChangecityState();
}

class _ChangecityState extends State<Changecity> {
  List cities = ["Surat", "Ahmedabad", "Vapi", "Navsari", "Rajkot"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(
        data: "Change City",
        showBackArrow: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You are looking to rent in",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withAlpha((255 * 0.8).toInt())),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Choose a city here which can be changed later on",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withAlpha((255 * 0.7).toInt())),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
                width: double.infinity,
                child: search(hintText: "Type city here...")),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/location-target.svg",
                  colorFilter:
                      ColorFilter.mode(Color(0xffD32F2F), BlendMode.srcIn),
                  height: 16,
                ),
                // Icon(
                //   Icons.location_searching,
                //   size: 16,
                //   weight: 6,
                //   color: Color(0xffD32F2F),
                // ),
                SizedBox(
                  width: 8,
                ),

                Text(
                  "Use my current location",
                  style: TextStyle(
                    color: Color(0xffD32F2F),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/diagonal-arrow.svg",
                          // colorFilter: ColorFilter.mode(
                          //     Color(0xff000000).withAlpha((255 * 0.5).toInt()),
                          //     BlendMode.srcIn),
                          height: 10,
                          width: 10,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          cities[index],
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 10,
                          color: Color(0xffF5F5F5),
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                  itemCount: 5),
            )
          ],
        ),
      ),
    );
  }
}
