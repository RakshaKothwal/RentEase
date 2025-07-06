import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/services/chat_service.dart';
import 'package:rentease/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OwnerChat extends StatefulWidget {
  final String roomId;
  final String otherUserId;
  final String? propertyTitle;

  const OwnerChat({
    super.key,
    required this.roomId,
    required this.otherUserId,
    this.propertyTitle,
  });

  @override
  State<OwnerChat> createState() => _OwnerChatState();
}

class _OwnerChatState extends State<OwnerChat> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String get currentUserId => _auth.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatService.markMessagesAsRead(widget.roomId);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _chatService.sendMessage(
        widget.otherUserId,
        message,
        propertyId: null,
        propertyTitle: widget.propertyTitle,
      );
      _messageController.clear();
      

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: appbar(
        showBackArrow: true,
        context: context,
        data: widget.propertyTitle ?? "Chat with Tenant",
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatService.getMessages(widget.roomId),
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
                
                final messages = snapshot.data ?? [];
                
                if (messages.isEmpty) {
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
                          'Wait for tenant to send a message',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                return ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderId == currentUserId;
                      
                      return Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75,
                            ),
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isMe ? Color(0xffD32F2F) : Color(0xffF5F5F5),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(isMe ? 0 : 16),
                                bottomLeft: Radius.circular(isMe ? 16 : 0),
                              ),
                            ),
                            child: Text(
                              message.message,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _formatTime(message.timestamp),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: "Poppins",
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 2),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withAlpha((255 * 0.08).toInt()),
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(-1, -1),
                ),
              ],
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    cursorColor: Color(0xffD32F2F),
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      hintText: "Write message ...",
                      hintStyle: TextStyle(
                        color: Color(0xffB2B2B2),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      filled: true,
                      fillColor: Color(0xffF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    onFieldSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 16, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffD32F2F),
                    ),
                    child: Icon(
                      Icons.send,
                      size: 22,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(Duration(days: 1))) {
      return 'Yesterday ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
} 
