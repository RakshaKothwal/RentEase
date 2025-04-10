import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "Apartment Grand Palace"),
      body: Padding(
        padding: horizontalPadding,
        child: Column(
          children: [
            Container(
              // height: 50,
              // width: 150,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withAlpha((255 * 0.05).toInt()),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(-1, -1),
                    ),
                    BoxShadow(
                      color: Color(0xff000000).withAlpha((255 * 0.05).toInt()),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(1, 1),
                    )
                  ],
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("May i know about this apartment"),
                    Row(
                      children: [
                        Text("09:38"),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
