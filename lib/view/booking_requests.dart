import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

import '../common/common_book.dart';

class BookingRequests extends StatefulWidget {
  const BookingRequests({super.key});

  @override
  State<BookingRequests> createState() => _BookingRequestsState();
}

class _BookingRequestsState extends State<BookingRequests> {
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
      'status': 'pending'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "Booking Requests"),
      body: ListView.builder(
        itemCount: bookingRequests.length,
        itemBuilder: (context, index) {
          final request = bookingRequests[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        ),
                      ),
                      buildStatusChip(request['status']),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    request['property'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        'Move-in: ${request['date']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        'Duration: ${request['duration']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffD32F2F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Approve',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xffD32F2F)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Reject',
                            style: TextStyle(color: Color(0xffD32F2F)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
