import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void selectGender(String? gender) => emit(state.copyWith(gender: gender));
  void selectAgeGroup(String? age) => emit(state.copyWith(ageGroup: age));
  void selectLevel(String? level) => emit(state.copyWith(level: level));
  void selectOrphanage(String? orphanage) => emit(state.copyWith(orphanage: orphanage));
  void selectReligion(String? religion) => emit(state.copyWith(religion: religion));
  void selectSkinTone(String? tone) => emit(state.copyWith(skinTone: tone));
  void selectHairType(String? type) => emit(state.copyWith(hairType: type));

  void resetAll() => emit(const FilterState());
}
