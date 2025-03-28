import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

//for horizontal padding
EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 16);

// for title in filter page
Widget title(String data) {
  return Text(
    data,
    style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: "Inter",
        color: Colors.black.withAlpha(200)),
  );
}

//TextField in forms for input
Widget input({
  IconData? icon,
  String? hintText,
  Widget? suffix,
  Widget? suffixIcon,
  bool obscureText = false,
}) {
  return TextSelectionTheme(
    data: TextSelectionThemeData(
      selectionHandleColor: Color(0xffD32F2F),
    ),
    child: TextFormField(
      obscureText: obscureText,
      cursorColor: Color(0xffD32F2F),
      style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black,
          letterSpacing: 0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          suffix: suffix,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Color(0xffB2B2B2),
                  size: 20,
                )
              : null,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color(0xffB2B2B2),
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
              fontSize: 12),
          filled: true,
          fillColor: Color(0xffF5F5F5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent))),
    ),
  );
}

// Label of form fields
Widget label(String data) {
  return Text(
    data,
    style: TextStyle(
        fontSize: 13,
        // letterSpacing: 0,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter",
        color: Colors.black),
  );
}

// Submit Button in forms
Widget submit({required String data, required void Function()? onPressed}) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffD32F2F),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: onPressed,
        child: Text(
          data,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: "Inter"),
        )),
  );
}

//for showing message through toast
Future<bool?> commonToast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
  );
}

//for appbar
PreferredSizeWidget appbar({
  String? data,
}) {
  return AppBar(
    title: Text(
      data!,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
          color: Colors.black),
    ),
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
  );
}

// for containers in profile page
Widget primaryBox({Widget? child}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Color(0xff000000).withAlpha((255 * 0.15).toInt()),
          blurRadius: 10,
          spreadRadius: 0,
          offset: Offset(2, 2))
    ], borderRadius: BorderRadius.circular(20), color: Color(0xffFFFFFF)),
    child: child,
  );
}

//common rows in container in profile page
Widget primaryRow(
    {IconData? icon, required String data, void Function()? onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 24,
        color: Colors.black.withAlpha((255 * 0.8).toInt()),
      ),
      SizedBox(
        width: 14,
      ),
      Text(
        data,
        style: TextStyle(
            color: Colors.black.withAlpha((255 * 0.8).toInt()),
            fontSize: 14,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500),
      ),
      Spacer(),
      GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.arrow_forward_ios,
          size: 24,
          color: Colors.black.withAlpha((255 * 0.8).toInt()),
        ),
      )
    ],
  );
}
