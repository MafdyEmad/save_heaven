part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class DonorSignUpLoading extends AuthState {}

final class DonorSignUpFail extends AuthState {
  final String message;

  const DonorSignUpFail({required this.message});
}

final class DonorSignUpSuccess extends AuthState {
  final UserModel user;

  const DonorSignUpSuccess({required this.user});
}
