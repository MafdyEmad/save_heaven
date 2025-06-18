import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); // 0 = Home

  void changeTab(int index) => emit(index);
}
