import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';

part 'orphanges_state.dart';

class OrphangesCubit extends Cubit<OrphangesState> {
  OrphangesCubit() : super(OrphangesInitial());
}
