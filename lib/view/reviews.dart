import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appbar(data: "Reviews", showBackArrow: true, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "4.2",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 31,
                            color: Colors.amber,
                          );
                        })),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "120 Reviews",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/images/profile2.png")),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.yellow),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Dianne Russell",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black
                                              .withAlpha((255 * 0.8).toInt())),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                Text(
                                  "05 May 2021",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      );
                                    })),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: 6),
              ),
            )
          ],
        ),
      ),
    );
  }
}
