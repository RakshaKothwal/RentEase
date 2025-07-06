import 'package:flutter/material.dart';
import 'package:rentease/common/common_form.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../common/common_book.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String selectedStatus = 'all';

  @override
  Widget build(BuildContext context) {
    final userId = _auth.currentUser?.uid;
    
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: appbar(
          data: "My Bookings", showBackArrow: true, context: context),
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
                    'Please login to view your bookings',
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
                      print('Bookings StreamBuilder state: ${snapshot.connectionState}');
                      print('Bookings StreamBuilder hasData: ${snapshot.hasData}');
                      print('Bookings StreamBuilder hasError: ${snapshot.hasError}');
                      if (snapshot.hasError) {
                        print('Error loading bookings: ${snapshot.error}');
                        print('Error stack trace: ${snapshot.stackTrace}');
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
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {

                                  });
                                },
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                      

                      if (snapshot.connectionState == ConnectionState.active) {
                        FirebaseFirestore.instance
                            .collection('bookings')
                            .get()
                            .then((value) {
                          print('Total bookings in collection: ${value.docs.length}');
                          value.docs.forEach((doc) {
                            print('Booking: ${doc.data()}');
                          });
                        }).catchError((error) {
                          print('Error testing bookings collection: $error');
                        });
                      }
                      
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text(
                                'Loading your bookings...',
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
                                'No bookings found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Your booking history will appear here',
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
                          final propertyName = bookingData['propertyName'] ?? 'Unknown Property';
                          final moveInDate = bookingData['moveInDate'] as Timestamp?;
                          final duration = bookingData['duration'] ?? 'Not specified';
                          final amount = bookingData['amount']?.toString() ?? 'Not specified';
                          final createdAt = bookingData['createdAt'] as Timestamp?;
                          
                          return Padding(
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
                                        Expanded(
                                          child: Text(
                                            propertyName,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins",
                                              color: Colors.black.withAlpha((255 * 0.8).toInt()),
                                            ),
                                          ),
                                        ),
                                        buildStatusChip(status),
                                      ],
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
                                            Icons.calendar_today,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Move-in: ${moveInDate != null ? DateFormat('dd MMM yyyy').format(moveInDate.toDate()) : 'Not specified'}',
                                          style: TextStyle(
                                              color: Colors.black.withAlpha((255 * 0.6).toInt()),
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
                                            color: Colors.black.withAlpha((255 * 0.05).toInt()),
                                          ),
                                          child: Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Duration: $duration',
                                          style: TextStyle(
                                              color: Colors.black.withAlpha((255 * 0.6).toInt()),
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
                                    SizedBox(height: 8),
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
                                            Icons.schedule,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Booked on: ${createdAt != null ? DateFormat('dd MMM yyyy').format(createdAt.toDate()) : 'Unknown'}',
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
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.orange.withOpacity(0.3)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              size: 16,
                                              color: Colors.orange[700],
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'Your booking is under review. The property owner will respond soon.',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.orange[700],
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    if (status == 'approved') ...[
                                      SizedBox(height: 16),
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              size: 16,
                                              color: Colors.green[700],
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'Your booking has been approved! Contact the owner for next steps.',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green[700],
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    if (status == 'rejected') ...[
                                      SizedBox(height: 16),
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.cancel_outlined,
                                              size: 16,
                                              color: Colors.red[700],
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'Your booking was not approved. You can try booking other properties.',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red[700],
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
        .where('userId', isEqualTo: userId);
    
    if (selectedStatus != 'all') {
      query = query.where('status', isEqualTo: selectedStatus);
    }
    
    return query.snapshots();
  }
} 
