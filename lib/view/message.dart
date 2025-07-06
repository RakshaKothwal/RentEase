import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/chat.dart';
import 'package:rentease/services/chat_service.dart';
import 'package:rentease/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isTimedOut = false;
  Timer? _timeoutTimer;

  String get userId => _auth.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();

    _timeoutTimer = Timer(Duration(seconds: 15), () {
      if (mounted) {
        setState(() {
          _isTimedOut = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (userId.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(data: "Messages"),
        body: Center(
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
                'Please login to view messages',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(data: "Messages"),
      body: Expanded(
        child: StreamBuilder<List<ChatRoom>>(
          stream: _chatService.getChatRooms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              if (_isTimedOut) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
        children: [
                      Icon(
                        Icons.timer_off,
                        size: 64,
                        color: Colors.orange[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading timeout',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange[600],
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Check your internet connection',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isTimedOut = false;
                            _timeoutTimer = Timer(Duration(seconds: 15), () {
                              if (mounted) {
                                setState(() {
                                  _isTimedOut = true;
                                });
                              }
                            });
                          });
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Loading messages...',
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
                      'Error loading messages',
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
            
            final chatRooms = snapshot.data ?? [];
            
            if (chatRooms.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No messages yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start a conversation by enquiring about a property',
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
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                final otherUserId = _chatService.getOtherUserId(chatRoom);
                final otherUserName = _chatService.getOtherUserName(chatRoom);
                final displayName = chatRoom.propertyTitle ?? otherUserName;
                
                return GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: Chat(
                        roomId: chatRoom.id,
                        otherUserId: otherUserId,
                        otherUserName: otherUserName,
                      ),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                        child: Row(
                          children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey.shade600,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                displayName,
                                    style: TextStyle(
                                  fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                  ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                  ),
                              SizedBox(height: 4),
                                  Text(
                                chatRoom.lastMessage,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontFamily: "Poppins",
                                ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('chatRooms')
                                  .doc(chatRoom.id)
                                  .collection('messages')
                                  .where('receiverId', isEqualTo: _chatService.currentUserId)
                                  .where('isRead', isEqualTo: false)
                                  .snapshots(),
                              builder: (context, unreadSnapshot) {
                                final unreadCount = unreadSnapshot.data?.docs.length ?? 0;
                                return Column(
                                  children: [
                                    if (unreadCount > 0)
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Color(0xffD32F2F),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          unreadCount.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    SizedBox(height: 8),
                                    Text(
                                      _getTimeAgo(chatRoom.lastMessageTime),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                          ],
                        ),
                      ),
                    );
                  },
              separatorBuilder: (context, index) => SizedBox(height: 20),
            );
          },
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
