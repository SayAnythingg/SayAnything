import 'package:say_anything/screens/News_page.dart';
import 'package:say_anything/screens/PrivacyPolicy_Page.dart';
import 'package:say_anything/screens/SayAnything.dart';
import 'package:say_anything/screens/aboutus_page.dart';
import 'package:say_anything/screens/setting_page.dart';
import 'package:say_anything/services/API_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:say_anything/screens/edit_name.dart' as edit_name;
import 'package:say_anything/services/Model.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  final User user;
  final apiService = LoginApiService();

  SideMenu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF7EC4CF),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 70,
                  left: 10,
                  child: Text(user.name, style: const TextStyle(color: Colors.white)),
                ),
                Positioned(
                  top: 90,
                  left: 10,
                  child: Text('ID: ${user.userId}',
                      style: const TextStyle(color: Colors.white)),
                ),
                Positioned(
                  top: 110,
                  left: 10,
                  child:
                      Text(user.email, style: const TextStyle(color: Colors.white)),
                ),
                Positioned(
                  top: 10,
                  right: 170,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                edit_name.EditNameFormPage(user: user)),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 190,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
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
            leading: const Icon(Icons.info, color: Color(0xFF7EC4CF)),
            title: const Text('Privacy Policy',
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
            leading: const Icon(Icons.fiber_new, color: Color(0xFF7EC4CF)),
            title: const Text('News', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Color(0xFF7EC4CF)),
            title: const Text('About Us', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Aboutus()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF7EC4CF)),
            title: const Text('Settings', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFF7EC4CF)),
            title: const Text('Logout', style: TextStyle(color: Color(0xFF7EC4CF))),
            onTap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                text: 'Do you want to logout?',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                confirmBtnColor: Colors.green,
                onConfirmBtnTap: () async {
                  try {
                    var logoutService = LogoutService();
                    await logoutService.logout(user.userId);

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();

                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Sayanything()),
                    );
                  } catch (error) {
                    if (kDebugMode) {
                      print('Logout failed: $error');
                    }
                  }
                },
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Color(0xFF7EC4CF)),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
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
