import 'package:SayAnything/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class Api {
  Future<void> register(
      String username, String gender, String email, String password) {
    // Implementation goes here
    return Future.value();
  }
}

class MockApi extends Mock implements Api {}

void main() {
  testWidgets('test for register button', (WidgetTester tester) async {
    final api = MockApi();
    final emailController = TextEditingController();
    final usernameController = TextEditingController();
    final genderController = TextEditingController();
    final passwordController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              CustomTextFormField(
                hinttext: 'Username',
                obsecuretext: false,
                controller: usernameController,
              ),
              CustomTextFormField(
                hinttext: 'Gender',
                obsecuretext: false,
                controller: genderController,
              ),
              CustomTextFormField(
                hinttext: 'Email',
                obsecuretext: false,
                controller: emailController,
                addSuffix: true,
              ),
              CustomTextFormField(
                hinttext: 'Password',
                obsecuretext: true,
                controller: passwordController,
              ),
              ElevatedButton(
                onPressed: () {
                  api.register(
                    usernameController.text,
                    genderController.text,
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'), 'testuser');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Gender'), 'male');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'), '411077033');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'password123');
    await tester.pump();

    expect(emailController.text, '411077033@mail.nknu.edu.tw');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pump();

    verify(api.register(
      'testuser',
      'male',
      '411077033@mail.nknu.edu.tw',
      'password123',
    )).called(1);
  });
}
