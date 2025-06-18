import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orphanage_data_state.dart';

class OrphanageDataCubit extends Cubit<OrphanageDataState> {
  OrphanageDataCubit() : super(OrphanageDataInitial());

  final formKey = GlobalKey<FormState>();

  final currentChildrenController = TextEditingController();
  final totalCapacityController = TextEditingController();
  final staffMembersController = TextEditingController();
}
