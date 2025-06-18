import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/auth/presentation/manager/Work%20Schedule%20Cubit/work_schedule_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/features/auth/presentation/views/otp_verification_view.dart';
import 'components/step_indicator.dart';
import '../../../../core/utils/widgets reuseable/circle_back_button.dart';
import '../../../../core/utils/widgets reuseable/custom_button.dart';

class WorkScheduleBody extends StatelessWidget {
  const WorkScheduleBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<WorkScheduleCubit>();
    final size = MediaQuery.of(context).size;

    context.read<StepIndicatorCubit>().goToStep(2);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const CircleBackButton(),
            const SizedBox(height: 30),
            const StepIndicator(
              titles: ['Orphanage Administrator.', 'Enter The Orphanage Data', 'Set Up Your Work Schedule'],
            ),
            const SizedBox(height: 30),
            const Text("Select Work Days:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: cubit.allDays.map((day) {
                final selected = cubit.selectedDays.contains(day);
                return ChoiceChip(
                  label: Text(day),
                  selected: selected,
                  onSelected: (_) => cubit.toggleDay(day),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            const Text("Select Time From - To:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text("From: "),
                TextButton(
                  onPressed: () async {
                    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                    if (picked != null) cubit.setFromTime(picked);
                  },
                  child: Text(
                    cubit.fromTime?.format(context) ?? "Select",
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 30),
                const Text("To: "),
                TextButton(
                  onPressed: () async {
                    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                    if (picked != null) cubit.setToTime(picked);
                  },
                  child: Text(
                    cubit.toTime?.format(context) ?? "Select",
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              text: 'Submit',
              onPressed: () {
                if (cubit.selectedDays.isEmpty || cubit.fromTime == null || cubit.toTime == null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Please complete all fields")));
                } else {
                  context.push(const OTPVerificationView());
                }
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
