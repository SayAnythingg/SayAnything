import 'package:say_anything/services/Model.dart';
import 'package:flutter/material.dart';
import 'package:say_anything/controllers/SettingsPageController.dart';

class SettingsPage extends StatefulWidget {
  final User user;

  const SettingsPage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsPageController _controller = SettingsPageController();

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
            value: _controller.locationPermission,
            onChanged: (bool value) {
              setState(() {
                _controller.setLocationPermission(value);
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Camera Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.camera_alt, color: Color(0xFF7EC4CF)),
            value: _controller.cameraPermission,
            onChanged: (bool value) {
              setState(() {
                _controller.setCameraPermission(value);
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Microphone Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.mic, color: Color(0xFF7EC4CF)),
            value: _controller.microphonePermission,
            onChanged: (bool value) {
              setState(() {
                _controller.setMicrophonePermission(value);
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Storage Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.folder, color: Color(0xFF7EC4CF)),
            value: _controller.storagePermission,
            onChanged: (bool value) {
              setState(() {
                _controller.setStoragePermission(value);
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Notification Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary:
                const Icon(Icons.notifications, color: Color(0xFF7EC4CF)),
            value: _controller.notificationPermission,
            onChanged: (bool value) {
              setState(() {
                _controller.setNotificationPermission(value);
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Contacts Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary: const Icon(Icons.contacts, color: Color(0xFF7EC4CF)),
            value: _controller.contactsPermission,
            onChanged: (bool value) {
              setState(() {
                _controller.setContactsPermission(value);
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Calendar Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary:
                const Icon(Icons.calendar_today, color: Color(0xFF7EC4CF)),
            value: _controller.calendarPermission,
            onChanged: (bool value) {
              setState(() {
                _controller.setCalendarPermission(value);
              });
            },
            activeColor: const Color(0xFF7EC4CF),
          ),
          SwitchListTile(
            title: const Text('Health Data Permission',
                style: TextStyle(color: Color(0xFF7EC4CF))),
            secondary:
                const Icon(Icons.health_and_safety, color: Color(0xFF7EC4CF)),
            value: _controller.healthDataPermission,
            onChanged: (bool value) {
              setState(() {
                _controller.setHealthDataPermission(value);
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
