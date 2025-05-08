import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/chat.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List<String> profiles = [
    "assets/images/girl1.png",
    "assets/images/girl2.png",
    "assets/images/boy1.png",
    "assets/images/girl2.png",
    "assets/images/girl1.png",
    "assets/images/boy1.png",
  ];

  List<String> name = [
    "Star Residence Apartment",
    "Star Paying Guest",
    "DHA Apartment",
    "Radhe Residence",
    "Vasupujya Apartment",
    "HB Hostel"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "Message"),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: Chat(), withNavBar: false);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  backgroundImage: AssetImage(
                                    profiles[index],
                                  )),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name[index],
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "Can we have a room",
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(0xff919191),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffD32F2F),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "10 min ago",
                                  style: TextStyle(
                                      color: Color(0xff919191),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          height: 10,
                          color: Color(0xffF5F5F5),
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    );
                  },
                  itemCount: 6),
            ),
          )
        ],
      ),
    );
  }
}
