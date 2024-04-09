import 'package:SayAnything/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:SayAnything/screens/edit_name.dart';
import 'package:SayAnything/services/Model.dart';

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
            title: Text('Website Introduction', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              // Navigate to website introduction
            },
          ),
          ListTile(
            leading: Icon(Icons.gavel, color: Color(0xFF7EC4CF)),
            title: Text('Terms and Conditions', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              // Navigate to terms and conditions
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Color(0xFF7EC4CF)),
            title: Text('Profile Picture', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              // Navigate to profile picture
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle, color: Color(0xFF7EC4CF)),
            title: Text('Account', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              // Navigate to account
            },
          ),
          ListTile(
            leading: Icon(Icons.vpn_key, color: Color(0xFF7EC4CF)),
            title: Text('ID', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              // Navigate to ID
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Color(0xFF7EC4CF)),
            title: Text('Logout', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}