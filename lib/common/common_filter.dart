import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global_widget.dart';

Widget selector(
    {required void Function(int index) onSelect,
    required int itemCount,
    required List<String> data,
    required bool Function(int index) selectedCondition}) {
  return SizedBox(
    height: 34,
    child: ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(overscroll: false),
      child: ListView.separated(
        padding: horizontalPadding,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          bool isSelected = selectedCondition(index);
          return GestureDetector(
            onTap: () {
              setState() {}
            },
            child: Container(
              // width: 100,
              decoration: isSelected
                  ? BoxDecoration(
                      color: Color(0xffD32F2F),
                      borderRadius: BorderRadius.circular(6),
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Color(0xffECECEC), width: 1.2),
                    ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Text(
                    data[index],
                    style: isSelected
                        ? TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w400)
                        : TextStyle(
                            color: Color(0xff606060),
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 6,
          );
        },
        itemCount: itemCount,
      ),
    ),
  );
}
