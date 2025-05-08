import 'package:flutter/material.dart';
import 'package:rentease/common/common_form.dart';
import 'package:rentease/common/global_widget.dart';

import '../common/common_book.dart';
import 'owner_booking_details.dart';

class OwnerBookings extends StatefulWidget {
  const OwnerBookings({super.key});

  @override
  State<OwnerBookings> createState() => _OwnerBookingsState();
}

class _OwnerBookingsState extends State<OwnerBookings> {
  final List<Map<String, dynamic>> bookingRequests = [
    {
      'name': 'John Doe',
      'property': 'Star Residence Apartment',
      'date': '22 Mar 2024',
      'duration': '6 months',
      'status': 'pending'
    },
    {
      'name': 'Jane Smith',
      'property': 'Green View PG',
      'date': '23 Mar 2024',
      'duration': '12 months',
      'status': 'approved'
    },
    {
      'name': 'Mike Johnson',
      'property': 'Star Residence Apartment',
      'date': '25 Mar 2024',
      'duration': '3 months',
      'status': 'rejected'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: appbar(
          data: "Booking Requests", showBackArrow: true, context: context),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: bookingRequests.length,
          itemBuilder: (context, index) {
            final request = bookingRequests[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OwnerBookingDetails(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: primaryBox(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              request['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color:
                                    Colors.black.withAlpha((255 * 0.8).toInt()),
                              ),
                            ),
                            buildStatusChip(request['status']),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          request['property'],
                          style: TextStyle(
                              color:
                                  Colors.black.withAlpha((255 * 0.6).toInt()),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black
                                    .withAlpha((255 * 0.05).toInt()),
                              ),
                              child: Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Move-in: ${request['date']}',
                              style: TextStyle(
                                  color: Colors.black
                                      .withAlpha((255 * 0.6).toInt()),
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black
                                    .withAlpha((255 * 0.05).toInt()),
                              ),
                              child: Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Duration: ${request['duration']}',
                              style: TextStyle(
                                  color: Colors.black
                                      .withAlpha((255 * 0.6).toInt()),
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        if (request['status'] == 'pending') ...[
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                  child: submit(
                                      data: "Approve",
                                      onPressed: () {
                                        setState(() {
                                          bookingRequests[index]['status'] =
                                              'approved';
                                        });
                                      })),
                              SizedBox(width: 8),
                              Expanded(
                                  child: outlinedSubmit(
                                      data: "Reject",
                                      onPressed: () {
                                        setState(() {
                                          bookingRequests[index]['status'] =
                                              'rejected';
                                        });
                                      })),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
