import 'package:SayAnything/screens/fade_animationtest.dart';
import 'package:SayAnything/services/Model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SayAnything/services/API_services.dart';
import 'package:SayAnything/screens/loading_page.dart';

import 'package:SayAnything/widgets/sideMenu.dart';

final matchApiService = MatchApiService();
final controller = rive.SimpleAnimation('Animation1');

class UserIdService {
  static Future<String> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? 'default_value';
    return userId;
  }
}

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: SideMenu(user: user),
      body: Stack(
        children: [
          Container(
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
                  title: Row(
                    children: [
                      Image.asset('assets/images/logo.png', width: 50),
                      Image.asset('assets/images/logo_word.png', width: 120),
                    ],
                  ),
                  centerTitle: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    Builder(
                      builder: (context) => Row(
                        children: [
                          const Text(
                            'on-line:3',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          IconButton(
                            icon: const SizedBox(
                              width: 30,
                              height: 30,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.black, BlendMode.srcIn),
                                child: rive.RiveAnimation.asset(
                                  'assets/animation/setting.riv',
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            onPressed: () =>
                                Scaffold.of(context).openEndDrawer(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: FadeInAnimation(
                      delay: 1,
                      child: SizedBox(
                        height: 400,
                        width: screenWidth,
                        child: const rive.RiveAnimation.asset(
                          'assets/animation/2.riv',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInAnimation(
                  delay: 1,
                  child: SizedBox(
                    height: 300,
                    width: screenWidth,
                    child: const rive.RiveAnimation.asset(
                      'assets/animation/hand.riv',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return LoadingPage();
                      },
                    );

                    Map<String, dynamic> response =
                        await matchApiService.requestMatch(user.userId);

                    String message = response['Message'];
                    if (message.contains('deleted')) {
                      if (kDebugMode) {
                        print('deleted');
                      }
                    } else if (message.contains('matched')) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Successfully matched!'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (message.contains('waiting')) {
                      if (kDebugMode) {
                        print('waitung');
                      }
                    }
                  },
                  backgroundColor: const Color.fromARGB(255, 244, 246, 247),
                  child: const Icon(Icons.navigation),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
