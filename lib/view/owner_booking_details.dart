import 'package:flutter/material.dart';
import 'package:rentease/common/common_form.dart';
import 'package:rentease/common/common_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../common/global_widget.dart';

class OwnerBookingDetails extends StatefulWidget {
  final String bookingId;
  final Map<String, dynamic> bookingData;
  
  const OwnerBookingDetails({
    super.key, 
    required this.bookingId,
    required this.bookingData,
  });

  @override
  State<OwnerBookingDetails> createState() => _OwnerBookingDetailsState();
}

class _OwnerBookingDetailsState extends State<OwnerBookingDetails> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bookingData = widget.bookingData;
    final propertyName = bookingData['propertyName'] ?? 'Unknown Property';
    final userName = bookingData['userName'] ?? 'Unknown User';
    final userPhone = bookingData['userPhone'] ?? 'Not provided';
    final userEmail = bookingData['userEmail'] ?? 'Not provided';
    final moveInDate = bookingData['moveInDate'] as Timestamp?;
    final duration = bookingData['duration'] ?? 'Not specified';
    final amount = bookingData['amount']?.toString() ?? 'Not specified';
    final status = bookingData['status'] ?? 'pending';
    final createdAt = bookingData['createdAt'] as Timestamp?;
    
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(
            data: "Booking Request", showBackArrow: true, context: context),
        body: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: sectionDecoration(),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage("assets/images/room1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                propertyName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  color: Color(0xff000000)
                                      .withAlpha((255 * 0.75).toInt()),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Booking ID: ${widget.bookingId}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '₹$amount/month',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000)
                                      .withAlpha((255 * 0.75).toInt()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  header("Tenant Details"),
                  SizedBox(height: 16),
                  primaryInfo(label: "Name", value: userName),
                  SizedBox(height: 2),
                  primaryInfo(label: "Phone", value: userPhone),
                  SizedBox(height: 2),
                  primaryInfo(label: "Email", value: userEmail),
                  SizedBox(height: 50),
                  header("Booking Details"),
                  SizedBox(height: 16),
                  primaryInfo(
                    label: "Move-in Date", 
                    value: moveInDate != null 
                        ? DateFormat('dd MMM yyyy').format(moveInDate.toDate())
                        : 'Not specified'
                  ),
                  SizedBox(height: 2),
                  primaryInfo(label: "Duration", value: duration),
                  SizedBox(height: 2),
                  primaryInfo(label: "Amount", value: '₹$amount'),
                  SizedBox(height: 2),
                  primaryInfo(
                    label: "Booked on", 
                    value: createdAt != null 
                        ? DateFormat('dd MMM yyyy, hh:mm a').format(createdAt.toDate())
                        : 'Unknown'
                  ),
                  SizedBox(height: 2),
                  primaryInfo(label: "Status", value: status.toUpperCase()),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: status == 'pending' 
            ? buildNavbar(
                child: Row(
                  children: [
                    Expanded(
                      child: outlinedSubmit(
                        data: "Reject", 
                        onPressed: isLoading ? null : () => _updateStatus('rejected')
                      )
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: submit(
                        data: "Accept", 
                        onPressed: isLoading ? null : () => _updateStatus('approved')
                      )
                    ),
                  ],
                )
              )
            : buildNavbar(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Booking ${status.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      color: status == 'approved' ? Colors.green : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              )
    );
  }

  Future<void> _updateStatus(String newStatus) async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(widget.bookingId)
          .update({
        'status': newStatus,
        'updatedAt': DateTime.now(),
      });
      
      commonToast('Booking ${newStatus} successfully');
      
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      commonToast('Failed to update booking status');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
