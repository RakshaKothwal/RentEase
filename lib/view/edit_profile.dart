import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/global_widget.dart';
import 'navbar.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const EditProfile({super.key, this.userData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? profileImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _prefillFormData();
  }

  void _prefillFormData() {
    if (widget.userData != null) {
      _nameController.text =
          widget.userData!['fullName'] ?? widget.userData!['name'] ?? '';
      _phoneController.text = widget.userData!['phone'] ?? '';
      _emailController.text = widget.userData!['email'] ?? '';
      _profileImageUrl = widget.userData!['profileImage'];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          appbar(data: "Edit Profile", showBackArrow: true, context: context),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: horizontalPadding,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: CircleAvatar(
                        maxRadius: 50,
                        minRadius: 50,
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : _profileImageUrl != null
                                ? NetworkImage(_profileImageUrl!)
                                : AssetImage("assets/images/profile4.png")
                                    as ImageProvider),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        customBottomSheet(
                          context: context,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Center(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.grey.shade400,
                                          size: 22,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "Profile Photo ",
                                          style: TextStyle(
                                            color: Color(
                                              0xff2A2B3F,
                                            ),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      profileImage != null
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                                primaryDialogBox(
                                                    context: context,
                                                    title: Text(
                                                        "Remove profile photo"),
                                                    contentText:
                                                        "Are you sure you want to remove the profile photo?",
                                                    successText: "Remove",
                                                    successTap: () {
                                                      setState(() {
                                                        profileImage = null;
                                                      });
                                                      Navigator.pop(context);
                                                      commonToast(
                                                          "Profile photo removed");
                                                    },
                                                    unsuccessText: "Cancel");
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.grey.shade400,
                                                size: 22,
                                              ),
                                            )
                                          : SizedBox.shrink()
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final pickedImage =
                                                  await ImagePicker().pickImage(
                                                maxWidth: 600,
                                                maxHeight: 600,
                                                source: ImageSource.camera,
                                              );

                                              if (pickedImage != null) {
                                                setState(() {
                                                  profileImage =
                                                      File(pickedImage.path);
                                                });
                                                commonToast(
                                                    "Profile Photo successfully added");
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade300)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 12),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Color(
                                                      0xffD32F2F,
                                                    ),
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "Camera",
                                            style: TextStyle(
                                                color: Color(0xffA1A0A0),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                fontFamily: 'Poppins'),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final pickedImage =
                                                  await ImagePicker().pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (pickedImage != null) {
                                                setState(() {
                                                  profileImage =
                                                      File(pickedImage.path);
                                                });
                                                commonToast(
                                                    "Profile Photo successfully added");
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade300)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 12),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.photo_library,
                                                    color: Color(
                                                      0xffD32F2F,
                                                    ),
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(
                                                color: Color(0xffA1A0A0),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                fontFamily: 'Poppins'),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ))),
                        );
                      },
                      child: Center(
                          child: Text(
                        profileImage != null
                            ? "Change profile photo"
                            : "Add profile photo",
                        style: TextStyle(
                            color: Color(0xffD32F2F),
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ))),
                  SizedBox(
                    height: 35,
                  ),
                  label("Full Name"),
                  input(
                      controller: _nameController,
                      hintText: "Enter your full name"),
                  SizedBox(
                    height: 10,
                  ),
                  label("Phone Number"),
                  input(
                      controller: _phoneController,
                      hintText: "Enter your phone number"),
                  SizedBox(
                    height: 10,
                  ),
                  label("Email"),
                  input(
                      controller: _emailController,
                      hintText: "Enter your email"),
                  SizedBox(
                    height: 20,
                  ),
                  submit(
                    data: "Save Changes",
                    onPressed: () {},
                    width: double.infinity,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
