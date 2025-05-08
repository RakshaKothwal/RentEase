import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/signup.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isChecked = false;
  bool isChecked2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(data: "Settings", showBackArrow: true, context: context),
        backgroundColor: Color(0xffF5F5F5),
        body: Padding(
          padding: horizontalPadding,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              primaryBox(
                  child: Theme(
                data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent),
                child: ExpansionTile(
                  minTileHeight: 60,
                  collapsedIconColor:
                      Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                  iconColor: Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                  leading: Icon(
                    color: Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                    Icons.notifications_none,
                    size: 24,
                  ),
                  tilePadding: EdgeInsets.symmetric(horizontal: 22),
                  title: Text(
                    "Notification",
                    style: TextStyle(
                      color: Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                      fontSize: 14,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  childrenPadding:
                      EdgeInsets.only(bottom: 15, left: 22, right: 22),
                  children: [
                    // SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Recommendations via email",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 12,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            activeColor:
                                Colors.green.withAlpha((255 * 0.8).toInt()),
                            side:
                                BorderSide(color: Color(0xffB2B2B2), width: 1),
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Notifications of chat",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 12,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            activeColor: Colors.green,
                            side:
                                BorderSide(color: Color(0xffB2B2B2), width: 1),
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            value: isChecked2,
                            onChanged: (value) {
                              setState(() {
                                isChecked2 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 20,
              ),
              primaryBox(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_forever_outlined,
                      color: Color(0xffD32F2F),

                      // color: Color(0xffFF0000),
                      size: 24,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        primaryDialogBox(
                            context: context,
                            title: Text("Delete Account"),
                            contentText: "Do you want to delete the account ?",
                            successText: "Delete",
                            successTap: () {
                              Navigator.pop(context);
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: Signup(), withNavBar: false);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Login()));
                            },
                            unsuccessText: "Cancel");
                      },
                      child: Text(
                        "Delete Account",
                        style: TextStyle(
                            // color: Color(0xffFF0000),
                            color: Color(0xffD32F2F),
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ));
  }
}
//
//       ],
//         ),
//       ),
//     );
//   }
// }
