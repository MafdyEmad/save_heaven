import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'work_schedule_state.dart';

class WorkScheduleCubit extends Cubit<WorkScheduleState> {
  WorkScheduleCubit() : super(WorkScheduleInitial());

  List<String> selectedDays = [];
  List<String> selectedShifts = [];
  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  final List<String> allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> allShifts = ['Morning', 'Afternoon', 'Evening'];

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    emit(WorkScheduleInitial());
  }

  void toggleShift(String shift) {
    if (selectedShifts.contains(shift)) {
      selectedShifts.remove(shift);
    } else {
      selectedShifts.add(shift);
    }
    emit(WorkScheduleInitial());
  }

  void setFromTime(TimeOfDay time) {
    fromTime = time;
    emit(WorkScheduleInitial());
  }

  void setToTime(TimeOfDay time) {
    toTime = time;
    emit(WorkScheduleInitial());
  }
}
