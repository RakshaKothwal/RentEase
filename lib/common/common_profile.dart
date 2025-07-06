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


Widget primaryInfo({
  required String label,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          width: 120, // Fixed width for labels
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              fontSize: 13,
              fontFamily: "Poppins",
            ),
          ),
        ),
        SizedBox(width: 16), // Spacing between label and value

        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Color(0xFF000000).withAlpha((255 * 0.75).toInt()),
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              fontSize: 13,
              fontFamily: "Poppins",
            ),
            textAlign: TextAlign.right,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
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
