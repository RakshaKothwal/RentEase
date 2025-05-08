import 'package:flutter/material.dart';

Widget header(String data) {
  return Text(
    data,
    style: TextStyle(
        color: Colors.black.withAlpha((255 * 0.8).toInt()),
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
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //info at left side
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF666666),
            // color: Color(0xFF000000),
            fontWeight: FontWeight.w500,

            letterSpacing: 0,
            fontSize: 13,
            fontFamily: "Poppins",
          ),
        ),
        //info at right side
        Text(
          value,
          style: TextStyle(
            color: Color(0xFF000000).withAlpha((255 * 0.75).toInt()),
            // color: Color(0xFF2D3250),
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            fontSize: 13,
            fontFamily: "Poppins",
          ),
        ),
      ],
    ),
  );
}

// for other submit button in myContract page
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
