import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/validators.dart';
import 'package:save_heaven/features/auth/data/data_scource/auth_remote_data_source.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/features/auth/presentation/views/orphanage_data_view.dart';
import 'package:save_heaven/features/auth/presentation/views/work_schedule_view.dart';

import '../../../../core/utils/widgets reuseable/custom_text_field.dart';
import '../../../../core/utils/widgets reuseable/circle_back_button.dart';
import 'components/step_indicator.dart';
import '../../../../core/utils/widgets reuseable/circle_next_button.dart';

class OrphanageAdminBody extends StatefulWidget {
  final OrphanageSignUpParams currentParams;
  const OrphanageAdminBody({super.key, required this.currentParams});

  @override
  State<OrphanageAdminBody> createState() => _OrphanageAdminBodyState();
}

class _OrphanageAdminBodyState extends State<OrphanageAdminBody> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    context.read<StepIndicatorCubit>().goToStep(0);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const CircleBackButton(),
              const SizedBox(height: 20),
              const StepIndicator(
                titles: [
                  'Orphanage Administrator.',
                  'Set Up Your Work Schedule',
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: 'Enter Administrator Name',
                controller: nameController,
                validator: Validators.requiredField,
              ),
              CustomTextField(
                hint: 'Enter Administrator Contact Number',
                controller: phoneController,
                validator: Validators.phone,
              ),
              CustomTextField(
                hint: 'Enter Administrator Email',

                controller: emailController,
                validator: Validators.email,
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: CircleNextButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.push(
                        WorkScheduleView(
                          currentParams: widget.currentParams.copyWith(
                            adminName: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            email: emailController.text.trim(),
                          ),
                        ),
                      );
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
