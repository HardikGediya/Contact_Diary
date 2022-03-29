import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


import '../models/contact_models.dart';

class ContactsDetails extends StatefulWidget {
  const ContactsDetails({Key? key}) : super(key: key);

  @override
  _ContactsDetailsState createState() => _ContactsDetailsState();
}

class _ContactsDetailsState extends State<ContactsDetails> {
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
      appBar: AppBar(
        backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                light = !light;
              });
            },
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey.shade300,
              child:  CircleAvatar(
                radius: 12,
                backgroundColor: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Transform.scale(
              scale: 0.9,
              child: Image.asset(
                'assets/image/bin.png',
                color:
                Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            onPressed: () {
              contacts.remove(args);

              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.36,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (args.image != null)
                      ? FileImage(args.image)
                      : (light)
                          ? const AssetImage(
                              'assets/image/man (3).png',
                            )
                          : const AssetImage(
                              'assets/image/man (3).png',
                            ) as ImageProvider,
                  fit: (args.image != null) ? BoxFit.cover : null,
                ),
              ),
            ),
            const SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                '${args.firstName} ${args.lastName}',
                style: TextStyle(
                  fontSize: 27,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey.shade300, thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Transform.rotate(
                          angle: pi / -2.0,
                          child: Transform.scale(
                            scale: 0.85,
                            child: Image.asset(
                              'assets/image/icons8-call-96.png',
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          // indirect Call using url_launcher: ^6.0.20
                          // String url = 'tel:+91${contacts[i].phone}';
                          // await launch(url);

                          // direct Call using flutter_phone_direct_caller: ^2.1.0

                          await FlutterPhoneDirectCaller.callNumber(
                              '+91${args.phone}');
                        },
                      ),
                      Text(
                        'Call',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Transform.scale(
                          scale: 0.8,
                          child: Image.asset(
                            'assets/image/comment (1).png',
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                        onPressed: () async {
                            await launch('sms:+91'+ args.phone);
                        },
                      ),
                      Text(
                        'Text',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Transform.scale(
                          scale: 0.8,
                          child: Image.asset(
                            'assets/image/email.png',
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                        onPressed: () async {
                          await launch('mailto:'+ args.email);
                        },
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Transform.scale(
                          scale: 0.75,
                          child: Image.asset(
                            'assets/image/share (1).png',
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                        onPressed: () async{
                          await Share.share('${args.firstName} ${args.lastName} : ${args.phone}');
                        },
                      ),
                      Text(
                        'Share',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade300, thickness: 1),
            ListTile(
              leading: IconButton(
                icon: Transform.rotate(
                  angle: pi / -2.0,
                  child: Transform.scale(
                    scale: 0.9,
                    child: Image.asset(
                      'assets/image/icons8-call-96.png',
                      color: Theme.of(context).textTheme.displayLarge?.color,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
              title: Text('+91 '  '${args.phone}'),
              subtitle: const Text('Mobile'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Divider(color: Colors.grey.shade300, thickness: 1),
            ),
            ListTile(
              leading: IconButton(
                icon: Transform.scale(
                  scale: 0.85,
                  child: Image.asset(
                    'assets/image/email.png',
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
                onPressed: () {},
              ),
              title: Text('${args.email}'),
              subtitle: const Text('Home'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Divider(color: Colors.grey.shade300, thickness: 1),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        icon: Icon(
          Icons.edit,
          color: Theme.of(context).textTheme.bodySmall?.color,
          size: 24.0,
        ),
        label: Text(
          'Edit Contact',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
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
          Navigator.of(context).pushNamed('edit_contact_page',arguments: args);
        },
      ),
    );
  }
}
