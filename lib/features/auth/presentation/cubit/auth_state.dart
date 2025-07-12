part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

//? DONOR SIGNUP
final class DonorSignUpLoading extends AuthState {}

final class DonorSignUpFail extends AuthState {
  final String message;

  const DonorSignUpFail({required this.message});
}

final class DonorSignUpSuccess extends AuthState {
  final UserModel user;

  const DonorSignUpSuccess({required this.user});
}

//? ORPHANAGE SIGNUP
final class OrphanageSignUpLoading extends AuthState {}

final class OrphanageSignUpFail extends AuthState {
  final String message;

  const OrphanageSignUpFail({required this.message});
}

final class OrphanageSignUpSuccess extends AuthState {
  final UserModel user;

  const OrphanageSignUpSuccess({required this.user});
}

//? LOGIN
final class LoginLoading extends AuthState {}

final class LoginFail extends AuthState {
  final String message;

  const LoginFail({required this.message});
}

final class LoginSuccess extends AuthState {
  final UserModel user;

  const LoginSuccess({required this.user});
}

//? SEND OTP
final class SendOTPLoading extends AuthState {}

final class SendOTPFail extends AuthState {
  final String message;

  const SendOTPFail({required this.message});
}

final class SendOTPSuccess extends AuthState {
  final int otp;

  const SendOTPSuccess({required this.otp});
}

//? RESET PASSWORD
final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordFail extends AuthState {
  final String message;

  const ResetPasswordFail({required this.message});
}

final class ResetPasswordSuccess extends AuthState {
  const ResetPasswordSuccess();
}
