import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:rentease/common/global_widget.dart';
import 'dart:convert';

class OwnerScheduledVisits extends StatefulWidget {
  final String? propertyId;

  const OwnerScheduledVisits({super.key, this.propertyId});

  @override
  State<OwnerScheduledVisits> createState() => _OwnerScheduledVisitsState();
}

class _OwnerScheduledVisitsState extends State<OwnerScheduledVisits> {
  String selectedStatus = 'all';

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: appbar(
          data: widget.propertyId != null ? "Property Visits" : "All Visits",
          showBackArrow: true,
          context: context),
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
                    'Please login to view property visits',
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
                              _buildStatusChip('confirmed', 'Confirmed'),
                              SizedBox(width: 8),
                              _buildStatusChip('cancelled', 'Cancelled'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: widget.propertyId != null
                        ? FirebaseFirestore.instance
                            .collection('scheduledVisits')
                            .where('propertyId', isEqualTo: widget.propertyId)
                            .orderBy('date', descending: true)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('scheduledVisits')
                            .orderBy('date', descending: true)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text(
                                'Loading visits...',
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
                                'No visits scheduled',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Visits for your properties will appear here',
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


                      final allVisits = snapshot.data!.docs;
                      final ownerVisits = <QueryDocumentSnapshot>[];

                      for (var visit in allVisits) {
                        final visitData = visit.data() as Map<String, dynamic>;
                        final status = visitData['status'] ?? 'pending';


                        if (selectedStatus != 'all' &&
                            status != selectedStatus) {
                          continue;
                        }


                        final propertyId = visitData['propertyId'];
                        if (propertyId != null) {


                          ownerVisits.add(visit);
                        }
                      }

                      if (ownerVisits.isEmpty) {
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
                                'No visits for your properties',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'When tenants schedule visits, they will appear here',
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

                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: ownerVisits.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final visit = ownerVisits[index];
                          final visitData =
                              visit.data() as Map<String, dynamic>;
                          final propertyId = visitData['propertyId'];
                          final status = visitData['status'] ?? 'pending';
                          final date =
                              (visitData['date'] as Timestamp).toDate();
                          final timeSlot = visitData['timeSlot'] ?? '';
                          final visitUserId = visitData['userId'] ?? '';

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
                                    child: Center(
                                        child: CircularProgressIndicator()),
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

                              final prop = propSnapshot.data!.data()
                                  as Map<String, dynamic>;
                              final propOwnerId = prop['ownerId'] ?? '';


                              if (propOwnerId != userId) {
                                return SizedBox.shrink();
                              }

                              final images = (prop['images'] as List?) ?? [];
                              final imageUrl = images.isNotEmpty &&
                                      images[0].toString().startsWith('http')
                                  ? images[0]
                                  : 'assets/images/room1.png';

                              return FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(visitUserId)
                                    .get(),
                                builder: (context, userSnapshot) {
                                  String userName = 'Unknown User';

                                  if (userSnapshot.hasData &&
                                      userSnapshot.data!.exists) {
                                    final userData = userSnapshot.data!.data()
                                        as Map<String, dynamic>?;
                                    if (userData != null) {

                                      userName = userData['name'] ??
                                          userData['fullName'] ??
                                          userData['userName'] ??
                                          userData['displayName'] ??
                                          'Unknown User';
                                    }
                                  }


                                  if (userName == 'Unknown User' &&
                                      visitUserId.isNotEmpty) {
                                    userName =
                                        'User ${visitUserId.substring(0, 8)}...';
                                  }

                                  return primaryBox(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: horizontalPadding,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: status == 'pending'
                                                      ? Color(0xffF23333)
                                                          .withOpacity(0.1)
                                                      : status == 'confirmed'
                                                          ? Colors.green
                                                              .withOpacity(0.1)
                                                          : Colors.grey
                                                              .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  status[0].toUpperCase() +
                                                      status.substring(1),
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
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    DateFormat('dd MMM yyyy')
                                                        .format(date),
                                                    style: TextStyle(
                                                      color: Color(0xffB2B2B2),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons.access_time,
                                                          size: 14,
                                                          color: Colors.grey),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        timeSlot,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffB2B2B2),
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 11,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ],
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: imageUrl.startsWith(
                                                        'data:image')
                                                    ? Image.memory(
                                                        base64Decode(imageUrl
                                                            .split(',')[1]),
                                                        fit: BoxFit.cover,
                                                        height: 80,
                                                        width: 80,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Image.asset(
                                                            'assets/images/room1.png',
                                                            fit: BoxFit.cover,
                                                            height: 80,
                                                            width: 80,
                                                          );
                                                        },
                                                      )
                                                    : imageUrl
                                                            .startsWith('http')
                                                        ? Image.network(
                                                            imageUrl,
                                                            fit: BoxFit.cover,
                                                            height: 80,
                                                            width: 80,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                'assets/images/room1.png',
                                                                fit: BoxFit
                                                                    .cover,
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [






































                                                    Text(
                                                      prop['title'] ?? '',
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withAlpha(
                                                                  (255 * 0.9)
                                                                      .toInt()),
                                                          fontSize: 16,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),




































                                                    SizedBox(height: 5),
                                                    Row(children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        prop['city'] ?? '',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xff818181)),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (status == 'pending') ...[
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: horizontalPadding,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () =>
                                                        _updateVisitStatus(
                                                            visit.id,
                                                            'confirmed'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () =>
                                                        _updateVisitStatus(
                                                            visit.id,
                                                            'cancelled'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
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

  Future<void> _updateVisitStatus(String visitId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('scheduledVisits')
          .doc(visitId)
          .update({
        'status': status,
        'updatedAt': DateTime.now(),
      });

      commonToast('Visit ${status} successfully');
    } catch (e) {
      commonToast('Failed to update visit status');
    }
  }


  Future<void> _debugUserData(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        print('User data for $userId: $userData');


        final fields = userData.keys.toList();
        final fullName = userData['fullName'] ?? 'Not found';
        final name = userData['name'] ?? 'Not found';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User: $fullName | Fields: ${fields.join(', ')}'),
            duration: Duration(seconds: 5),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User document does not exist for ID: $userId'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching user data: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
