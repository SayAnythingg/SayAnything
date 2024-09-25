import 'package:say_anything/screens/fade_animationtest.dart';
import 'package:say_anything/services/Model.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:say_anything/services/API_services.dart';
import 'package:say_anything/screens/loading_page.dart';
import 'package:say_anything/widgets/sideMenu.dart';
import 'package:say_anything/function/SocketServices.dart';

final controller = rive.SimpleAnimation('Animation1');

class UserIdService {
  static Future<String> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? 'default_value';
    return userId;
  }
}

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SocketService socketService;
  int _onlineUserCount = 0;

  @override
  void initState() {
    super.initState();
    socketService = SocketService();
    socketService.initializeSocket('George這邊要改伺服器位址');
    _loadOnlineUserCount();
  }

  void _loadOnlineUserCount() async {
    int count = await OnlineUserCountService().getOnlineUserCount();
    setState(() {
      _onlineUserCount = count;
    });
  }

  void startMatching() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingPage(
          socket: socketService.socket,
          user: widget.user,
          socketService: socketService,
        );
      },
    );
    if (kDebugMode) {
      print('Fucking done ... userId: ${widget.user.userId}');
    }
    socketService.emitEvent('startMatching', {'userId': widget.user.userId});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: SideMenu(user: widget.user),
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
                      const Spacer(),
                      Text('Online: $_onlineUserCount',
                          style: const TextStyle(fontSize: 14)),
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
                    startMatching();
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

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }
}
