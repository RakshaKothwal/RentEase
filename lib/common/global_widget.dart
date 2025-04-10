import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../view/navbar.dart';

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

//holds icon in the circle shape container in details page
Widget iconHolder({Widget? child}) {
  return Container(
    height: 38,
    width: 38,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xff000000).withAlpha((255 * 0.18).toInt()),
    ),
    child: Center(
      child: child,
    ),
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
    // titleSpacing: 0,
  );
}

// for containers in profile page
Widget primaryBox({Widget? child}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Color(0xff000000).withAlpha((255 * 0.05).toInt()),
          blurRadius: 6,
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
          size: 22,
          color: Colors.black.withAlpha((255 * 0.8).toInt()),
        ),
      )
    ],
  );
}

//  container in my dormitory page
Widget dormContainer(
    {required Widget leading,
    required String data,
    double? height,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color(0xff000000).withAlpha((255 * 0.25).toInt()),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(1, 1))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading,
          SizedBox(
            height: 12,
          ),
          Text(
            data,
            style: TextStyle(
                letterSpacing: 0,
                color: Color(0xff000000).withAlpha((255 * 0.7).toInt()),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter"),
          )
        ],
      ),
    ),
  );
}

Future<void> customBottomSheet({
  required BuildContext context,
  Widget? child,
  Function(bool)? toggleNavBar,
}) async {
  // toggleNavBar!(false);
  if (toggleNavBar != null) {
    toggleNavBar(false);
  }

  // WidgetsBinding.instance.addPostFrameCallback((_) async {
  if (!context.mounted) return;

  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    // backgroundColor: Color(0xffEDEDED),
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          SizedBox(
            width: double.infinity,
            child: child,
          ),
        ],
      );
    },
  );
  // if (context.mounted) {
  if (context.mounted && toggleNavBar != null) {
    toggleNavBar(true);
  }
}
//   );
// }

BoxDecoration commonDecoration() {
  return BoxDecoration(
      color: Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withAlpha((255 * 0.5).toInt()),
            blurRadius: 2,
            spreadRadius: 0,
            offset: Offset(0.5, 0.5)),
      ]);
}

Future primaryDialogBox(
    {required BuildContext context,
    String? contentText,
    void Function()? successTap,
    String? secondaryText,
    String? successText}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffEDEDED),
          content: Text(contentText!),
          contentTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w400),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  secondaryText!,
                  style: TextStyle(
                      color: Color(0xffD32F2F),
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )),
            TextButton(
                onPressed: successTap,
                child: Text(
                  successText!,
                  style: TextStyle(
                      color: Color(0xffD32F2F),
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ))
          ],
        );
      });
}

InputDecoration inputDecoration({String? hintText}) {
  return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      hintText: hintText,
      filled: true,
      fillColor: Colors.white24,
      border: commonBorder(),
      enabledBorder: commonBorder(),
      disabledBorder: commonBorder(),
      focusedBorder: commonBorder(width: 1.0, color: Colors.grey.shade500),
      errorBorder: commonBorder(),
      focusedErrorBorder:
          commonBorder(width: 1.0, color: Colors.grey.shade500));
}

OutlineInputBorder commonBorder(
    {Color color = Colors.grey, double width = 0.5}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: color, width: width));
}
// Future customBottomSheet({
//   required BuildContext context,
//   Widget? child,
//   required Function(bool) toggleNavBar,
// }) {
//   toggleNavBar(false);
//
//   return showModalBottomSheet(
//       isScrollControlled: true,
//       backgroundColor: Color(0xffEDEDED),
//       // backgroundColor: Colors.white,
//       context: context,
//       builder: (BuildContext context) {
//         return Wrap(children: [
//           SizedBox(
//             width: double.infinity,
//             child: child,
//           ),
//         ]);
//       }).whenComplete(() {
//     toggleNavBar(true); // Show navbar when modal closes
//   });
// }

// Future<T?> customBottomSheet<T>({
//   required BuildContext context,
//   required Widget child,
// }) {
//   return showModalBottomSheet<T>(
//     backgroundColor: const Color(0xffEDEDED),
//     context: context,
//     builder: (BuildContext context) {
//       return Wrap(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: child,
//           ),
//         ],
//       );
//     },
//   );
// }
