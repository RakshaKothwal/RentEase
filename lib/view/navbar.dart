import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/view/chat.dart';
import 'package:rentease/view/dashboard.dart';
import 'package:rentease/view/details.dart';
import 'package:rentease/view/message.dart';
import 'package:rentease/view/profile.dart';
import 'package:rentease/view/saved.dart';
import 'package:rentease/services/chat_service.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => NavbarState();
}

class NavbarState extends State<Navbar> {
  final controller = PersistentTabController(initialIndex: 0);
  final ChatService _chatService = ChatService();
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
          icon: StreamBuilder<int>(
            stream: _chatService.getUnreadCount(),
            builder: (context, snapshot) {
              final unreadCount = snapshot.data ?? 0;
              return Stack(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 26,
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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




      ),
    );
  }
}
