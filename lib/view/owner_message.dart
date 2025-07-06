import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/view/owner_chat.dart';
import 'package:rentease/services/chat_service.dart';
import 'package:rentease/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OwnerMessage extends StatefulWidget {
  const OwnerMessage({super.key});

  @override
  State<OwnerMessage> createState() => _OwnerMessageState();
}

class _OwnerMessageState extends State<OwnerMessage> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';


  Stream<int> _getUnreadCountForRoom(String roomId) {
    if (userId.isEmpty || roomId.isEmpty) {
      return Stream.value(0);
    }
    
    return _chatService.getMessages(roomId).map((messages) {

      return messages.where((message) => 
        message.receiverId == userId && !message.isRead
      ).length;
    });
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
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<ChatRoom>>(
              stream: _chatService.getChatRooms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading messages: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
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
                          'Messages from tenants will appear here',
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
                          screen: OwnerChat(
                            roomId: chatRoom.id,
                            otherUserId: otherUserId,
                            propertyTitle: chatRoom.propertyTitle,
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
                                StreamBuilder<int>(
                                  stream: _getUnreadCountForRoom(chatRoom.id),
                                  builder: (context, snapshot) {
                                    final unreadCount = snapshot.data ?? 0;
                                    return unreadCount > 0
                                        ? Container(
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
                                          )
                                        : SizedBox.shrink();
                                  },
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
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                );
              },
            ),
          ),
        ],
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
