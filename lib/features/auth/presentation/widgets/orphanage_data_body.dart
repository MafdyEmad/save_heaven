import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/validators.dart';
import 'package:save_heaven/features/auth/presentation/manager/Orphanage%20Data%20cubit/orphanage_data_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/features/auth/presentation/views/work_schedule_view.dart';
import '../../../../core/utils/widgets reuseable/custom_text_field.dart';
import '../../../../core/utils/widgets reuseable/circle_back_button.dart';
import 'components/step_indicator.dart';
import '../../../../core/utils/widgets reuseable/circle_next_button.dart';

class OrphanageDataBody extends StatelessWidget {
  const OrphanageDataBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrphanageDataCubit>();
    final size = MediaQuery.of(context).size;

    context.read<StepIndicatorCubit>().goToStep(1);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const CircleBackButton(),
              const SizedBox(height: 20),
              const StepIndicator(
                titles: ['Orphanage Administrator.', 'Enter The Orphanage Data', 'Set Up Your Work Schedule'],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: 'Number Of Current Children',
                controller: cubit.currentChildrenController,
                validator: Validators.positiveNumber,
              ),
              CustomTextField(
                hint: 'Total Capacity',
                controller: cubit.totalCapacityController,
                validator: Validators.positiveNumber,
              ),
              CustomTextField(
                hint: 'Number Of Staff Members',
                controller: cubit.staffMembersController,
                validator: Validators.positiveNumber,
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: CircleNextButton(
                  onTap: () {
                    if (cubit.formKey.currentState!.validate()) {
                      context.push(const WorkScheduleView());
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
