import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          appbar(data: "Notifications", showBackArrow: true, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Flexible(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              maxRadius: 25,
                              minRadius: 25,
                              backgroundImage: AssetImage(
                                "assets/images/profile4.png",
                              )),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirm tenant data",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Sania Mirza added her data as a dormitory tenant at Lakshmi Chowk, VIP Room A",
                                  softWrap: true,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "10 min ago",
                                  style: TextStyle(
                                      color: Color(0xff919191),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 25,
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
