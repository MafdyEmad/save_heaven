// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'user_signup_state.dart';

// class UserSignupCubit extends Cubit<UserSignupState> {
//   UserSignupCubit() : super(UserSignupInitial());

//   final formKey = GlobalKey<FormState>();

//   final fullNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final birthdateController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final phoneController = TextEditingController();

//   String? selectedGender;

//   void updateGender(String? value) {
//     selectedGender = value;
//     emit(UserSignupGenderSelected());
//   }

//   bool validateForm() {
//     if (!formKey.currentState!.validate()) return false;
//     if (selectedGender == null) return false;
//     return true;
//   }
// }
