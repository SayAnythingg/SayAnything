import 'package:flutter/foundation.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initializeSocket(String serverAddress) {
    socket = IO.io(serverAddress, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      if (kDebugMode) {
        print('Connected');
      }
    });

    socket.on('pair_response', (data) {
      if (kDebugMode) {
        print(data);
      }
    });

    socket.onDisconnect((_) {
      if (kDebugMode) {
        print('Disconnected');
      }
    });
  }

  void emitEvent(String event, dynamic data) {
    socket.emit(event, data);
  }

  void disconnect() {
    socket.disconnect();
  }

  void onEvent(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }
}