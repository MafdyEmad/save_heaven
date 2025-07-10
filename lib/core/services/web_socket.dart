import 'dart:async';
import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketServices {
  static late IO.Socket socket;

  /// ✅ Keep your user ID here for auto-joining the room
  static String? _currentUserId;

  /// ✅ Connect and join the user’s room
  static Future<void> connect(String userId) async {
    _currentUserId = userId;

    socket = IO.io(ApiEndpoints.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 2000,
    });

    socket.connect();

    socket.onConnect((_) {
      debugPrint('✅ Socket connected');
      if (_currentUserId != null) {
        socket.emit('OpenApp', {'userId': _currentUserId});
        debugPrint('✅ OpenApp sent with userId $_currentUserId');
      }
    });

    socket.onDisconnect((_) {});

    socket.onConnectError((err) {});
  }

  static bool get isConnected => socket.connected;

  static void disconnect() {
    socket.disconnect();
    socket.clearListeners();
    _currentUserId = null;
  }

  /// ✅ General emit for any event
  static void emitEvent(String event, dynamic data) {
    socket.emit(event, data);
  }

  /// ✅ General listen for any event
  static Stream<dynamic> listenEvent(String event) {
    final controller = StreamController<dynamic>();

    if (!socket.connected) {
      debugPrint('⚠️ Socket not connected. Connect first.');
    }

    socket.on(event, (data) {
      controller.add(data);
    });

    socket.onDisconnect((_) {
      controller.close();
    });

    return controller.stream;
  }
}
