import 'dart:io';

import 'package:flutter/material.dart';

class Contact {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  File? image;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.image,
  });
}

List<Contact> contacts = <Contact>[];

bool light = true;
