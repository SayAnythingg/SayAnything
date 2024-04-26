import 'dart:async';


import 'package:SayAnything/screens/fade_animationtest.dart';
import 'package:SayAnything/screens/login_page.dart';
import 'package:SayAnything/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
/*
import 'package:SayAnything/screens/edit_description.dart';
*/
import 'package:SayAnything/screens/edit_name.dart';
import 'package:SayAnything/services/Model.dart';

import 'package:SayAnything/widgets/sideMenu.dart';


class Profile extends StatefulWidget {
  
   final User user;
  
   Profile({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  
  @override
  Widget build(BuildContext context) {
  
     return Scaffold(
      endDrawer: SideMenu(user: widget.user), // Add this line
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
          ),
        ),
        child: Column(
          children: [
            AppBar(
                title: Text('Profile'),
                backgroundColor: Colors.transparent, 
                elevation: 0, 
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.person,
                size: 100, 
                color: widget.user.gender == 'Male' ? Colors.blue : (widget.user.gender == 'Female' ? Colors.pink : Colors.grey),
              ),
            buildUserInfoDisplay(widget.user.name, 'Name', EditNameFormPage()),
            buildUserInfoDisplay(widget.user.email, 'Email', null),
            Expanded(
              child: buildAbout(widget.user),
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget? editPage) =>
    Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                child: Row(children: [
                  Expanded(
                      child: TextButton(
                          onPressed: editPage != null
                              ? () {
                                  navigateSecondPage(editPage);
                                }
                              : null,
                          child: Text(
                            getValue,
                            style: TextStyle(fontSize: 16, height: 1.4),
                          ))),
                  if (editPage != null) // if editPage is not null, show the arrow icon
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                ]))
          ],
        ));

  Widget buildAbout(User user) => Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 1),
        Container(
            width: 350,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                )),
            child: Row(children: [
              Expanded(
                  child: TextButton(
                      onPressed: () {
                        navigateSecondPage(EditDescriptionFormPage());
                      },
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 10, 10, 10), // Adjust left padding here
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                user.aboutMeDescription,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                ),
                              ))))),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 40.0,
              )
            ])),
            */
        SizedBox(height: 20.0), // Add space above the Logout button
        Container(
          width: 350,
          child: FadeInAnimation(
            delay: 2.7,
            child: CustomElevatedButton(
              message: "Logout",
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              color: Color(0xFF7EC4CF),
            ),
          ),
        ),
      ],
    ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}