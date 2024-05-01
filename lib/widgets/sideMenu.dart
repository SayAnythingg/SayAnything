import 'package:SayAnything/screens/SayAnything.dart';
import 'package:SayAnything/screens/aboutus_page.dart';
import 'package:flutter/material.dart';
import 'package:SayAnything/screens/edit_name.dart';
import 'package:SayAnything/services/Model.dart';
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
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF7EC4CF),
              ),
              accountName: Row(
                children: [
                  Text(user.name, style: TextStyle(color: Colors.white)),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded, size: 16),  // Reduce the size of the icon
                    padding: EdgeInsets.all(16),  // Increase the clickable area
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditNameFormPage()),
                      );
                    },
                  ),
                ],
              ),
              accountEmail: Text(user.email, style: TextStyle(color: Colors.white)),
              currentAccountPicture: Icon(
                Icons.person,
                size: 80,  // Adjust the size to fit within the CircleAvatar
                color: user.gender == 'Male' ? Colors.blue : (user.gender == 'Female' ? Colors.pink : Colors.grey),
              ),
            ),
          ListTile(
            leading: Icon(Icons.info, color: Color(0xFF7EC4CF)),
            title: Text('Privacy Policy', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              // Navigate to website introduction
            },
          ),
          ListTile(
              leading: Icon(Icons.fiber_new, color: Color(0xFF7EC4CF)),
              title: Text('News', style: TextStyle(color: Color(0xFF7EC4CF))),
              onTap: () {
                
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
            leading: Icon(Icons.logout, color: Color(0xFF7EC4CF)),
            title: Text('Logout', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () async {
              // Add your logout logic here
              // For example, remove user id from shared preferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('userId');

              // Then navigate to AuthenticationUI
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthenticationUI()),
              );
            },
          ),
        ],
      ),
    );
  }
}