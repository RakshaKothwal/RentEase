import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/view/chat.dart';
import 'package:rentease/view/dashboard.dart';
import 'package:rentease/view/details.dart';
import 'package:rentease/view/message.dart';
import 'package:rentease/view/profile.dart';
import 'package:rentease/view/saved.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => NavbarState();
}

class NavbarState extends State<Navbar> {
  final controller = PersistentTabController(initialIndex: 0);
  bool isNavBarVisible = true;

  void toggleNavBar(bool isVisible) {
    setState(() {
      isNavBarVisible = isVisible;
    });
  }

  List<Widget> screens() {
    return [Dashboard(), Saved(), Message(), Profile()];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: 26,
          ),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.bookmark_border,
            size: 26,
          ),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.messenger_outline,
            size: 26,
          ),
          title: '',
          activeColorPrimary: Color(0xffD32F2F),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.perm_identity,
            size: 26,
          ),
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
      hideNavigationBarWhenKeyboardAppears: true,
      navBarStyle: NavBarStyle.style8,
      navBarHeight: 50,
      padding: EdgeInsets.only(
        top: 12,
      ),
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
        // border:
        //     Border(top: BorderSide(color: Colors.grey.shade300, width: 0.4))
        // borderRadius: BorderRadius.only(
        //     topRight: Radius.circular(15), topLeft: Radius.circular(15))
      ),
    );
  }
}
