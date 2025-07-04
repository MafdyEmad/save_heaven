part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

//? get user
final class GetProfileUserLoading extends ProfileState {}

final class GetProfileUserSuccess extends ProfileState {
  final UserDataResponse user;

  const GetProfileUserSuccess({required this.user});
}

final class GetProfileUserFail extends ProfileState {
  final String message;

  const GetProfileUserFail({required this.message});
}

//? get user

final class AddNewOrphanLoading extends ProfileState {}

final class AddNewOrphanSuccess extends ProfileState {
  const AddNewOrphanSuccess();
}

final class AddNewOrphanFail extends ProfileState {
  final String message;

  const AddNewOrphanFail({required this.message});
}

//? UPDATE USER

final class UpdateUserLoading extends ProfileState {}

final class UpdateUserSuccess extends ProfileState {
  const UpdateUserSuccess();
}

final class UpdateUserFail extends ProfileState {
  final String message;

  const UpdateUserFail({required this.message});
}
//? GET OUR KIDS

final class GetOurKidsLoading extends ProfileState {}

final class GetOurKidsSuccess extends ProfileState {
  final List<ChildModel> children;
  const GetOurKidsSuccess(this.children);
}

final class GetOurKidsFail extends ProfileState {
  final String message;

  const GetOurKidsFail({required this.message});
}
