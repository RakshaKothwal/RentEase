import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/view/owner_message.dart';
import 'package:rentease/view/owner_dashboard.dart';

import 'package:rentease/view/owner_bookings.dart';
import 'package:rentease/view/owner_enquiries_list.dart';
import 'package:rentease/view/owner_profile.dart';
import 'package:rentease/view/profile.dart';
import 'package:rentease/services/chat_service.dart';

import 'owner_listings.dart';

class OwnerNavbar extends StatefulWidget {
  final int initialIndex;

  const OwnerNavbar({super.key, this.initialIndex = 0});


  @override
  State<OwnerNavbar> createState() => OwnerNavbarState();
}

class OwnerNavbarState extends State<OwnerNavbar> {
  late PersistentTabController controller;
  final ChatService _chatService = ChatService();

  bool isNavBarVisible = true;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: widget.initialIndex);
  }

  void toggleNavBar(bool isVisible) {
    setState(() {
      isNavBarVisible = isVisible;
    });
  }

  List<Widget> screens() {
    return [OwnerDashboard(), OwnerListings(), OwnerMessage(), OwnerProfile()];
  }

  void switchToTab(int index) {
    controller.index = index;
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.dashboard, size: 26),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home_work_outlined, size: 26),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: StreamBuilder<int>(
            stream: _chatService.getUnreadCount(),
            builder: (context, snapshot) {
              final unreadCount = snapshot.data ?? 0;
              return Stack(
                children: [
                  Icon(Icons.chat_bubble_outline, size: 26),
                  if (unreadCount > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xffD32F2F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : unreadCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.perm_identity, size: 26),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: screens(),
      items: navBarItems(),
      stateManagement: false,
      hideNavigationBarWhenKeyboardAppears: true,
      navBarStyle: NavBarStyle.style8,
      navBarHeight: 50,
      padding: EdgeInsets.only(top: 12),
      isVisible: isNavBarVisible,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha((255 * 0.2).toInt()),
              blurRadius: 10,
              spreadRadius: 0)
        ],
        colorBehindNavBar: Colors.white,
      ),
    );
  }
}
