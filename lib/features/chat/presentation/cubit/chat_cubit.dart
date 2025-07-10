import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/features/chat/data/chat_remote_data_source.dart';
import 'package:save_heaven/features/chat/models/chat_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRemoteDataSource chatRemoteDataSource;
  ChatCubit(this.chatRemoteDataSource) : super(ChatInitial());

  StreamSubscription? _chatsSubscription;

  void getChats() {
    emit(GetChatsLoading());
    _chatsSubscription = WebSocketServices.listenEvent('GetChats').listen(
      (response) {
        if (isClosed) return;
        debugPrint('Raw socket data: $response');
        try {
          if (response is List) {
            final chats = response.map((e) => Chat.fromJson(e)).toList();
            emit(GetChatsSuccess(chats: chats));
            return;
          }

          // Example 2: response is a map with a `data` key
          if (response is Map<String, dynamic> && response['Chats'] is List) {
            final data = response['Chats'] as List;
            final chats = data.map((e) => Chat.fromJson(e)).toList();
            emit(GetChatsSuccess(chats: chats));
            return;
          }

          emit(GetChatsFail(message: 'Invalid response format'));
        } catch (e, stackTrace) {
          debugPrint('Error parsing chats: $e\n$stackTrace');
          if (!isClosed) emit(GetChatsFail(message: 'Failed to parse chats'));
        }
      },
      onError: (error) {
        debugPrint('WebSocket error: $error');
        if (!isClosed) emit(GetChatsFail(message: 'WebSocket error: $error'));
      },
    );
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
