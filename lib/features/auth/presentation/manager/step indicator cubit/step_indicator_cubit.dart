import 'package:flutter_bloc/flutter_bloc.dart';
import 'step_indicator_state.dart';

class StepIndicatorCubit extends Cubit<StepIndicatorState> {
  StepIndicatorCubit() : super(StepIndicatorState(currentStep: 0));

  void goToStep(int step) => emit(StepIndicatorState(currentStep: step));
}
