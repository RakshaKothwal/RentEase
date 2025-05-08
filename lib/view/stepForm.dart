import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rentease/common/global_widget.dart';

import '../common/common_book.dart';

class Stepform extends StatefulWidget {
  const Stepform({super.key});

  @override
  State<Stepform> createState() => _StepformState();
}

class _StepformState extends State<Stepform> {
  bool isChecked = false;
  DateTime? selectedDate;
  int currentStep = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController occupantsController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();

  DateTime? moveInDate;
  String? duration;
  bool termsAccepted = false;

  List<String> durations = ['3 months', '6 months', '12 months'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar:
          appbar(data: "Book Property", showBackArrow: true, context: context),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            primaryColor: Color(0xffD32F2F),
            colorScheme: ColorScheme.light(
              primary: Color(0xffD32F2F),
              onPrimary: Colors.white,
              surface: Colors.grey,
            ),
          ),
          child: Stepper(
            elevation: 2,
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepContinue: () {
              if (currentStep < 2) {
                setState(() {
                  currentStep++;
                });
              }
            },
            onStepCancel: currentStep == 0
                ? null
                : () {
                    if (currentStep > 0) {
                      setState(() {
                        currentStep--;
                      });
                    }
                  },
            steps: [
              Step(
                title: Text("Details"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(21),
                          child: Image.asset(
                            "assets/images/room1.png",
                            height: 130,
                            width: 130,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Star Residence Apartment",
                                style: TextStyle(
                                  color: Colors.black
                                      .withAlpha((255 * 0.9).toInt()),
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: Colors.grey.shade500,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Adajan, Surat",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffD32F2F),
                                ),
                                child: Text(
                                  "Girls",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Booking Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 15),
                    input(hintText: "Full Name"),
                    SizedBox(height: 15),
                    input(hintText: "Phone Number"),
                    SizedBox(height: 15),
                    input(hintText: "Email"),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                      primary: Color(0xffD32F2F))),
                              child: child!,
                            );
                          },
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (picked != null) {
                          setState(() {
                            moveInDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              moveInDate == null
                                  ? "Select Move-in Date"
                                  : DateFormat('dd MMM yyyy')
                                      .format(moveInDate!),
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                color: moveInDate == null
                                    ? Color(0xffB2B2B2)
                                    : Colors.black,
                              ),
                            ),
                            Icon(Icons.calendar_today,
                                color: Color(0xffB2B2B2), size: 20),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            "Selected Rental Duration",
                            style: TextStyle(
                              color: Color(0xffB2B2B2),
                              fontFamily: "Poppins",
                              fontSize: 12,
                            ),
                          ),
                          value: duration,
                          items: durations.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              duration = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                isActive: currentStep >= 0,
              ),
              Step(
                title: Text("Payment"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 15),
                    input(hintText: "Card Number"),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: input(hintText: "MM/YY"),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: input(
                            hintText: "Cvv",
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                isActive: currentStep >= 1,
              ),
              Step(
                title: Text("Confirm"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking Summary",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    summaryItem(
                        "Move-in Date",
                        moveInDate != null
                            ? DateFormat('dd MMM yyyy').format(moveInDate!)
                            : "Not selected"),
                    summaryItem("Duration", duration ?? "Not selected"),
                    summaryItem("Name", nameController.text),
                    summaryItem("Phone", phoneController.text),
                    summaryItem("Email", emailController.text),
                    summaryItem("Occupants", occupantsController.text),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                              activeColor: Color(0xffD32F2F),
                              side: BorderSide(
                                  color: Color(0xffB2B2B2), width: 1),
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              }),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "I agree to the terms and conditions",
                          style: TextStyle(
                            color: Colors.black,
                            // color: Color(0xff6C7278),
                            fontSize: 13, fontFamily: "Poppins",
                            fontWeight: FontWeight.w500, letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // submit(data: "Confirm booking", onPressed: () {})
                  ],
                ),
                isActive: currentStep >= 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
