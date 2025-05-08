import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../view/navbar.dart';

//for horizontal padding
EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 16);

// for title of parameters in filter page
Widget title(String data) {
  return Text(
    data,
    style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
        color: Colors.black.withAlpha(200)),
  );
}

Widget otpContainer({
  required String data,
}) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xffE1E6EB)),
        borderRadius: BorderRadius.circular(12)),
    child: Center(
        child: Text(
      data,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          fontFamily: "Poppins",
          color: Colors.black),
    )),
  );
}

//circular tab decoration for selected value
Decoration selectedTab() {
  return BoxDecoration(
      color: Color(0xffD32F2F), borderRadius: BorderRadius.circular(20));
}

//circular tab decoration for unselected value
Decoration unselectedTab() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Color(0xffECECEC), width: 1.2),
  );
}

//TextField in forms for input
Widget input({
  IconData? icon,
  String? hintText,
  Widget? suffix,
  Widget? suffixIcon,
  String? suffixText,
  bool obscureText = false,
  int maxLines = 1,
  TextEditingController? controller,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  String? Function(String?)? validation,
  void Function(String?)? onSaved,
}) {
  return TextSelectionTheme(
    data: TextSelectionThemeData(
      selectionHandleColor: Color(0xffD32F2F),
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      maxLines: maxLines,
      obscureText: obscureText,
      cursorColor: Color(0xffD32F2F),
      validator: validation,
      style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black,
          letterSpacing: 0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          suffix: suffix,
          suffixStyle: TextStyle(
              color: Color(0xffB2B2B2),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              fontSize: 12),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Color(0xffB2B2B2),
                  size: 20,
                )
              : null,
          suffixText: suffixText,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color(0xffB2B2B2),
              fontFamily: "Poppins",
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
        fontFamily: "Poppins",
        color: Colors.black),
  );
}

// Submit Button in forms
Widget submit(
    {required String data,
    required void Function()? onPressed,
    double? width,
    double? height}) {
  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffD32F2F),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: onPressed,
        child: Text(
          data,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins"),
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
  BuildContext? context,
  String? data,
  bool showBackArrow = false,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: showBackArrow
        ? IconButton(
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context!);
            },
            icon: Icon(Icons.arrow_back_ios))
        : null,
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
                color: Color(0xff000000).withAlpha((255 * 0.15).toInt()),
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
                fontFamily: "Poppins"),
          )
        ],
      ),
    ),
  );
}

Widget search(
    {void Function()? onTap,
    bool readOnly = false,
    TextEditingController? controller,
    String? hintText}) {
  return SizedBox(
    height: 48,
    child:
        // input(
        //     icon: Icons.search,
        //     hintText: "Search through localities"),
        TextSelectionTheme(
      data: TextSelectionThemeData(selectionHandleColor: Color(0xffD32F2F)),
      child: TextField(
        readOnly: readOnly,
        onTap: onTap,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400),
        controller: controller,
        cursorColor: Color(0xffD32F2F),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Color(0xffF5F5F5),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffA8A8A8),
            // color: Color(0xff838383),
            size: 24,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              // color: Color(0xff858585),
              color: Color(0xffA8A8A8),
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
    ),
  );
}

// for bottomSheet
Future<void> customBottomSheet({
  required BuildContext context,
  Widget? child,
  Function(bool)? toggleNavBar,
}) async {
  if (toggleNavBar != null) {
    toggleNavBar(false);
  }

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

  if (context.mounted && toggleNavBar != null) {
    toggleNavBar(true);
  }
}

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

// for  enquiry options in enquiry form
Widget enquiryOption(
    {required String label,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged}) {
  return Row(
    children: [
      Radio<String>(
        activeColor: Color(0xffD32F2F),
        // focusColor: Color(0xffD32F2F),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      Text(label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
              color: Colors.black)),
    ],
  );
}

// for dialogBox
Future primaryDialogBox(
    {required BuildContext context,
    String? contentText,
    Widget? title,
    void Function()? successTap,
    String? unsuccessText,
    String? successText}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          title: title,
          titleTextStyle: TextStyle(
              color: Colors.black.withAlpha((255 * 0.8).toInt()),
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.w600),
          backgroundColor: Color(0xffEDEDED),
          content: Text(contentText!),
          contentTextStyle: TextStyle(
              color: Colors.black.withAlpha((255 * 0.8).toInt()),
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w400),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  unsuccessText!,
                  style: TextStyle(
                      color: Color(0xffD32F2F),
                      fontFamily: "Poppins",
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                )),
            TextButton(
                onPressed: successTap,
                child: Text(
                  successText!,
                  style: TextStyle(
                      color: Color(0xffD32F2F),
                      fontFamily: "Poppins",
                      fontSize: 13,
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

Widget passwordIcon(bool isObscure, VoidCallback toggle) {
  return IconButton(
    onPressed: toggle,
    icon: Icon(
      isObscure ? Icons.visibility : Icons.visibility_off,
      size: 20,
      color: Color(0xffB2B2B2),
    ),
  );
}
