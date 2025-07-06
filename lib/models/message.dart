import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? propertyId;
  final String? propertyTitle;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.propertyId,
    this.propertyTitle,
  });

  factory ChatMessage.fromFirestore(Map<String, dynamic> data, String docId) {
    return ChatMessage(
      id: docId,
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRead: data['isRead'] ?? false,
      propertyId: data['propertyId'],
      propertyTitle: data['propertyTitle'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
    };
  }
}

class ChatRoom {
  final String id;
  final String user1Id;
  final String user2Id;
  final String? propertyId;
  final String? propertyTitle;
  final DateTime lastMessageTime;
  final String lastMessage;
  final int unreadCount;
  final String? user1Name;
  final String? user2Name;

  ChatRoom({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    this.propertyId,
    this.propertyTitle,
    required this.lastMessageTime,
    required this.lastMessage,
    this.unreadCount = 0,
    this.user1Name,
    this.user2Name,
  });

  factory ChatRoom.fromFirestore(Map<String, dynamic> data, String docId) {
    final unreadCount = data['unreadCount'];
    return ChatRoom(
      id: docId,
      user1Id: data['user1Id'] ?? '',
      user2Id: data['user2Id'] ?? '',
      propertyId: data['propertyId'],
      propertyTitle: data['propertyTitle'],
      lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastMessage: data['lastMessage'] ?? '',
      unreadCount: unreadCount != null ? (unreadCount as num).toInt() : 0,
      user1Name: data['user1Name'],
      user2Name: data['user2Name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'user1Id': user1Id,
      'user2Id': user2Id,
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'lastMessage': lastMessage,
      'unreadCount': unreadCount,
      'user1Name': user1Name,
      'user2Name': user2Name,
    };
  }
} 
