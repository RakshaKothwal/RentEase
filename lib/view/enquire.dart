import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentease/common/global_widget.dart';
import 'package:rentease/services/chat_service.dart';
import 'package:rentease/view/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Enquire extends StatefulWidget {
  final String? propertyId;
  final String? propertyTitle;
  final String? ownerId;

  const Enquire({
    super.key,
    this.propertyId,
    this.propertyTitle,
    this.ownerId,
  });

  @override
  State<Enquire> createState() => _EnquireState();
}

class _EnquireState extends State<Enquire> {
  String selectedMessage = "chat";
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  String get currentUserId => _auth.currentUser?.uid ?? '';

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendEnquiry() async {
    if (currentUserId.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please login to send an enquiry'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget.ownerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Owner information not available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String message = '';

      switch (selectedMessage) {
        case 'chat':
          message = _messageController.text.trim().isNotEmpty
              ? _messageController.text.trim()
              : 'Hi! I\'m interested in this property. Can you tell me more about it?';
          break;
        case 'visit':
          message =
              'I would like to schedule a visit to see this property. When would be convenient for you?';
          break;
        case 'callback':
          message =
              'I\'m interested in this property. Could you please call me back to discuss the details?';
          break;
      }


      await _chatService.sendMessage(
        widget.ownerId!,
        message,
        propertyId: widget.propertyId,
        propertyTitle: widget.propertyTitle,
      );


      if (mounted) {
        Navigator.pop(context);
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send enquiry: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/tick.svg",
                  colorFilter:
                      ColorFilter.mode(Color(0xffD32F2F), BlendMode.srcIn),
                ),
                SizedBox(height: 15),
                Text(
                  "Enquiry Sent!",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    fontSize: 16,
                    letterSpacing: 0,
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    "Your message has been sent to the property owner.",
                    style: TextStyle(
                      color: Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 12,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    "You can continue the conversation in the Messages tab.",
                    style: TextStyle(
                      color: Color(0xff000000).withAlpha((255 * 0.8).toInt()),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 12,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD32F2F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar:
          appbar(data: "Enquire Now", showBackArrow: true, context: context),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Send a message to the owner",
                  style: TextStyle(
                    color: Colors.black.withAlpha((255 * 0.8).toInt()),
                    fontSize: 16,
                    letterSpacing: 0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "By continuing, you're letting the owner know you're genuinely interested in this property. Please choose your preferred contact method and add any additional details below.",
                  style: TextStyle(
                    color: Color(0xff919191),
                    fontSize: 10,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                enquiryOption(
                  label: "Direct chat",
                  value: 'chat',
                  groupValue: selectedMessage,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMessage = value!;
                    });
                  },
                ),
                enquiryOption(
                  label: "Schedule a visit",
                  value: 'visit',
                  groupValue: selectedMessage,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMessage = value!;
                    });
                  },
                ),
                enquiryOption(
                  label: "Request a callback",
                  value: 'callback',
                  groupValue: selectedMessage,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMessage = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                if (selectedMessage == 'chat')
                  TextFormField(
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
                      contentPadding: EdgeInsets.only(bottom: -30),
                      hintText: "Write your message here if any ...",
                      hintStyle: TextStyle(
                        color: Color(0xffB2B2B2),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withAlpha((255 * 0.6).toInt()),
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withAlpha((255 * 0.6).toInt()),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withAlpha((255 * 0.6).toInt()),
                        ),
                      ),
                    ),
                    maxLines: 3,
                  ),
                SizedBox(height: 12),
                Text(
                  "By sending your enquiry, you agree to communicate exclusively through our secure chat system with the property owner.",
                  style: TextStyle(
                    color: Color(0xff919191),
                    letterSpacing: 0,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 26),
                submit(
                  data: _isLoading ? "Sending..." : "Send",
                  onPressed: _isLoading ? null : _sendEnquiry,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
