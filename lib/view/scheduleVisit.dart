import 'package:flutter/material.dart';
import 'package:rentease/common/common_form.dart';

import 'package:rentease/common/global_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Schedulevisit extends StatefulWidget {
  const Schedulevisit({super.key});

  @override
  State<Schedulevisit> createState() => _SchedulevisitState();
}

class _SchedulevisitState extends State<Schedulevisit> {
  late DateTime selectedDay = DateTime.now();
  late DateTime focusedDay = DateTime.now();

  String selectedTimeOfDay = "Morning";
  int selectedIndex = -1;

  List<String> timeCategories = ["Morning", "Afternoon", "Evening"];

  Map<String, List<String>> timeSlotsByCategory = {
    "Morning": [
      "9:00 AM - 10:00 AM",
      "10:00 AM - 11:00 AM",
      "11:00 AM - 12:00 PM",
    ],
    "Afternoon": [
      "12:00 PM - 1:00 PM",
      "1:00 PM - 2:00 PM",
      "2:00 PM - 3:00 PM",
      "3:00 PM - 4:00 PM",
    ],
    "Evening": [
      "4:00 PM - 5:00 PM",
      "5:00 PM - 6:00 PM",
      "6:00 PM - 7:00 PM",
      "7:00 PM - 8:00 PM",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appbar(
        data: "Schedule Visit",
        showBackArrow: true,
        context: context,
      ),
      body: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
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
                                    'Koramangala, Bangalore',
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(height: 1, thickness: 3, color: Color(0xffF5F5F5)),
                    Theme(
                      data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor:
                            Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                        initiallyExpanded: true,
                        title: Text(
                          "Select Date",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Color(0xffECECEC)),
                              ),
                              child: TableCalendar(
                                focusedDay: focusedDay,
                                firstDay: DateTime.now(),
                                lastDay: DateTime.utc(2025, 12, 31),
                                headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  titleTextFormatter: (date, locale) {
                                    return DateFormat("MMMM yyyy").format(date);
                                  },
                                  titleTextStyle: TextStyle(
                                    color: Color(0xffD32F2F),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                      // color: Color(0xffD32F2F)
                                      //     .withAlpha((255 * 0.1).toInt()),
                                      // shape: BoxShape.circle,
                                      ),
                                  todayTextStyle: TextStyle(
                                      // color: Color(0xffD32F2F),
                                      // fontWeight: FontWeight.bold,
                                      ),
                                  selectedDecoration: BoxDecoration(
                                    color: Color(0xffD32F2F),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                onDaySelected: (selected, focused) {
                                  setState(() {
                                    selectedDay = selected;
                                    focusedDay = focused;
                                  });
                                },
                                selectedDayPredicate: (day) {
                                  return isSameDay(selectedDay, day);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 3, color: Color(0xffF5F5F5)),
                    Theme(
                      data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor:
                            Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                        initiallyExpanded: true,
                        title: Text(
                          "Select Time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  padding: horizontalPadding,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: timeCategories.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    bool isSelected = timeCategories[index] ==
                                        selectedTimeOfDay;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedTimeOfDay =
                                              timeCategories[index];
                                          selectedIndex = -1;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Color(0xffD32F2F)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: isSelected
                                                ? Color(0xffD32F2F)
                                                : Color(0xffECECEC),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            timeCategories[index],
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Color(0xff606060),
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 24),
                              Padding(
                                padding: horizontalPadding,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount:
                                      timeSlotsByCategory[selectedTimeOfDay]!
                                          .length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 2.8,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: selectedIndex == index
                                              ? Color(0xffD32F2F).withAlpha(
                                                  (255 * 0.1).toInt())
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: selectedIndex == index
                                                ? Color(0xffD32F2F)
                                                : Color(0xffECECEC),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            timeSlotsByCategory[
                                                selectedTimeOfDay]![index],
                                            style: TextStyle(
                                              color: selectedIndex == index
                                                  ? Color(0xffD32F2F)
                                                  : Color(0xff606060),
                                              fontFamily: "Poppins",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (selectedIndex != -1)
                      Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              Color(0xffD32F2F).withAlpha((255 * 0.05).toInt()),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color(0xffD32F2F)
                                  .withAlpha((255 * 0.05).toInt())),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selected Schedule",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Color(0xffD32F2F),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${DateFormat('dd MMM yyyy').format(selectedDay)} at ${timeSlotsByCategory[selectedTimeOfDay]![selectedIndex]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildNavbar(
          child: submit(
              height: 50,
              data: "Schedule Visit",
              onPressed: () {
                if (selectedIndex != -1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text(
                          "Confirm Visit",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your visit is scheduled for:",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Color(0xffECECEC)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(selectedDay),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    timeSlotsByCategory[selectedTimeOfDay]![
                                        selectedIndex],
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffD32F2F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              })),
    );
  }
}
