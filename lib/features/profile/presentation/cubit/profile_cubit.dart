import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';
import 'package:save_heaven/features/profile/data/models/porfile_model.dart';
import 'package:save_heaven/features/profile/data/data_source/profile_remote_data_source.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileCubit(this.profileRemoteDataSource) : super(ProfileInitial());

  void getUser() async {
    emit(GetProfileUserLoading());
    final result = await profileRemoteDataSource.getUser();
    result.fold(
      (error) => emit(GetProfileUserFail(message: error.message)),
      (user) => emit(GetProfileUserSuccess(user: user)),
    );
  }

  void updateUser(ProfileUpdateparams params) async {
    emit(UpdateUserLoading());
    final result = await profileRemoteDataSource.updateUser(params: params);
    result.fold(
      (error) => emit(UpdateUserFail(message: error.message)),
      (_) => emit(UpdateUserSuccess()),
    );
  }

  void getOurKids(String id) async {
    emit(GetOurKidsLoading());
    final result = await profileRemoteDataSource.getOurKids(id);
    result.fold(
      (error) => emit(GetOurKidsFail(message: error.message)),
      (children) => emit(GetOurKidsSuccess(children)),
    );
  }

  void addNewOrphan(OrphanParams params) async {
    emit(AddNewOrphanLoading());
    final result = await profileRemoteDataSource.addNewOrphan(params: params);
    result.fold(
      (error) => emit(AddNewOrphanFail(message: error.message)),
      (user) => emit(AddNewOrphanSuccess()),
    );
  }
}
