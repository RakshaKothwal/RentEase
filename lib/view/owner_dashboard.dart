import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/list_property.dart';

import '../common/common_book.dart';

import '../models/property_listing.dart';
import 'notifications.dart';
import 'owner_property_details.dart';
import 'owner_scheduled_visits.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;
  List<PropertyListing> properties = [];
  List<Map<String, dynamic>> activities = [];
  Map<String, dynamic> stats = {
    'totalProperties': 0,
    'activeListings': 0,
    'pendingRequests': 0,
    'totalRevenue': 0,
  };

  @override
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    try {
      final String userId = _auth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        commonToast('Please login to view dashboard');
        return;
      }


      final propertiesSnapshot = await _firestore
          .collection('properties')
          .where('ownerId', isEqualTo: userId)
          .get();

      properties = propertiesSnapshot.docs
          .map((doc) => PropertyListing.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();


      final bookingsSnapshot = await _firestore
          .collection('bookings')
          .where('propertyOwnerId', isEqualTo: userId)
          .get();


      final enquiriesSnapshot = await _firestore
          .collection('enquiries')
          .where('propertyOwnerId', isEqualTo: userId)
          .get();


      stats = {
        'totalProperties': properties.length,
        'activeListings': properties.where((p) => p.isActive).length,
        'pendingRequests': bookingsSnapshot.docs
            .where((doc) => doc.data()['status'] == 'pending')
            .length,
        'totalRevenue': bookingsSnapshot.docs.fold<double>(
            0,
            (sum, doc) =>
                sum + (double.tryParse(doc.data()['amount']?.toString() ?? '0') ?? 0)),
      };


      activities = [];
      

      for (var doc in bookingsSnapshot.docs) {
        final data = doc.data();
        activities.add({
          'title': 'New Booking Request',
          'description': '${data['userName']} requested to book ${data['propertyName']}',
          'time': _getTimeAgo(data['createdAt'] as Timestamp?),
          'type': 'booking',
        });
      }


      for (var doc in enquiriesSnapshot.docs) {
        final data = doc.data();
        activities.add({
          'title': 'New Enquiry',
          'description': '${data['userName']} enquired about ${data['propertyName']}',
          'time': _getTimeAgo(data['createdAt'] as Timestamp?),
          'type': 'enquiry',
        });
      }


      activities.sort((a, b) => b['time'].compareTo(a['time']));

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading dashboard data: $e');
      commonToast('Failed to load dashboard data');
      setState(() {
        isLoading = false;
      });
    }
  }

  String _getTimeAgo(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown time';
    
    final now = DateTime.now();
    final difference = now.difference(timestamp.toDate());
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Text(
          "RentEase",
          style: TextStyle(
              color: Color(0xffD32F2F),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w800,
              fontSize: 24),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: Notifications(), withNavBar: false);
                },
                icon: Icon(
                  Icons.notifications,
                  size: 24,
                  color: Color(0xff363C45),
                ),
              ),
              Positioned(
                top: 14,
                right: 16,
                child: Container(
                  height: 7,
                  width: 7,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              )
            ],
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
        toolbarHeight: 60,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadDashboardData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          buildStatCard(
                            'Total Properties',
                            stats['totalProperties'].toString(),
                            Icons.home,
                          ),
                          buildStatCard(
                            'Active Listings',
                            stats['activeListings'].toString(),
                            Icons.check_circle,
                          ),
                          buildStatCard(
                            'Pending Requests',
                            stats['pendingRequests'].toString(),
                            Icons.pending_actions,
                          ),
                          buildStatCard(
                            'Total Revenue',
                            '₹${stats['totalRevenue'].toStringAsFixed(0)}',
                            Icons.currency_rupee,
                          ),
                        ],
                      ),
                    ),
                    if (activities.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Recent Activities",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: activities.length,
                        itemBuilder: (context, index) {
                          final activity = activities[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    activity['description'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    activity['time'],
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],

                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Quick Actions",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const OwnerScheduledVisits(),
                                      withNavBar: false,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey.shade200),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          size: 32,
                                          color: Color(0xffD32F2F),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Scheduled Visits",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins",
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Manage property visits",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                            fontFamily: "Poppins",
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(context,
              screen: ListProperty(), withNavBar: false);
        },
        backgroundColor: Color(0xffD32F2F),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget buildStatCard(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.05),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFE31B23),
                size: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                    fontFamily: "Poppins",
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
