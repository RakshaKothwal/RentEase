import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/view/dashboard.dart';
import 'package:rentease/view/details.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> screens() {
    return [Dashboard(), Details(), Container(), Container()];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: 24,
          ),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person,
            size: 24,
          ),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.bookmark,
            size: 24,
          ),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.bookmark_border,
            size: 24,
          ),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.grey)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: screens(),
      items: navBarItems(),
      navBarStyle: NavBarStyle.style8,
      navBarHeight: 50,
      padding: EdgeInsets.only(top: 15),
      backgroundColor: Color(0xffFFFFFF),
      decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: 0)
          ],
          // colorBehindNavBar:,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
    );
  }
}
