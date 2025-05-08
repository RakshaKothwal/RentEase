import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<Map<String, dynamic>> messages = [
    {"msg": "hi", "isMe": true, "time": "10:00 am"},
    {"msg": "hello", "isMe": false, "time": "10:15 am"},
    {"msg": "can you help me?", "isMe": true, "time": "10:17 am"},
    {
      "msg": "Is it possible to negotiate the rent?",
      "isMe": true,
      "time": "10:18 am"
    },
    {
      "msg": "no, we do not offer these services",
      "isMe": false,
      "time": "10:49 am"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: appbar(
        showBackArrow: true,
        context: context,
        data: "Apartment Grand Palace",
      ),
      body: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  final chat = messages[index];
                  final isMe = chat['isMe'];
                  return Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(14),

                        // height: 50,
                        // width: 150,
                        decoration: BoxDecoration(
                            color: isMe ? Color(0xffF5F5F5) : Color(0xffD32F2F),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(isMe ? 0 : 16),
                                bottomLeft: Radius.circular(isMe ? 16 : 0))),
                        child: Text(
                          chat['msg'],
                          style: TextStyle(
                              color: isMe ? Colors.black : Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      // SizedBox(
                      //   height: 2,
                      // ),
                      Text(
                        chat['time'],
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontSize: 9,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  // final chat = messages[index];
                  // final isMe = chat['isMe'];
                  return SizedBox(
                    height: 8,
                  );
                },
                itemCount: messages.length,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 2),
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withAlpha((255 * 0.08).toInt()),
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: Offset(-1, -1),
                  ),
                ],
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(20))),
            child: Row(
              children: [
                Expanded(
                    child: TextSelectionTheme(
                  data: TextSelectionThemeData(
                    selectionHandleColor: Color(0xffD32F2F),
                  ),
                  child: TextFormField(
                    cursorColor: Color(0xffD32F2F),
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black,
                        letterSpacing: 0),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        hintText: "Write message ...",
                        hintStyle: TextStyle(
                            color: Color(0xffB2B2B2),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        filled: true,
                        fillColor: Color(0xffF5F5F5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                )),
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 16, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffD32F2F),
                  ),
                  child: Icon(
                    Icons.send,
                    size: 22,
                    color: Color(0xffFFFFFF),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
