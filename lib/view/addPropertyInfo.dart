import 'package:flutter/material.dart';
import 'package:rentease/common/global_input.dart';
import 'package:rentease/common/global_widget.dart';

class Addpropertyinfo extends StatefulWidget {
  const Addpropertyinfo({super.key});

  @override
  State<Addpropertyinfo> createState() => _AddpropertyinfoState();
}

class _AddpropertyinfoState extends State<Addpropertyinfo> {
  List<String> cities = ['Surat', 'Mumbai', 'Bengaluru', 'Hyderabad', 'Pune'];

  List<String> propertyType = ["PG", "Hostel", "Flat", "House"];
  int selectedtype = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appbar(data: "Post property"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: horizontalPadding,
            child: formLabel("City"),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: horizontalPadding,
            child: DropdownButtonFormField(
              hint: Text(
                "Select City",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: "Inter",
                ),
              ),
              decoration: inputDecoration(),
              dropdownColor: Color(0xffFAFAFA),
              onChanged: (value) {},
              items: cities.map((String city) {
                return DropdownMenuItem(value: city, child: Text(city));
              }).toList(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: horizontalPadding,
            child: formLabel("Property Type"),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 36,
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: ListView.separated(
                padding: horizontalPadding,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedtype = index;
                      });
                    },
                    child: Container(
                      // width: 100,
                      decoration: selectedtype == index
                          ? BoxDecoration(
                              color: Color(0xffD32F2F),
                              borderRadius: BorderRadius.circular(6),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Color(0xffB2B2B2), width: 1),
                            ),
                      child: Padding(
                        padding: horizontalPadding,
                        child: Center(
                          child: Text(
                            propertyType[index],
                            style: selectedtype == index
                                ? TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)
                                : TextStyle(
                                    color: Color(0xffB2B2B2),
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
                    width: 8,
                  );
                },
                itemCount: propertyType.length,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: horizontalPadding,
            child: input(),
          ),
          Padding(
            padding: horizontalPadding,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          )
        ],
      ),
    );
  }
}
