import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentease/common/global_widget.dart';

class Enquire extends StatefulWidget {
  const Enquire({super.key});

  @override
  State<Enquire> createState() => _EnquireState();
}

class _EnquireState extends State<Enquire> {
  String selectedMessage = "chat";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar:
          appbar(data: "Enquire Now", showBackArrow: true, context: context),
      body:

          // Text(
          //   "By continuing, you’re letting the property owner know that you’re genuinely interested. Please provide the details below to help us connect you effectively.",
          //   style: TextStyle(
          //       color: Color(0xffD32F2F),
          //       fontSize: 10,
          //       fontFamily: "Poppins",
          //       fontWeight: FontWeight.w600),
          // ),
          ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Send a message to the owner",
                  style: TextStyle(
                      color: Colors.black.withAlpha((255 * 0.8).toInt()),
                      fontSize: 16,
                      letterSpacing: 0,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "By continuing, you’re letting the owner know you're genuinely interested in this property. Please choose your preferred contact method and add any additional details below.",
                  style: TextStyle(
                      color: Color(0xff919191),
                      fontSize: 10,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400),
                ),
                // Row(
                //   children: [
                //     Radio(
                //         value: "Yes",
                //         groupValue: selectedMessage,
                //         onChanged: (value) {
                //           setState(() {
                //             selectedMessage = value!;
                //           });
                //         }),
                //     Text("I need urgent. Can you book now?",
                //         style: TextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w400,
                //             fontFamily: "Poppins",
                //             color: Colors.black)),
                //   ],
                // ),
                enquiryOption(
                  label: "Direct chat",
                  value: 'chat',
                  groupValue: selectedMessage,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMessage = value!;
                    });
                  },
                ),
                enquiryOption(
                  label: "Schedule a visit",
                  value: 'visit',
                  groupValue: selectedMessage,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMessage = value!;
                    });
                  },
                ),
                enquiryOption(
                  label: "Request a callback",
                  value: 'callback',
                  groupValue: selectedMessage,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMessage = value!;
                    });
                  },
                ),
                TextFormField(
                  cursorColor: Color(0xffD32F2F),
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                      letterSpacing: 0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 14),
                    hintText: "Write your message here if any ...",
                    hintStyle: TextStyle(
                        color: Color(0xffB2B2B2),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 11),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Colors.black.withAlpha((255 * 0.6).toInt()))),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Colors.black.withAlpha((255 * 0.6).toInt()))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Colors.black.withAlpha((255 * 0.6).toInt()))),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "By sending your enquiry, you agree to communicate exclusively through our secure chat system with the property owner.",
                  style: TextStyle(
                      color: Color(
                        0xff919191,
                      ),
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: 26,
                ),
                submit(
                    data: "Send",
                    onPressed: () {
                      customBottomSheet(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.grey.shade400,
                                          size: 20,
                                        ))),

                                // SizedBox(
                                //   height: 16,
                                // ),
                                SvgPicture.asset(
                                  "assets/svg/tick.svg",
                                  colorFilter: ColorFilter.mode(
                                      Color(0xffD32F2F), BlendMode.srcIn),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Enquiry Sent!",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      letterSpacing: 0),
                                ),
                                // Text(
                                //   "We have received your enquiry",
                                //   style: TextStyle(
                                //       color: Color(0xff000000),
                                //       fontWeight: FontWeight.w600,
                                //       fontFamily: "Poppins",
                                //       fontSize: 16,
                                //       letterSpacing: 0),
                                // ),
                                SizedBox(
                                  height: 15,
                                ),

                                Center(
                                  child: Text(
                                    "Thank you for reaching out. We’ve sent your enquiry",
                                    // "The property owner has been notified and will get back to you shortly. ",
                                    style: TextStyle(
                                        color: Color(0xff000000)
                                            .withAlpha((255 * 0.8).toInt()),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        letterSpacing: 0),
                                    // softWrap: true,
                                    // maxLines: 3,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "to the owner. They’ll get back to you shortly.",
                                    // "The property owner has been notified and will get back to you shortly. ",
                                    style: TextStyle(
                                        color: Color(0xff000000)
                                            .withAlpha((255 * 0.8).toInt()),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        letterSpacing: 0),
                                    // softWrap: true,
                                    // maxLines: 3,
                                  ),
                                ),
                                // Center(
                                //   child: Text(
                                //     "Thank you for your enquiry.The property owner has ",
                                //     // "The property owner has been notified and will get back to you shortly. ",
                                //     style: TextStyle(
                                //         color: Color(0xff000000)
                                //             .withAlpha((255 * 0.8).toInt()),
                                //         fontWeight: FontWeight.w400,
                                //         fontFamily: "Poppins",
                                //         fontSize: 12,
                                //         letterSpacing: 0),
                                //     // softWrap: true,
                                //     // maxLines: 3,
                                //   ),
                                // ),
                                //           Center(
                                //             child: Text(
                                //               "been notified and will get back to you shortly.",
                                //               style: TextStyle(
                                //                   color: Color(0xff000000)
                                //                       .withAlpha((255 * 0.8).toInt()),
                                //                   fontWeight: FontWeight.w400,
                                //                   fontFamily: "Poppins",
                                //                   fontSize: 12,
                                //                   letterSpacing: 0),
                                //             ),
                                //           ),
                                SizedBox(
                                  height: 30,
                                ),
                                // submit(data: "Done", onPressed: () {}),
                              ],
                            ),
                          ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
