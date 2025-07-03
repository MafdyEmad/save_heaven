import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/features/auth/data/data_scource/auth_remote_data_source.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/orphanage_nav_screen.dart';
import 'components/step_indicator.dart';
import '../../../../core/utils/widgets reuseable/circle_back_button.dart';
import '../../../../core/utils/widgets reuseable/custom_button.dart';

class WorkScheduleBody extends StatefulWidget {
  final OrphanageSignUpParams currentParams;

  const WorkScheduleBody({super.key, required this.currentParams});

  @override
  State<WorkScheduleBody> createState() => _WorkScheduleBodyState();
}

class _WorkScheduleBodyState extends State<WorkScheduleBody> {
  List<String> selectedDays = [];
  List<String> selectedShifts = [];
  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  final List<String> allDaysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  final List<String> allShifts = ['Morning', 'Afternoon', 'Evening'];
  final orphanageSignUpStates = List.unmodifiable([
    OrphanageSignUpLoading,
    OrphanageSignUpFail,
    OrphanageSignUpSuccess,
  ]);

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    setState(() {});
  }

  void toggleShift(String shift) {
    if (selectedShifts.contains(shift)) {
      selectedShifts.remove(shift);
    } else {
      selectedShifts.add(shift);
    }
    setState(() {});
  }

  void setFromTime(TimeOfDay time) {
    fromTime = time;
    setState(() {});
  }

  void setToTime(TimeOfDay time) {
    toTime = time;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    context.read<StepIndicatorCubit>().goToStep(2);

    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<AuthCubit, AuthState>(
            buildWhen: (previous, current) =>
                orphanageSignUpStates.contains(current.runtimeType),
            listener: (context, state) {
              if (state is OrphanageSignUpSuccess) {
                context.pushAndRemoveUntil(const OrphanageNavScreen());
              } else if (state is OrphanageSignUpFail) {
                showCustomDialog(
                  context,
                  title: "Sign Up failed",
                  content: state.message,
                  confirmText: "Try again",
                  cancelText: '',
                  onConfirm: () {
                    context.pop();
                  },
                  onCancel: () {},
                );
              }
            },
            builder: (context, state) {
              return IgnorePointer(
                ignoring: state is OrphanageSignUpLoading,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(size.width * 0.07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const CircleBackButton(),
                        const SizedBox(height: 30),
                        const StepIndicator(
                          titles: [
                            'Orphanage Administrator.',
                            'Enter The Orphanage Data',
                            'Set Up Your Work Schedule',
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Select Work Days:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: allDaysOfWeek.map((day) {
                            final selected = selectedDays.contains(day);
                            return ChoiceChip(
                              backgroundColor: AppPalette.primaryColor
                                  .withAlpha(150),
                              selectedColor: AppPalette.primaryColor,
                              label: Text(
                                day,
                                style: context.textTheme.headlineMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              selected: selected,
                              onSelected: (_) => toggleDay(day),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Select Time From - To:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text("From: "),
                            TextButton(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (picked != null) {
                                  if (toTime != null) {
                                    if (picked.hour > toTime!.hour ||
                                        (picked.hour == toTime!.hour &&
                                            picked.minute >= toTime!.minute)) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "From time must be before To time",
                                          ),
                                        ),
                                      );
                                      return; // stop setting invalid time
                                    }
                                  }

                                  setFromTime(picked); // valid case
                                }
                              },
                              child: Text(
                                fromTime?.format(context) ?? "Select",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            const Text("To: "),
                            TextButton(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (picked != null) {
                                  if (fromTime != null) {
                                    if (picked.hour < fromTime!.hour ||
                                        (picked.hour == fromTime!.hour &&
                                            picked.minute < fromTime!.minute)) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "You can't choose To time before From time",
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                  }

                                  // Valid time, set it
                                  setToTime(picked);
                                }
                              },
                              child: Text(
                                toTime?.format(context) ?? "Select",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        state is OrphanageSignUpLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppPalette.primaryColor,
                                ),
                              )
                            : CustomButton(
                                text: 'Submit',
                                onPressed: () {
                                  if (selectedDays.isEmpty ||
                                      fromTime == null ||
                                      toTime == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please complete all fields",
                                        ),
                                      ),
                                    );
                                  } else {
                                    context.read<AuthCubit>().orphanageSignUp(
                                      widget.currentParams.copyWith(
                                        workDays: selectedDays,
                                        workHours: [
                                          fromTime!.format(context),
                                          toTime!.format(context),
                                        ],
                                      ),
                                    );
                                    // context.push(const OTPVerificationView());
                                  }
                                },
                              ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
