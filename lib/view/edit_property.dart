import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:rentease/view/owner_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../common/common_form.dart';
import '../common/global_widget.dart';
import '../models/property_listing.dart';
import 'list_property.dart';

class EditProperty extends StatelessWidget {
  final PropertyListing property;

  const EditProperty({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return ListProperty(property: property);
  }
} 
