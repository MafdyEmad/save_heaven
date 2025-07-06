part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

//? GET CHATS
final class GetChatsLoading extends ChatState {}

final class GetChatsSuccess extends ChatState {
  final List<Chat> chats;

  const GetChatsSuccess({required this.chats});
}

final class GetChatsFail extends ChatState {
  final String message;

  const GetChatsFail({required this.message});
}
