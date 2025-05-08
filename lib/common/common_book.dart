import 'package:flutter/material.dart';

Widget summaryItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

// Widget propertyPreviewCard() {
//   return Row(
//     children: [
//       ClipRRect(
//         borderRadius: BorderRadius.circular(21),
//         child: Image.asset(
//           "assets/images/room1.png",
//           height: 130,
//           width: 130,
//           fit: BoxFit.fill,
//         ),
//       ),
//       SizedBox(width: 12),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Color(0xffD32F2F),
//               ),
//               child: Text(
//                 "Girls",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontFamily: "Poppins",
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Star Residence Apartment",
//               style: TextStyle(
//                 color: Colors.black.withAlpha((255 * 0.7).toInt()),
//                 fontSize: 12,
//                 fontFamily: "Poppins",
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             SizedBox(height: 4),
//             Row(
//               children: [
//                 Icon(
//                   Icons.location_on_outlined,
//                   size: 16,
//                   color: Colors.black.withAlpha((255 * 0.9).toInt()),
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   "Adajan, Surat",
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withAlpha((255 * 0.9).toInt()),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

Widget buildStatusChip(String status) {
  late Color chipColor;
  late String statusText;

  switch (status) {
    case 'approved':
      chipColor = Color(0xff29CD0F);
      statusText = 'Approved';
      break;
    case 'rejected':
      chipColor = Color(0xffD32F2F);
      statusText = 'Rejected';
      break;
    default:
      chipColor = Color(0xffF4A020);
      statusText = 'Pending';
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: chipColor.withAlpha((255 * 0.1).toInt()),
      borderRadius: BorderRadius.circular(7),
      border: Border.all(
        color: chipColor,
        width: 0.8,
      ),
    ),
    child: Text(
      statusText,
      style: TextStyle(
        color: chipColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
      ),
    ),
  );
}
