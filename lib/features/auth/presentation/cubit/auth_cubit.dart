import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/auth/data/data_scource/auth_remote_data_source.dart';
import 'package:save_heaven/features/auth/data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthCubit(this._authRemoteDataSource) : super(AuthInitial());

  void donorSignUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthdate,
    required String address,
    required String gender,
  }) async {
    emit(DonorSignUpLoading());
    final result = await _authRemoteDataSource.signUpDonor(
      name: name,
      email: email,
      address: address,
      password: password,
      phone: phone,
      birthdate: birthdate,
      gender: gender,
    );
    result.fold(
      (error) => emit(DonorSignUpFail(message: error.message)),
      (user) => emit(DonorSignUpSuccess(user: user)),
    );
  }

  void orphanageSignUp(OrphanageSignUpParams params) async {
    emit(OrphanageSignUpLoading());
    final result = await _authRemoteDataSource.signUpOrphanage(params: params);
    result.fold(
      (error) => emit(OrphanageSignUpFail(message: error.message)),
      (user) => emit(OrphanageSignUpSuccess(user: user)),
    );
  }

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await _authRemoteDataSource.login(email: email, password: password);
    result.fold((error) => emit(LoginFail(message: error.message)), (user) => emit(LoginSuccess(user: user)));
  }
}
