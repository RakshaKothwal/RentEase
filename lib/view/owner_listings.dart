import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/models/property_listing.dart';
import 'owner_property_details.dart';
import 'edit_property.dart';

class OwnerListings extends StatefulWidget {
  const OwnerListings({super.key});

  @override
  State<OwnerListings> createState() => _OwnerListingsState();
}

class _OwnerListingsState extends State<OwnerListings> {
  bool isLoading = true;
  List<PropertyListing> propertyListings = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    loadPropertyListings();
  }

  Future<void> loadPropertyListings() async {
    try {
      final String userId = _auth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        commonToast('Please login to view your properties');
        return;
      }


      _firestore
          .collection('properties')
          .where('ownerId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        setState(() {
          propertyListings = snapshot.docs
              .map((doc) => PropertyListing.fromFirestore(doc.data(), doc.id))

              .toList();
          isLoading = false;
        });
      }, onError: (error) {
        print('Error in property stream: $error');
        commonToast('Failed to load properties. Please try again.');
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print('Error setting up property stream: $e');
      commonToast('Failed to load properties. Please try again.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteProperty(PropertyListing property) async {
    try {
      if (property.id == null) {
        commonToast('Cannot delete property: Invalid property ID');
        return;
      }

      await _firestore.collection('properties').doc(property.id).delete();
      setState(() {
        propertyListings.remove(property);
      });
      commonToast('Property deleted successfully');
    } catch (e) {
      print('Error deleting property: $e');
      commonToast('Failed to delete property. Please try again.');
    }
  }

  Future<void> togglePropertyStatus(PropertyListing property) async {
    try {
      if (property.id == null) {
        commonToast('Cannot update property: Invalid property ID');
        return;
      }

      final newStatus = !property.isActive;

      await _firestore.collection('properties').doc(property.id).update({
        'isActive': newStatus,
        'updatedAt': Timestamp.now(),
      });


      setState(() {
        property.isActive = newStatus;
      });

      commonToast(newStatus
          ? 'Property is now active and visible to tenants'
          : 'Property is now inactive and hidden from tenants');
    } catch (e) {
      print('Error updating property status: $e');
      commonToast('Failed to update property status. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: appbar(
        data: "My Listings",
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: Column(
          children: [
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : propertyListings.isEmpty
                    ? const Center(child: Text("No properties listed yet"))
                    : Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: propertyListings.length,
                          itemBuilder: (context, index) {
                            final property = propertyListings[index];
                            return GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: OwnerPropertyDetails(
                                        property: property),
                                    withNavBar: false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(12)),
                                          child: property.propertyImages !=
                                                      null &&
                                                      property.propertyImages!
                                                          .isNotEmpty
                                              ? property.propertyImages!.first
                                                      .startsWith('data:image')
                                                      ? Image.memory(
                                                      base64Decode(property
                                                          .propertyImages!.first
                                                          .split(',')[1]),
                                                      height: 200,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Image.asset(
                                                          "assets/images/room1.png",
                                                          height: 200,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    )
                                                  : property
                                                          .propertyImages!.first
                                                          .startsWith('http')
                                                      ? Image.network(
                                                          property
                                                              .propertyImages!
                                                              .first,
                                                          height: 200,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                              "assets/images/room1.png",
                                                              height: 200,
                                                              width: double
                                                                  .infinity,
                                                                  fit: BoxFit.cover,
                                                                );
                                                              },
                                                            )
                                                          : Image.file(
                                                              File(property
                                                                  .propertyImages!
                                                                  .first),
                                                              height: 200,
                                                          width:
                                                              double.infinity,
                                                              fit: BoxFit.cover,
                                                            )
                                                  : Image.asset(
                                                      "assets/images/room1.png",
                                                      height: 200,
                                                      width: double.infinity,
                                                      fit: BoxFit.fill,
                                                    ),
                                        ),
                                        Positioned(
                                          top: 12,
                                          right: 12,
                                          child: GestureDetector(
                                            onTap: () =>
                                                togglePropertyStatus(property),
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                            decoration: BoxDecoration(
                                              color: property.isActive
                                                  ? const Color(0xFF4CAF50)
                                                  : const Color(0xFFFFA000),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    property.isActive
                                                        ? Icons
                                                            .check_circle_outline
                                                        : Icons
                                                            .pause_circle_outline,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                              property.isActive
                                                  ? 'Active'
                                                  : 'Inactive',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  property.title ?? 'No Title',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                property.expectedRent != null
                                                    ? "₹${property.expectedRent}"
                                                    : "N/A",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFE31B23),
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on_outlined,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  "${property.city ?? 'N/A'}, ${property.state ?? 'N/A'}",
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              buildPropertyInfo(
                                                  Icons.remove_red_eye_outlined,
                                                  '0 views'),
                                              buildPropertyInfo(
                                                  Icons.message_outlined,
                                                  '0 responses'),
                                              buildPropertyInfo(
                                                  Icons.access_time,
                                                  property.createdAt != null
                                                      ? '${DateTime.now().difference(property.createdAt!).inDays} days ago'
                                                      : 'N/A'),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    PersistentNavBarNavigator
                                                        .pushNewScreen(
                                                      context,
                                                      screen: EditProperty(
                                                          property: property),
                                                      withNavBar: false,
                                                    );
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xFFE31B23)),
                                                  ),
                                                  child: const Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFE31B23)),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: ElevatedButton.icon(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        title: Row(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                        0xFFE31B23)
                                                                    .withOpacity(
                                                                        0.1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: const Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color: Color(
                                                                    0xFFE31B23),
                                                                size: 24,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 12),
                                                            const Expanded(
                                                              child: Text(
                                                                'Delete Property',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0xFF2A2B3F),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'Are you sure you want to delete this property?',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF757575),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Text(
                                                              'This action cannot be undone.',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .grey[500],
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    OutlinedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                                  style: OutlinedButton
                                                                      .styleFrom(
                                                                    side: const BorderSide(
                                                                        color: Color(
                                                                            0xFFE0E0E0)),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    'Cancel',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF757575),
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 12),
                                                              Expanded(
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                              Navigator.pop(
                                                                  context);
                                                              deleteProperty(
                                                                  property);
                                                            },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xFFE31B23),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    'Delete',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                        actionsPadding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                24, 0, 24, 24),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white),
                                                  label: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFE31B23),
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
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget buildPropertyInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF757575)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF757575),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
