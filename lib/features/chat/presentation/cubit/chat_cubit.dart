import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/features/chat/data/chat_remote_data_source.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRemoteDataSource chatRemoteDataSource;
  ChatCubit(this.chatRemoteDataSource) : super(ChatInitial());

  void getChats() async {
    emit(GetChatsLoading());
    await for (final response in WebSocketServices.listenEvent('GetChats')) {
      if (isClosed) return;

      debugPrint('Raw socket data: $response');

      if (response is Map && response['status'] == 'fail') {
        emit(GetChatsFail(message: response['message'] ?? 'Unknown error'));
      } else if (response is Map && response['status'] == 'success') {
        final friends = response['data'];
        emit(GetChatsSuccess());
      } else {
        emit(GetChatsFail(message: 'Invalid response format'));
      }
    }
  }
}
