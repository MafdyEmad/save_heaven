part of 'ai_cubit.dart';

sealed class AiState extends Equatable {
  const AiState();

  @override
  List<Object> get props => [];
}

final class AiInitial extends AiState {}

final class AiLoading extends AiState {}

final class AiSuccess extends AiState {}

final class AiFail extends AiState {
  final String message;
  const AiFail({required this.message});
}
