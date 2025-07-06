import 'package:flutter/material.dart';

Widget sectionTitle({
  required String data,
}) {
  return Text(data,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
        color: Color(0xff2A2B3F),
      ));
}

Widget buildSelectableCard(String title, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffFFF3F3) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Color(0xffD32F2F) : Color(0xffE0E0E0),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Color(0xffD32F2F) : Color(0xff808080),
          fontFamily: "Poppins",
          fontSize: 14,
        ),
      ),
    ),
  );
}

Widget buildCard({
  required String title,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffD32F2F) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? Color(0xffD32F2F) : Color(0xffE0E0E0),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xff2A2B3F),
          fontFamily: "Poppins",
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget buildDropdownWithIcon({
  required String hint,
  required IconData icon,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
  String? Function(String?)? validation,
}) {
  return TextSelectionTheme(
    data: TextSelectionThemeData(
      selectionHandleColor: Color(0xffD32F2F),
    ),
    child: DropdownButtonFormField<String>(
      isExpanded: true,
      value: value,
      validator: validation,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      hint: Text(
        hint,
        style: TextStyle(
          color: Color(0xffB2B2B2),
          fontFamily: "Poppins",
          fontSize: 12,
        ),
      ),
      dropdownColor: Color(0xffFAFAFA),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        prefixIcon: Icon(
          icon,
          color: Color(0xffB2B2B2),
          size: 20,
        ),






        filled: true,
        fillColor: Color(0xffF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}

Decoration sectionDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha((255 * 0.05).toInt()),
        blurRadius: 10,
        offset: Offset(0, 2),
      ),
    ],
  );
}







































Widget selectableChip({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: isSelected
          ? BoxDecoration(
              color: Color(0xffD32F2F),
              borderRadius: BorderRadius.circular(20),
            )
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xffECECEC),
                width: 1.2,
              ),
            ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xff606060),
          fontFamily: "Poppins",
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

Widget outlinedSubmit(
    {required String data,
    required void Function()? onPressed,
    double? width,
    double? height}) {
  return SizedBox(
    height: height,
    width: width,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Color(0xffD32F2F), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),

      ),
      child: Text(
        data,
        style: TextStyle(
          color: Color(0xffD32F2F),
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
        ),
      ),
    ),
  );
}

Widget buildNavbar({required Widget child}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((255 * 0.05).toInt()),
          blurRadius: 10,
          offset: Offset(0, -5),
        ),
      ],
    ),
    child: child,
  );
}

Widget buildStatCard(String title, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha((255 * 0.1).toInt()),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3250),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    ),
  );
}
