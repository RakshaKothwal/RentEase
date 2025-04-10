import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentease/common/global_input.dart';
import 'package:rentease/common/global_widget.dart';

class Addproperty extends StatefulWidget {
  const Addproperty({super.key});

  @override
  State<Addproperty> createState() => _AddpropertyState();
}

class _AddpropertyState extends State<Addproperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appbar(
        data: "Add Property",
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 15,
              children: [
                Text(
                  "Register your property by filling the data below",
                  style: TextStyle(
                    color: Color(0xff919191),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Poppins",
                    letterSpacing: 0,
                  ),
                ),
                propertyBox(
                    icon: Icons.info,
                    // Icon: Icon(Icons.info),
                    count: "1",
                    title: "Dormitory data",
                    content:
                        "To set information about Dormitory descriptions and room types"),
                propertyBox(
                    icon: Icons.location_on_outlined,
                    // Icon: Icon(Icons.location_on_outlined),
                    count: "2",
                    title: "Dormitory Address",
                    content:
                        "To set the location and address details of the boarding house"),
                propertyBox(
                    icon: Icons.photo,
                    // Icon: Icon(Icons.photo),
                    count: "3",
                    title: "Dormitory Photo",
                    content:
                        "To organise photos of the Dormitory and its environment"),
                propertyBox(
                    icon: Icons.ac_unit,
                    // Icon: Icon(Icons.ac_unit),
                    count: "4",
                    title: "Dormitory Facility",
                    content:
                        "To organise Dormitory facilities and their contents"),
                propertyBox(
                    icon: Icons.roofing_rounded,
                    // Icon: Icon(Icons.roofing_rounded),
                    count: "5",
                    title: "Room Availability",
                    content:
                        "To set the number of available and occupied rooms"),
                propertyBox(
                    icon: Icons.currency_rupee,
                    // Icon: Icon(Icons.currency_rupee),
                    count: "6",
                    title: "Price",
                    content: "To set room prices and other fees"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
