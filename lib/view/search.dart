import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentease/common/global_widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appbar(data: "Searching to rent in "),
      body: Padding(
        padding: horizontalPadding,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Choose localities in ",
                      style: TextStyle(
                          color: Color(0XFF000000),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: "Poppins")),
                  TextSpan(
                      text: "Surat",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0XFF000000)))
                ])),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: TextSelectionTheme(
                data: TextSelectionThemeData(
                    selectionHandleColor: Color(0xffD32F2F)),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400),
                  // controller: searchController,
                  cursorColor: Color(0xffD32F2F),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Color(0xffF5F5F5),
                    // prefixIcon: Icon(
                    //   Icons.search,
                    //   color: Color(0xffA8A8A8),
                    //   // color: Color(0xff838383),
                    //   size: 24,
                    // ),
                    hintText: "Search by localities, landmark",
                    hintStyle: TextStyle(
                        // color: Color(0xff858585),
                        color: Color(0xffA8A8A8),
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                ),
              ),
            ),
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
              height: 20,
            ),
            Flexible(
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Text("Palanpur, Surat");
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Divider(
                          height: 10,
                          color: Color(0xffF5F5F5),
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 5,
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
