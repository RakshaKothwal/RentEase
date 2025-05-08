import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/list_property.dart';

import '../common/common_book.dart';

import 'notifications.dart';
import 'owner_property_details.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  final List<Map<String, dynamic>> propertyStats = [
    {'title': 'Total Properties', 'count': '12', 'icon': Icons.home},
    {'title': 'Active Listings', 'count': '8', 'icon': Icons.check_circle},
    {'title': 'Pending Requests', 'count': '5', 'icon': Icons.pending_actions},
    {
      'title': 'Total Revenue',
      'count': '₹45,000',
      'icon': Icons.currency_rupee
    },
  ];

  final properties = [
    {
      'name': 'Star Residence Apartment',
      'location': 'Adajan, Surat',
      'type': 'PG',
      'occupancy': '80%',
    },
    {
      'name': 'Green View PG',
      'location': 'Vesu, Surat',
      'type': 'PG',
      'occupancy': '65%',
    },
  ];

  final activities = [
    {
      'title': 'New Booking Request',
      'description':
          'Raksha Kothwal requested to book Star Residence Apartment',
      'time': '2 hours ago',
    },
    {
      'title': 'Payment Received',
      'description': 'Received rent payment for Green View PG',
      'time': '5 hours ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
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
        // title: Text(
        //   "Dashboard",
        //   style: TextStyle(
        //       color: Colors.black.withAlpha((255 * 0.8).toInt()),
        //       fontFamily: "Montserrat",
        //       fontWeight: FontWeight.w800,
        //       fontSize: 22),
        // ),
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
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dashboard Overview",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                        physics: NeverScrollableScrollPhysics(),
                        children: propertyStats.map((stat) {
                          return primaryBox(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black
                                          .withAlpha((255 * 0.05).toInt()),
                                    ),
                                    child: Icon(
                                      stat['icon'],
                                      color: Color(0xffD32F2F),
                                      size: 20,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        stat['count'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins",
                                          color: Colors.black
                                              .withAlpha((255 * 0.8).toInt()),
                                        ),
                                      ),
                                      Text(
                                        stat['title'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black
                                              .withAlpha((255 * 0.6).toInt()),
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
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Properties",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: properties.length,
                        itemBuilder: (context, index) {
                          final property = properties[index];
                          return GestureDetector(
                            onTap: () {
                              // PersistentNavBarNavigator.pushNewScreen(context,
                              //     screen: OwnerPropertyDetails(property: property,),
                              //     withNavBar: false);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: primaryBox(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'assets/images/room1.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              property['name']!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Poppins",
                                                color: Colors.black.withAlpha(
                                                    (255 * 0.8).toInt()),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on_outlined,
                                                    size: 16,
                                                    color: Colors.grey),
                                                SizedBox(width: 4),
                                                Expanded(
                                                  child: Text(
                                                    property['location']!,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffD32F2F)
                                                        .withAlpha((255 * 0.1)
                                                            .toInt()),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    property['type']!,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffD32F2F),
                                                        fontSize: 12,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Occupancy: ${property['occupancy']}',
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400),
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
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Activities",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: activities.length,
                        itemBuilder: (context, index) {
                          final activity = activities[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: primaryBox(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            activity['title']!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins",
                                              color: Colors.black.withAlpha(
                                                  (255 * 0.8).toInt()),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          activity['time']!,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      activity['description']!,
                                      style: TextStyle(
                                        color: Colors.black
                                            .withAlpha((255 * 0.6).toInt()),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
}
