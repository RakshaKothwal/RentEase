import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(data: "Settings"),
        backgroundColor: Color(0xffF5F5F5),
        body: Padding(
          padding: horizontalPadding,
          child: Column(
            children: [
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
                      Icons.notifications_none,
                      color: Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                      // color: Color(0xffFF0000),
                      size: 24,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Notification",
                      style: TextStyle(
                          // color: Color(0xffFF0000),
                          color:
                              Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                          fontSize: 14,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Icon(CupertinoIcons.chevron_down),
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
                    Text(
                      "Delete Account",
                      style: TextStyle(
                          // color: Color(0xffFF0000),
                          color: Color(0xffD32F2F),
                          fontSize: 14,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("More Options",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    SizedBox(width: 6),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Icon(CupertinoIcons.chevron_down, size: 24),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isExpanded ? 200 : 0, // toggle height
                padding: EdgeInsets.all(16),
                child: _isExpanded
                    ? Container(
                        color: Colors.blue[100],
                        child:
                            Center(child: Text("Your expandable content here")),
                      )
                    : null,
              ),
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
