import 'package:SayAnything/services/Model.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final User user;

  const SettingsPage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _locationPermission = false;
  bool _cameraPermission = false;
  bool _microphonePermission = false;
  bool _storagePermission = false;
  bool _notificationPermission = false;
  bool _contactsPermission = false;
  bool _calendarPermission = false;
  bool _healthDataPermission = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7EC4CF),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('Location Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.location_on, color: Color(0xFF7EC4CF)),
            value: _locationPermission,
            onChanged: (bool value) {
              setState(() {
                _locationPermission = value;
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Camera Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.camera_alt, color: Color(0xFF7EC4CF)),
            value: _cameraPermission,
            onChanged: (bool value) {
              setState(() {
                _cameraPermission = value;
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Microphone Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.mic, color: Color(0xFF7EC4CF)),
            value: _microphonePermission,
            onChanged: (bool value) {
              setState(() {
                _microphonePermission = value;
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Storage Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.folder, color: Color(0xFF7EC4CF)),
            value: _storagePermission,
            onChanged: (bool value) {
              setState(() {
                _storagePermission = value;
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Notification Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.notifications, color: Color(0xFF7EC4CF)),
            value: _notificationPermission,
            onChanged: (bool value) {
              setState(() {
                _notificationPermission = value;
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Contacts Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.contacts, color: Color(0xFF7EC4CF)),
            value: _contactsPermission,
            onChanged: (bool value) {
              setState(() {
                _contactsPermission = value;
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Calendar Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.calendar_today, color: Color(0xFF7EC4CF)),
            value: _calendarPermission,
            onChanged: (bool value) {
              setState(() {
                _calendarPermission = value;
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Health Data Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.health_and_safety, color: Color(0xFF7EC4CF)),
            value: _healthDataPermission,
            onChanged: (bool value) {
              setState(() {
                _healthDataPermission = value;
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Color(0xFF7EC4CF)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
