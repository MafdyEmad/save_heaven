import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/ai_search/data/data_source/ai_remote_data_source.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  final AiRemoteDataSource aiRemoteDataSource;
  AiCubit(this.aiRemoteDataSource) : super(AiInitial());

  Future<void> aiSearch(String query) async {
    emit(AiLoading());
    final result = await aiRemoteDataSource.aiSearch(query);
    result.fold(
      (l) => emit(AiFail(message: l.message)),
      (r) => emit(AiSuccess(children: r)),
    );
  }
}
