import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget propertyBox(
    {required String count,
    required String title,
    required String content,
    IconData? icon}) {
  return Container(
    width: double.infinity,
    // margin: EdgeInsets.all(8),
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
    decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Color(0xff000000).withAlpha((255 * 0.08).toInt()),
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0, 0)),
          BoxShadow(
              color: Color(0xff000000).withAlpha((255 * 0.15).toInt()),
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0, 0))
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Container(
        //   height: 40,
        //   width: 30,
        //   decoration: BoxDecoration(
        //     color: Color(0xffF06262),
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: Center(
        //     child: Text(
        //       count,
        //       style: TextStyle(
        //         color: Color(0xffFFFFFF),
        //         fontSize: 20,
        //         fontWeight: FontWeight.w400,
        //         fontFamily: "Poppins",
        //         letterSpacing: 0,
        //       ),
        //     ),
        //   ),
        // ),
        // Icon,Icon(Icons.currency_rupee),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withAlpha((255 * 0.05).toInt())),
          child: Icon(
            icon,
            size: 20,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  letterSpacing: 0,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.visible,
                content,
                style: TextStyle(
                  color: Color(0xff919191),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  letterSpacing: 0,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 30,
        ),
        SvgPicture.asset(
          height: 32,
          width: 32,
          "assets/svg/tick.svg",
          colorFilter: ColorFilter.mode(Color(0xff009900), BlendMode.srcIn),
        ),
      ],
    ),
  );
}

Widget formLabel(String data) {
  return Text(
    data,
    style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
        color: Colors.black),
  );
}
