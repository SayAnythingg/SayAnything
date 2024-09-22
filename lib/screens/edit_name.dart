import 'package:SayAnything/screens/fade_animationtest.dart';
import 'package:SayAnything/services/API_services.dart';
import 'package:SayAnything/services/Model.dart';
import 'package:SayAnything/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class EditNameFormPage extends StatefulWidget {
  final User user;
  EditNameFormPage({super.key, required this.user});
  final apiService = LoginApiService();
  final updateProfileApiService = UpdateProfileApiService();

  @override
  EditNameFormPageState createState() => EditNameFormPageState();
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void updateUserValue(String newUsername, dynamic user) async {
    final response = await widget.updateProfileApiService
        .updateProfile(user.userId, newUsername);

    if (!mounted) return;

    if (response.containsKey('message')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text(''),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 330,
                    child: Text(
                      "What's Your Name?",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                    child: SizedBox(
                      height: 100,
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else if (!isAlpha(value.replaceAll(' ', ''))) {
                            return 'Only Letters Please';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: 'Name'),
                        controller: nameController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FadeInAnimation(
                        delay: 2.7,
                        child: CustomElevatedButton(
                          message: "Save",
                          function: () {
                            if (_formKey.currentState!.validate()) {
                              updateUserValue(nameController.text, widget.user);
                              Navigator.pop(context);
                            }
                          },
                          color: const Color(0xFF7EC4CF),
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
