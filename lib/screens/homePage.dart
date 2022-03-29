import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/material.dart';

import '../models/contact_models.dart';
import 'add_ContactPage.dart';
import 'contact_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
        title: Text(
          'Contact',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        centerTitle: true,
        leading: Container(),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                light = !light;
              });
            },
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey.shade300,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
      body: (contacts.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/packet.png',
                    scale: 7,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  const Text(
                    'You have no contact yet.',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: contacts.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('contacts_details', arguments: contacts[i]);
                  },
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: (contacts[i].image != null)
                        ? FileImage(contacts[i].image!)
                        : (light)
                            ? const AssetImage(
                                'assets/image/man (3).png',
                              )
                            : const AssetImage(
                                'assets/image/man (3).png',
                              ) as ImageProvider,
                    backgroundColor:
                        Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  title: Text(
                    '${contacts[i].firstName} ${contacts[i].lastName}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  subtitle: Text(
                    'Mobile +91 ${contacts[i].phone}',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Transform.rotate(
                      angle: pi / -2.0,
                      child: Transform.scale(
                        scale: 0.9,
                        child: Image.asset(
                          'assets/image/icons8-call-96.png',
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      // indirect Call using url_launcher: ^6.0.20
                      // String url = 'tel:+91${contacts[i].phone}';
                      // await launch(url);

                      // direct Call using flutter_phone_direct_caller: ^2.1.0

                      await FlutterPhoneDirectCaller.callNumber(
                          '+91${contacts[i].phone}');
                    },
                  ),
                );
              },
            ),
      floatingActionButton: ElevatedButton.icon(
        icon: Icon(
          Icons.contacts,
          color: Theme.of(context).textTheme.bodySmall?.color,
          size: 24.0,
        ),
        label: Text(
          'Add Contact',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodySmall?.color),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(5),
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).textTheme.bodyLarge?.color as Color),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('add_contact_page');
        },
      ),
    );
  }
}
