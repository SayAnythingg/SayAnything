import 'package:flutter/material.dart';
import 'package:say_anything/function/SocketServices.dart';
import 'package:say_anything/services/Model.dart';

class LoadingController {
  final SocketService socketService;
  final User user;
  final BuildContext context;

  LoadingController({
    required this.socketService,
    required this.user,
    required this.context,
  });

  void init() {
    socketService.onEvent('pair_response', (data) {
      if (data['userId'] != null) {
        _showMatchSuccessDialog();
      }
    });
  }

  void _showMatchSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Match Success'),
          content: const Text('You have been successfully paired!'),
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
  }

  void cancelMatch() {
    print('Canceling match for userId: ${user.userId}');
    socketService.emitEvent('cancelMatch', {'userId': user.userId});
    Navigator.pop(context);
  }
}