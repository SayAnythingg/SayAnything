import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class AboutusController {
  final formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final bodyController = TextEditingController();

  void sendEmail(BuildContext context, String subject, String body) async {
    const String email = 'chunghao777@gmail.com';
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=$subject&body=$body',
    );

    String url = params.toString();
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url. Please install a mail app.'),
        ),
      );
    }
  }

  void dispose() {
    subjectController.dispose();
    bodyController.dispose();
  }
}