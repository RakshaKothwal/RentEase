import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime selectedDay = DateTime.now();
  late DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(
          data: "select check - in date",
          showBackArrow: true,
          context: context),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2025, 12, 31),
            headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextFormatter: (date, locale) {
                  return DateFormat("d MMM y").format(date);
                },
                titleTextStyle: TextStyle(
                    color: Color(0xffD32F2F),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600)),
            calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(),
                todayTextStyle: TextStyle(color: Colors.black),
                selectedDecoration: BoxDecoration(
                    color: Color(0xffD32F2F), shape: BoxShape.circle)),
            onDaySelected: (selectedDay, focused) {
              setState(() {
                this.selectedDay = selectedDay;
                focusedDay = focused;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
          ),
        ],
      ),
    );
  }
}
