import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/contact_models.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _picker = ImagePicker();
  String? image;

  final GlobalKey<FormState> _addContactFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? firstName;
  String? lastName;
  String? phone;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
      appBar: AppBar(
        backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
        elevation: 0,
        title: Text(
          'Create contact',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        actions: [
          Transform.scale(
            scale: 0.65,
            child: InkWell(
              onTap: () {
                validateAndSubmit();
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  width: 130,
                  alignment: Alignment.center,
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: const BoxDecoration(
                          color: Color(0xffeef2fb),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'Add photo',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              const SizedBox(height: 35),
                              GestureDetector(
                                onTap: () async {
                                  XFile? xfile = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    image = xfile!.path;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Take photo',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 35),
                              GestureDetector(
                                onTap: () async {
                                  XFile? xfile = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    image = xfile!.path;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Choose photo',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue.shade900,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xffe3D3fd),
                backgroundImage: (image != null)
                    ? FileImage(File(image!))
                    : null,
                child: (image == null)
                    ? Image.asset(
                        'assets/image/add-photo.png',
                        scale: 3,
                      )
                    : Container(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Add Photo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _addContactFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _firstNameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your first name...';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          firstName = val;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Image.asset(
                          'assets/image/avatar.png',
                          scale: 5,
                          color: Theme.of(context).textTheme.displayLarge?.color,
                        ),
                        label: const Text('First Name'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff0c58cf), width: 2),
                        ),
                        border: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _lastNameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your last name...';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          lastName = val;
                        });
                      },
                      decoration: InputDecoration(
                        label: const Text('Last Name'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff0c58cf), width: 2),
                        ),
                        border: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your phone...';
                        } else if (val.length != 10) {
                          return 'Phone number is invalid...';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          phone = val;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Image.asset(
                          'assets/image/phone-call (4).png',
                          scale: 2.5,
                          color: Theme.of(context).textTheme.displayLarge?.color,
                        ),
                        label: const Text('Phone'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff0c58cf), width: 2),
                        ),
                        border: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your email...';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Image.asset(
                          'assets/image/email.png',
                          scale: 2.5,
                          color: Theme.of(context).textTheme.displayLarge?.color,
                        ),
                        label: const Text('Email'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff0c58cf), width: 2),
                        ),
                        border: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateAndSubmit() {
    if (_addContactFormKey.currentState!.validate()) {
      _addContactFormKey.currentState!.save();

      Contact myContact = Contact(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        image: (image != null) ? File(image!) : null,
      );

      contacts.add(myContact);

      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }
}
