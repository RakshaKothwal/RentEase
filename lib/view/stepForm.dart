import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../common/common_book.dart';

class Stepform extends StatefulWidget {
  final String? propertyId;
  final String? propertyTitle;
  final String? propertyOwnerId;
  final String? propertyImage;
  final String? propertyCity;
  final String? propertyRent;

  const Stepform({
    super.key,
    this.propertyId,
    this.propertyTitle,
    this.propertyOwnerId,
    this.propertyImage,
    this.propertyCity,
    this.propertyRent,
  });

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
  String? errorType;

  List<String> durations = ['3 months', '6 months', '12 months'];

  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    _submitBooking();
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    commonToast("Payment Failure");
  }

  void handleExternalWallet(ExternalWalletResponse response) {}

  Future<void> _submitBooking() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        commonToast('Please login to book a property');
        return;
      }

      if (nameController.text.isEmpty ||
          phoneController.text.isEmpty ||
          emailController.text.isEmpty ||
          moveInDate == null ||
          duration == null) {
        commonToast('Please fill all required fields');
        return;
      }

      final bookingData = {
        'userId': userId,
        'propertyId': widget.propertyId,
        'propertyOwnerId': widget.propertyOwnerId,
        'propertyName': widget.propertyTitle,
        'userName': nameController.text.trim(),
        'userPhone': phoneController.text.trim(),
        'userEmail': emailController.text.trim(),
        'moveInDate': moveInDate,
        'duration': duration,
        'amount': widget.propertyRent,
        'status': 'pending',
        'createdAt': DateTime.now(),
        'paymentStatus': 'completed',
        'paymentId': DateTime.now().millisecondsSinceEpoch.toString(),
      };

      await FirebaseFirestore.instance.collection('bookings').add(bookingData);

      commonToast('Booking submitted successfully!');

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error submitting booking: $e');
      commonToast('Failed to submit booking. Please try again.');
    }
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_47sbg0wz2GvHsm',

      'amount': 100,
      'name': 'RentEase',
      'description': 'Property for booking',

    };
    razorpay.open(options);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();

    super.dispose();
    razorpay.clear();
  }

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
                                widget.propertyTitle ?? "Property",
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
                                    widget.propertyCity ?? "Location",
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
                              if (widget.propertyRent != null) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffD32F2F),
                                  ),
                                  child: Text(
                                    "₹${widget.propertyRent}/month",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
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
                    input(
                      controller: nameController,
                      hintText: "Full Name",
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(200),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-z\s]'),
                        ),
                        FilteringTextInputFormatter.deny(RegExp(r'\s\s'))
                      ],
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          errorType ??= "Please enter your full name";
                          return null;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    input(
                      hintText: "Phone Number",
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          errorType ??= "Phone number is required";
                          return null;
                        }

                        if (value.length != 10) {
                          errorType ??= "Phone number must be of 10 digits";
                          return null;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    input(
                      hintText: "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(254),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9@._-]'))
                      ],
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          errorType ??= "Email Address is required";

                          return null;
                        }
                        final emailRegex = RegExp(
                            r'^[A-Za-z0-9._-]+@[A-Za-z]+\.[A-Za-z]{2,}$');
                        if (!emailRegex.hasMatch(value)) {
                          errorType ??= "Enter a valid email address";

                          return null;
                        }
                        return null;
                      },
                    ),
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
                    submit(
                        data: "Pay",
                        onPressed: () {
                          openCheckout();
                        })

























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
                            ? DateFormat('dd MM yyyy').format(moveInDate!)
                            : "Not Selected"),
                    summaryItem("Duration", duration ?? "Not selected"),
                    summaryItem("Name", nameController.text),
                    summaryItem("Phone", phoneController.text),
                    summaryItem("Email", emailController.text),

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

                            fontSize: 13, fontFamily: "Poppins",
                            fontWeight: FontWeight.w500, letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

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
