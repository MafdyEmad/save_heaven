import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanges_cubit.dart';
import 'package:save_heaven/features/kids/presentation/data_source/remote_data_source.dart';

class OrphanageNearCubit extends Cubit<OrphangesState> {
  final OrphanageRemoteDataSource orphanageRemoteDataSource;
  OrphanageNearCubit(this.orphanageRemoteDataSource)
    : super(OrphangesInitial());

  void getOrphanages() async {
    emit(OrphangesLoading());
    var result = await orphanageRemoteDataSource.getPosts();
    result.fold(
      (l) => emit(OrphangesError(message: l.message)),
      (r) => emit(OrphangesLoaded(orphanagesResponse: r)),
    );
  }

  void getAllKids(String id) async {
    emit(GetAllKidsLoading());
    var result = await orphanageRemoteDataSource.getAllKids(id);
    result.fold(
      (l) => emit(GetAllKidsError(message: l.message)),
      (r) => emit(GetAllKidsLoaded(children: r)),
    );
  }

  void adopt(AdoptionRequest request) async {
    emit(AdoptLoading());
    var result = await orphanageRemoteDataSource.adopt(request);
    result.fold(
      (l) => emit(AdoptError(message: l.message)),
      (r) => emit(AdoptLoaded()),
    );
  }
}
