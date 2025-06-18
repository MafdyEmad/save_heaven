import 'package:flutter/material.dart';
import 'orphanage_admin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrphanageAdminCubit extends Cubit<OrphanageAdminState> {
  OrphanageAdminCubit() : super(OrphanageAdminInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
}
