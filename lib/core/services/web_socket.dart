import 'dart:async';
import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketServices {
  static late IO.Socket socket;

  static Future<void> connect() async {
    socket = IO.io(ApiEndpoints.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 2000,
    });
    socket.connect();
    debugPrint('connected');
  }

  static bool get isConnected => socket.connected;

  static void disconnect() {
    socket.disconnect();
    socket.clearListeners();
  }

  static void emitEvent(String event, dynamic data) => socket.emit(event, data);
  // ✅ listenEvent stays the same
  static Stream<dynamic> listenEvent(String event) {
    final controller = StreamController<dynamic>();

    socket.on(event, (data) {
      controller.add(data);
    });

    // Also handle socket disconnect
    socket.onDisconnect((_) {
      controller.close();
    });

    return controller.stream;
  }
}
