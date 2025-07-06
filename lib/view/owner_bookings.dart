import 'package:flutter/material.dart';
import 'package:rentease/common/common_form.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../common/common_book.dart';
import 'owner_booking_details.dart';

class OwnerBookings extends StatefulWidget {
  const OwnerBookings({super.key});

  @override
  State<OwnerBookings> createState() => _OwnerBookingsState();
}

class _OwnerBookingsState extends State<OwnerBookings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String selectedStatus = 'all';

  @override
  Widget build(BuildContext context) {
    final userId = _auth.currentUser?.uid;
    
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: appbar(
          data: "Booking Requests", showBackArrow: true, context: context),
      body: userId == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Please login to view bookings',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [

                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        'Filter by status:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildStatusChip('all', 'All'),
                              SizedBox(width: 8),
                              _buildStatusChip('pending', 'Pending'),
                              SizedBox(width: 8),
                              _buildStatusChip('approved', 'Approved'),
                              SizedBox(width: 8),
                              _buildStatusChip('rejected', 'Rejected'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _getBookingsStream(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text(
                                'Loading bookings...',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      
                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[400],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Error loading bookings',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red[600],
                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check your connection and try again',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                  fontFamily: "Poppins",
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.book_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No booking requests',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Booking requests for your properties will appear here',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                  fontFamily: "Poppins",
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      
                      final bookings = snapshot.data!.docs;
                      return ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: bookings.length,
                        itemBuilder: (context, index) {
                          final booking = bookings[index];
                          final bookingData = booking.data() as Map<String, dynamic>;
                          final status = bookingData['status'] ?? 'pending';
                          final userName = bookingData['userName'] ?? 'Unknown User';
                          final propertyName = bookingData['propertyName'] ?? 'Unknown Property';
                          final moveInDate = bookingData['moveInDate'] as Timestamp?;
                          final duration = bookingData['duration'] ?? 'Not specified';
                          final amount = bookingData['amount']?.toString() ?? 'Not specified';
                          
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OwnerBookingDetails(
                                    bookingId: booking.id,
                                    bookingData: bookingData,
                                  ),
                                ),
                              );
                            },
                            child: primaryBox(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            userName,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins",
                                              color: Colors.black.withAlpha((255 * 0.8).toInt()),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              moveInDate != null ? DateFormat('dd MMM yyyy').format(moveInDate.toDate()) : 'Not specified',
                                              style: TextStyle(
                                                color: Color(0xffB2B2B2),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.access_time, size: 14, color: Colors.grey),
                                                SizedBox(width: 4),
                                                Text(
                                                  duration,
                                                  style: TextStyle(
                                                    color: Color(0xffB2B2B2),
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    buildStatusChip(status),
                                    SizedBox(height: 8),
                                    Text(
                                      propertyName,
                                      style: TextStyle(
                                          color: Colors.black.withAlpha((255 * 0.6).toInt()),
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
                                            color: Colors.black.withAlpha((255 * 0.05).toInt()),
                                          ),
                                          child: Icon(
                                            Icons.currency_rupee,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Amount: ₹$amount',
                                          style: TextStyle(
                                              color: Colors.black.withAlpha((255 * 0.6).toInt()),
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    if (status == 'pending') ...[
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: submit(
                                                  data: "Approve",
                                                  onPressed: () {
                                                    _updateBookingStatus(booking.id, 'approved');
                                                  })),
                                          SizedBox(width: 8),
                                          Expanded(
                                              child: outlinedSubmit(
                                                  data: "Reject",
                                                  onPressed: () {
                                                    _updateBookingStatus(booking.id, 'rejected');
                                                  })),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatusChip(String status, String label) {
    final isSelected = selectedStatus == status;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = status;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffD32F2F) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xffD32F2F) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> _getBookingsStream(String userId) {
    Query query = FirebaseFirestore.instance
        .collection('bookings')
        .where('propertyOwnerId', isEqualTo: userId);
    
    if (selectedStatus != 'all') {
      query = query.where('status', isEqualTo: selectedStatus);
    }
    
    return query.snapshots();
  }

  Future<void> _updateBookingStatus(String bookingId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .update({
        'status': status,
        'updatedAt': DateTime.now(),
      });
      
      commonToast('Booking ${status} successfully');
    } catch (e) {
      commonToast('Failed to update booking status');
    }
  }
}
