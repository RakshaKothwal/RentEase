import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/view/message.dart';
import 'package:rentease/view/owner_dashboard.dart';
// import 'package:rentease/view/owner_properties.dart';
import 'package:rentease/view/owner_bookings.dart';
import 'package:rentease/view/owner_enquiries_list.dart';
import 'package:rentease/view/profile.dart';

import 'owner_listings.dart';

class OwnerNavbar extends StatefulWidget {
  final int initialIndex;

  const OwnerNavbar({super.key, this.initialIndex = 0});
  // const OwnerNavbar({super.key});

  @override
  State<OwnerNavbar> createState() => OwnerNavbarState();
}

class OwnerNavbarState extends State<OwnerNavbar> {
  late PersistentTabController controller;
  //final controller = PersistentTabController(initialIndex: 0);
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
    return [OwnerDashboard(), OwnerListings(), Message(), Profile()];
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
          icon: Icon(Icons.chat_bubble_outline, size: 26),
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
