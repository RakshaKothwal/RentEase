import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentease/common/global_widget.dart';

class Myreview extends StatefulWidget {
  const Myreview({super.key});

  @override
  State<Myreview> createState() => _MyreviewState();
}

class _MyreviewState extends State<Myreview> {
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appbar(data: "My Review", showBackArrow: true, context: context),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Give a review of the Dormitory you rented to help make it better",
                      style: TextStyle(
                          color:
                              Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(21),
                          child: Image.asset(
                            fit: BoxFit.fill,
                            "assets/images/room1.png",
                            height: 130,
                            width: 130,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "22 Sep 2024 - Present",
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color(0xff828282),
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Star Residence Apartment",
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black
                                        .withAlpha((255 * 0.9).toInt()),
                                    fontSize: 13,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Colors.black
                                      .withAlpha((255 * 0.7).toInt()),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Adajan, Surat",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                          .withAlpha((255 * 0.7).toInt())),
                                ),
                              ]),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Color(0xffF5F5F5),
                thickness: 8,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff000000)
                                      .withAlpha((255 * 0.1).toInt()),
                                  blurRadius: 6,
                                  spreadRadius: 0,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffFFFFFF)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Overall Rating",
                              style: TextStyle(
                                  color: Color(0xff000000)
                                      .withAlpha((255 * 0.9).toInt()),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins"),
                            ),
                            Row(
                                children: List.generate(5, (index) {
                              return IconButton(
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      rating = index + 1;
                                    });
                                  },
                                  icon: index < rating
                                      ? Icon(
                                          Icons.star,
                                          size: 31,
                                          color: Colors.amber,
                                        )
                                      : Icon(
                                          Icons.star,
                                          size: 31,
                                          color: Color(0xffB2B2B2),
                                        ));
                            })),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Add detailed review",
                      style: TextStyle(
                          color:
                              Color(0xff000000).withAlpha((255 * 0.9).toInt()),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    input(
                      hintText: "Enter your detailed review here",
                      maxLines: 4,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    submit(
                        height: 50,
                        width: double.infinity,
                        data: "Submit",
                        onPressed: () {
                          customBottomSheet(
                              context: context,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    SvgPicture.asset(
                                      "assets/svg/tick.svg",
                                      colorFilter: ColorFilter.mode(
                                          Color(0xffD32F2F), BlendMode.srcIn),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Thank You!",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                          fontSize: 22,
                                          letterSpacing: 0),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Your review will help other Dormitory ",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins",
                                          fontSize: 13,
                                          letterSpacing: 0),
                                    ),
                                    Text(
                                      "Seekers.",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          letterSpacing: 0),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    submit(data: "Done", onPressed: () {}),
                                  ],
                                ),
                              ));
                        }),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
