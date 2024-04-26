
import 'package:SayAnything/screens/fade_animationtest.dart';

import 'package:SayAnything/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:SayAnything/services/user_data.dart';

class EditDescriptionFormPage extends StatefulWidget {
  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
    user.aboutMeDescription = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: Text(''),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 350,
                    child: const Text(
                      "What type of passenger\nare you?",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: 250,
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length > 200) {
                            return 'Please describe yourself but keep it under 200 characters.';
                          }
                          return null;
                        },
                        controller: descriptionController,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 100),
                          hintMaxLines: 3,
                          hintText: 'Write something',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                        child: FadeInAnimation(
                          delay: 2.7,
                          child: CustomElevatedButton(
                            message: "Save",
                            function: () {
                              updateUserValue(descriptionController.text);
                               Navigator.pop(context);
                            },
                            color: Color(0xFF7EC4CF),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}