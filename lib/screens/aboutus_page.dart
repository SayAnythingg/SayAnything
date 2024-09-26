import 'package:flutter/material.dart';
import 'package:say_anything/controllers/AboutusController.dart';

class Aboutus extends StatelessWidget {
  final controller = AboutusController();

  Aboutus({super.key});

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
              title: const Text('About Us'),
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  const ListTile(
                    title: Text('Origin👍', textAlign: TextAlign.center),
                    subtitle:
                        Text('Our history...', textAlign: TextAlign.center),
                  ),
                  const ListTile(
                    title: Text('Professor👨‍🏫', textAlign: TextAlign.center),
                  ),
                  buildCard(context, 'assets/images/ting.png', '李文廷',
                      'wtlee@mail.nknu.edu.tw', ''),
                  const ListTile(
                    title: Text('Developer👨‍🎓👩‍🎓👨‍🏫',
                        textAlign: TextAlign.center),
                  ),
                  buildCard(context, 'assets/images/chung.jpeg', '鍾弘浩',
                      'chunghao777@gmail.com', 'Mobile Developer'),
                  buildCard(context, 'assets/images/T.png', '談宇容',
                      'sylvia15334@gmail.com', 'Backend Developer'),
                  buildCard(context, 'assets/images/george.png', '林鈺佑',
                      'george920102@gmail.com', 'Backend Developer'),
                  const ListTile(
                    title: Text('特別感謝', textAlign: TextAlign.center),
                  ),
                  buildCard(context, 'https://example.com/image5.jpg', '友情協助成員',
                      '@gmail.com', ''),
                  const ListTile(
                    title: Text('問題回報', textAlign: TextAlign.center),
                  ),
                  Form(
                    key: controller.formKey,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: controller.subjectController,
                              decoration: const InputDecoration(
                                labelText: 'Subject',
                                focusColor: Color(0xFF7EC4CF),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a subject';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: controller.bodyController,
                              decoration: const InputDecoration(
                                labelText: 'Body',
                                focusColor: Color(0xFF7EC4CF),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a body';
                                }
                                return null;
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (controller.formKey.currentState != null &&
                                    controller.formKey.currentState!.validate()) {
                                  controller.sendEmail(context, 'Subject', 'Body');
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color(0xFF7EC4CF)), // Set the button color here
                              ),
                              child: const Text('Submit'),
                            ),
                          ],
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

  Widget buildCard(BuildContext context, String imageUrl, String title,
      String email, String body) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imageUrl),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(title, textAlign: TextAlign.center),
              ),
              Text(' $email', textAlign: TextAlign.center),
              Text(body, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}