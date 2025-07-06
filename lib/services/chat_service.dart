import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  String get currentUserId => _auth.currentUser?.uid ?? '';


  Future<String> createOrGetChatRoom(String otherUserId, {String? propertyId, String? propertyTitle}) async {
    if (currentUserId.isEmpty) {
      throw Exception('User not authenticated');
    }
    
    if (otherUserId.isEmpty) {
      throw Exception('Invalid receiver ID');
    }
    
    final userId1 = currentUserId;
    final userId2 = otherUserId;
    

    final sortedIds = [userId1, userId2]..sort();
    final roomId = '${sortedIds[0]}_${sortedIds[1]}';
    
    try {

      final roomDoc = await _firestore.collection('chatRooms').doc(roomId).get();
      
      if (!roomDoc.exists) {

        await _firestore.collection('chatRooms').doc(roomId).set({
          'user1Id': sortedIds[0],
          'user2Id': sortedIds[1],
          'propertyId': propertyId,
          'propertyTitle': propertyTitle,
          'lastMessageTime': FieldValue.serverTimestamp(),
          'lastMessage': '',
          'unreadCount': 0,
          'user1Name': '',
          'user2Name': '',
        });
      }
      
      return roomId;
    } catch (e) {
      throw Exception('Failed to create chat room: $e');
    }
  }


  Future<void> sendMessage(String receiverId, String message, {String? propertyId, String? propertyTitle}) async {
    if (currentUserId.isEmpty) {
      throw Exception('User not authenticated');
    }
    
    if (receiverId.isEmpty) {
      throw Exception('Invalid receiver ID');
    }
    
    if (message.trim().isEmpty) {
      throw Exception('Message cannot be empty');
    }
    
    try {
      final roomId = await createOrGetChatRoom(receiverId, propertyId: propertyId, propertyTitle: propertyTitle);
      

      await _firestore
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .add({
        'senderId': currentUserId,
        'receiverId': receiverId,
        'message': message.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': true, // Mark as read since sender is current user
        'propertyId': propertyId,
        'propertyTitle': propertyTitle,
      });



      await _firestore.collection('chatRooms').doc(roomId).update({
        'lastMessage': message.trim(),
        'lastMessageTime': FieldValue.serverTimestamp(),


        'unreadCount': FieldValue.increment(receiverId == currentUserId ? 0 : 1),
      });
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }


  Stream<List<ChatMessage>> getMessages(String roomId) {
    if (roomId.isEmpty) {
      return Stream.value([]);
    }
    
    return _firestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromFirestore(doc.data(), doc.id))
            .toList())
        .handleError((error) {
          print('Error getting messages: $error');
          return <ChatMessage>[];
        });
  }


  Stream<List<ChatRoom>> getChatRooms() {
    if (currentUserId.isEmpty) {
      print('ChatService: User not authenticated, returning empty list');
      return Stream.value([]);
    }
    
    print('ChatService: Getting chat rooms for user: $currentUserId');
    
    return _firestore
        .collection('chatRooms')
        .where('user1Id', isEqualTo: currentUserId)
        .snapshots()
        .asyncMap((snapshot) async {
      print('ChatService: Found ${snapshot.docs.length} rooms where user is user1');
      List<ChatRoom> rooms = [];
      for (var doc in snapshot.docs) {
        try {
          rooms.add(ChatRoom.fromFirestore(doc.data(), doc.id));
        } catch (e) {
          print('ChatService: Error parsing room ${doc.id}: $e');
        }
      }
      

      try {
        final user2Snapshot = await _firestore
            .collection('chatRooms')
            .where('user2Id', isEqualTo: currentUserId)
            .get();
        
        print('ChatService: Found ${user2Snapshot.docs.length} rooms where user is user2');
        
        for (var doc in user2Snapshot.docs) {
          try {
            rooms.add(ChatRoom.fromFirestore(doc.data(), doc.id));
          } catch (e) {
            print('ChatService: Error parsing room ${doc.id}: $e');
          }
        }
      } catch (e) {
        print('ChatService: Error getting user2 rooms: $e');
      }
      

      rooms.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
      print('ChatService: Returning ${rooms.length} total rooms');
      return rooms;
    }).handleError((error) {
      print('ChatService: Error getting chat rooms: $error');
      return <ChatRoom>[];
    });
  }


  Future<void> markMessagesAsRead(String roomId) async {
    if (currentUserId.isEmpty || roomId.isEmpty) {
      return;
    }
    
    try {
      final batch = _firestore.batch();
      

      final unreadMessages = await _firestore
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .where('receiverId', isEqualTo: currentUserId)
          .where('isRead', isEqualTo: false)
          .get();
      

      for (var doc in unreadMessages.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      

      batch.update(
        _firestore.collection('chatRooms').doc(roomId),
        {'unreadCount': 0},
      );
      
      await batch.commit();
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }


  Stream<int> getUnreadCount() {
    if (currentUserId.isEmpty) {
      return Stream.value(0);
    }

    return _firestore
        .collection('chatRooms')
        .where('participants', arrayContains: currentUserId)
        .snapshots()
        .asyncMap((snapshot) async {
      int totalUnread = 0;
      for (var doc in snapshot.docs) {
        final roomId = doc.id;

        final unreadMessages = await _firestore
            .collection('chatRooms')
            .doc(roomId)
            .collection('messages')
            .where('receiverId', isEqualTo: currentUserId)
            .where('isRead', isEqualTo: false)
            .get();
        totalUnread += unreadMessages.docs.length;
      }
      return totalUnread;
    }).handleError((error) {
      print('Error getting unread count: $error');
      return 0;
    });
  }


  String getOtherUserId(ChatRoom room) {
    return room.user1Id == currentUserId ? room.user2Id : room.user1Id;
  }


  String getOtherUserName(ChatRoom room) {
    return room.user1Id == currentUserId ? (room.user2Name ?? 'Unknown') : (room.user1Name ?? 'Unknown');
  }
} 
