import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/global_widget.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> propertyType = ["PG", "Hostel", "Flat", "House"];
  int selectedIndex = -1;

  List<String> genderPreference = ["Boys", "Girls", "Both"];
  int selectedGender = -1;

  List<String> occupancy = [
    "Private Room",
    "Double Sharing",
    "Triple Sharing",
    "3+ Sharing"
  ];
  Set<int> occupancyIndex = {};

  RangeValues selectedRange = RangeValues(2000, 10000);

  @override
  Widget build(BuildContext context) {
    return
















        SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 16, bottom: 14),
            child: Text(
              "Filter",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.black),
            ),
          ),

          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: title("Property Type"),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 34,
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: ListView.separated(
                padding: horizontalPadding,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(

                      decoration: selectedIndex == index
                          ? BoxDecoration(
                              color: Color(0xffD32F2F),
                              borderRadius: BorderRadius.circular(6),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Color(0xffECECEC), width: 1.2),
                            ),
                      child: Padding(
                        padding: horizontalPadding,
                        child: Center(
                          child: Text(
                            propertyType[index],
                            style: selectedIndex == index
                                ? TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)
                                : TextStyle(
                                    color: Color(0xff606060),
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 6,
                  );
                },
                itemCount: propertyType.length,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: title("Gender Preference"),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 34,
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: ListView.separated(
                padding: horizontalPadding,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = index;
                      });
                    },
                    child: Container(

                      decoration: selectedGender == index
                          ? BoxDecoration(
                              color: Color(0xffD32F2F),
                              borderRadius: BorderRadius.circular(6),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Color(0xffECECEC), width: 1.2),
                            ),
                      child: Padding(
                        padding: horizontalPadding,
                        child: Center(
                            child: Text(
                          genderPreference[index],
                          style: selectedGender == index
                              ? TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)
                              : TextStyle(
                                  color: Color(0xff606060),
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                        )),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 6,
                  );
                },
                itemCount: genderPreference.length,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: title("Occupancy  Type"),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 34,
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: ListView.separated(
                padding: horizontalPadding,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = occupancyIndex.contains(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected
                            ? occupancyIndex.remove(index)
                            : occupancyIndex.add(index);
                      });
                    },
                    child: Container(
                      decoration: isSelected
                          ? BoxDecoration(
                              color: Color(0xffD32F2F),
                              borderRadius: BorderRadius.circular(6),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Color(0xffECECEC), width: 1.2),
                            ),
                      child: Padding(
                        padding: horizontalPadding,
                        child: Center(
                          child: Text(
                            occupancy[index],
                            style: isSelected
                                ? TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)
                                : TextStyle(
                                    color: Color(0xff606060),
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 6,
                  );
                },
                itemCount: occupancy.length,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: title("Budget"),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: horizontalPadding,
            child: Row(
              children: [
                Text(
                  "Min : ",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  weight: 900,
                  Icons.currency_rupee,
                  size: 12,
                  color: Color(0xffD32F2F),
                ),
                SizedBox(
                  width: 0.5,
                ),
                Text(
                  NumberFormat("#,##,##0").format(selectedRange.start.round()),
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffD32F2F).withAlpha(230),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  "Max : ",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  weight: 900,
                  Icons.currency_rupee,
                  size: 12,
                  color: Color(0xffD32F2F),
                ),
                SizedBox(
                  width: 0.5,
                ),
                Text(
                  NumberFormat("#,##,##0").format(selectedRange.end.round()),
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffD32F2F).withAlpha(230),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          RangeSlider(
              min: 1000,
              max: 100000,
              activeColor: Color(0xffD32F2F),
              inactiveColor: Color(0xffECECEC),
              labels: RangeLabels(selectedRange.start.round().toString(),
                  selectedRange.end.round().toString()),
              values: selectedRange,
              onChanged: (RangeValues value) {
                setState(() {
                  selectedRange = value;
                });
              }),
          Spacer(),




          Padding(
            padding: horizontalPadding,
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {},
                  child: Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );

  }
}
