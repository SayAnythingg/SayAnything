import 'package:SayAnything/screens/News_page.dart';
import 'package:SayAnything/screens/PrivacyPolicy_Page.dart';
import 'package:SayAnything/screens/SayAnything.dart';
import 'package:SayAnything/screens/aboutus_page.dart';
import 'package:SayAnything/screens/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:SayAnything/screens/edit_name.dart';
import 'package:SayAnything/services/Model.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  final User user;

  SideMenu({required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF7EC4CF),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 70,
                  left: 10,
                  child: Text(user.name, style: TextStyle(color: Colors.white)),
                ),
                Positioned(
                  top: 90,
                  left: 10,
                  child: Text('ID: ${user.userId}',
                      style: TextStyle(color: Colors.white)),
                ),
                Positioned(
                  top: 110,
                  left: 10,
                  child:
                      Text(user.email, style: TextStyle(color: Colors.white)),
                ),
                Positioned(
                  top: 10,
                  right: 170,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditNameFormPage()),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 190,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: user.gender == 'Male'
                          ? Colors.blue
                          : (user.gender == 'Female'
                              ? Colors.pink
                              : Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.info, color: Color(0xFF7EC4CF)),
            title: Text('Privacy Policy',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PrivacyPolicyPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.fiber_new, color: Color(0xFF7EC4CF)),
            title: Text('News', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Color(0xFF7EC4CF)),
            title: Text('About Us', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Aboutus()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Color(0xFF7EC4CF)),
            title: Text('Settings', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Color(0xFF7EC4CF)),
            title: Text('Logout', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                text: 'Do you want to logout',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                confirmBtnColor: Colors.green,
                onConfirmBtnTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Sayanything()),
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Color(0xFF7EC4CF)),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Copyright © SayAnything',
              style: TextStyle(color: Color(0xFF7EC4CF)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
