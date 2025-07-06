import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:rentease/common/global_widget.dart';
import 'dart:convert';

class MyScheduledVisits extends StatefulWidget {
  const MyScheduledVisits({super.key});

  @override
  State<MyScheduledVisits> createState() => _MyScheduledVisitsState();
}

class _MyScheduledVisitsState extends State<MyScheduledVisits> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    
    print('Current user ID: $userId');
    
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: appbar(
          data: "Scheduled Visits", showBackArrow: true, context: context),
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
                    'Please login to view your scheduled visits',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('scheduledVisits')
                  .where('userId', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                print('StreamBuilder state: ${snapshot.connectionState}');
                print('StreamBuilder hasData: ${snapshot.hasData}');
                print('StreamBuilder hasError: ${snapshot.hasError}');
                if (snapshot.hasError) {
                  print('Error loading scheduled visits: ${snapshot.error}');
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
                          'Error loading visits',
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
                      .collection('scheduledVisits')
                      .get()
                      .then((value) {
                    print('Total scheduled visits in collection: ${value.docs.length}');
                    value.docs.forEach((doc) {
                      print('Visit: ${doc.data()}');
                    });
                  }).catchError((error) {
                    print('Error testing collection: $error');
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
                          'Loading your visits...',
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
                          Icons.calendar_today_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No scheduled visits',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Schedule a visit to see it here',
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
                
                final visits = snapshot.data!.docs;
                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  itemCount: visits.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final visit = visits[index];
                    final propertyId = visit['propertyId'];
                    final status = visit['status'] ?? 'pending';
                    

                    DateTime date;
                    try {
                      if (visit['date'] is Timestamp) {
                        date = (visit['date'] as Timestamp).toDate();
                      } else if (visit['date'] is DateTime) {
                        date = visit['date'] as DateTime;
                      } else {

                        date = DateTime.now();
                      }
                    } catch (e) {
                      print('Error parsing date: $e');
                      date = DateTime.now();
                    }
                    
                    final timeSlot = visit['timeSlot'] ?? '';
                    
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('properties')
                          .doc(propertyId)
                          .get(),
                      builder: (context, propSnapshot) {
                        if (!propSnapshot.hasData) {
                          return primaryBox(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        }
                        
                        if (!propSnapshot.data!.exists) {
                          return primaryBox(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Property not found',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          );
                        }
                        
                        final prop = propSnapshot.data!.data() as Map<String, dynamic>;
                        final images = (prop['propertyImages'] as List?) ?? [];
                        String imageUrl = 'assets/images/room1.png';
                        
                        if (images.isNotEmpty) {
                          final firstImage = images[0].toString();
                          if (firstImage.startsWith('data:image')) {

                            imageUrl = firstImage;
                          } else if (firstImage.startsWith('http')) {

                            imageUrl = firstImage;
                          }
                        }
                        
                        return primaryBox(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding: horizontalPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: status == 'pending'
                                            ? Color(0xffF23333).withOpacity(0.1)
                                            : status == 'confirmed'
                                                ? Colors.green.withOpacity(0.1)
                                                : Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        status[0].toUpperCase() + status.substring(1),
                                        style: TextStyle(
                                          color: status == 'pending'
                                              ? Color(0xffF23333)
                                              : status == 'confirmed'
                                                  ? Colors.green
                                                  : Colors.grey,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd MMM yyyy').format(date),
                                      style: TextStyle(
                                        color: Color(0xffB2B2B2),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Padding(
                                padding: horizontalPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 14, color: Colors.grey),
                                    SizedBox(width: 4),
                                    Text(
                                      timeSlot,
                                      style: TextStyle(
                                        color: Color(0xffB2B2B2),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color(0xffF5F5F5),
                                thickness: 2,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: horizontalPadding,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: imageUrl.startsWith('data:image')
                                          ? Image.memory(
                                              base64Decode(imageUrl.split(',')[1]),
                                              fit: BoxFit.cover,
                                              height: 80,
                                              width: 80,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/room1.png',
                                                  fit: BoxFit.cover,
                                                  height: 80,
                                                  width: 80,
                                                );
                                              },
                                            )
                                          : imageUrl.startsWith('http')
                                              ? Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.cover,
                                                  height: 80,
                                                  width: 80,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/room1.png',
                                                      fit: BoxFit.cover,
                                                      height: 80,
                                                      width: 80,
                                                    );
                                                  },
                                                )
                                              : Image.asset(
                                                  imageUrl,
                                                  fit: BoxFit.cover,
                                                  height: 80,
                                                  width: 80,
                                                ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            prop['title'] ?? '',
                                            softWrap: true,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black.withAlpha(
                                                    (255 * 0.9).toInt()),
                                                fontSize: 14,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Row(children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              prop['city'] ?? '',
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff818181)),
                                            ),
                                          ]),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.currency_rupee,
                                                  size: 17,
                                                  weight: 900,
                                                  applyTextScaling: true,
                                                  grade: 50,
                                                  color: Colors.black.withAlpha(
                                                      (255 * 0.75).toInt()),
                                              ),
                                              Text(
                                                prop['expectedRent']?.toString() ?? '',
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withAlpha((255 * 0.75)
                                                            .toInt())),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
