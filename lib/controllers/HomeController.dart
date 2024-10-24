import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:say_anything/function/SocketServices.dart';
import 'package:say_anything/services/Model.dart';
import 'package:say_anything/services/API_services.dart';
import 'package:say_anything/screens/loading_page.dart';

class HomeController {
  final BuildContext context;
  final User user;
  late SocketService socketService;
  int _onlineUserCount = 0;

  HomeController({
    required this.context,
    required this.user,
  });

  int get onlineUserCount => _onlineUserCount;

  void init() {
    socketService = SocketService();
    socketService
        .initializeSocket('https://sayanythingprotocol.sdpmlab.org/match/');
    _loadOnlineUserCount();
  }

  void _loadOnlineUserCount() async {
    int count = await OnlineUserCountService().getOnlineUserCount();
    _onlineUserCount = count;
    if (context.mounted) {
      (context as Element).markNeedsBuild();
    }
  }

  void startMatching() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingPage(
          socket: socketService.socket,
          user: user,
          socketService: socketService,
        );
      },
    );
    if (kDebugMode) {
      print('Fucking done ... userId: ${user.userId}');
    }
    socketService.emitEvent('startmatching', {'userId': user.userId});
  }

  void dispose() {
    socketService.disconnect();
  }
}