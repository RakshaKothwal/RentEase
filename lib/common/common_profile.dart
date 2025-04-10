import 'package:flutter/material.dart';

//header title of info in myContract page
Widget header(String data) {
  return Text(
    data,
    style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600),
  );
}

// for info in myContract page
Widget primaryInfo({
  required String label,
  required String value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          color: Color(0xff000000),
          fontWeight: FontWeight.w300,
          letterSpacing: 0,
          fontSize: 13,
          fontFamily: "Poppins",
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: Color(0xff000000).withAlpha((255 * 0.88).toInt()),
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          fontSize: 13,
          fontFamily: "Poppins",
        ),
      ),
    ],
  );
}

Widget secondarySubmit(
    {required String data, required void Function()? onPressed}) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Color(0xffFFFFFF),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xffD32F2F), width: 1),
              borderRadius: BorderRadius.circular(12),
            )),
        onPressed: onPressed,
        child: Text(
          data,
          style: TextStyle(
              color: Color(0xffD32F2F),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins"),
        )),
  );
}
