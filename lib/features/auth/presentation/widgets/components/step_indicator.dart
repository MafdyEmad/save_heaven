import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_state.dart';

class StepIndicator extends StatelessWidget {
  final List<String> titles;
  final int totalSteps;

  const StepIndicator({super.key, required this.titles, this.totalSteps = 2});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepIndicatorCubit, StepIndicatorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(titles.length, (index) {
                final isActive = state.currentStep == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.amber : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[state.currentStep],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  // const SizedBox(height: 4),
                  // const Text("You Can Always Edit This Later.", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
