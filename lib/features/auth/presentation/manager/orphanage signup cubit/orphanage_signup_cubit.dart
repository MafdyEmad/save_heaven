import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orphanage_signup_state.dart';

class OrphanageSignupCubit extends Cubit<OrphanageSignupState> {
  OrphanageSignupCubit() : super(OrphanageSignupInitial());

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final contactController = TextEditingController();
}
