// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:save_heaven/core/utils/extensions.dart';
// import 'package:save_heaven/core/utils/validators.dart';
// import 'package:save_heaven/features/auth/data/data_scource/auth_remote_data_source.dart';
// import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
// import 'package:save_heaven/features/auth/presentation/views/work_schedule_view.dart';
// import '../../../../core/utils/widgets reuseable/custom_text_field.dart';
// import '../../../../core/utils/widgets reuseable/circle_back_button.dart';
// import 'components/step_indicator.dart';
// import '../../../../core/utils/widgets reuseable/circle_next_button.dart';

// class OrphanageDataBody extends StatefulWidget {
//   final OrphanageSignUpParams currentParams;
//   const OrphanageDataBody({super.key, required this.currentParams});

//   @override
//   State<OrphanageDataBody> createState() => _OrphanageDataBodyState();
// }

// class _OrphanageDataBodyState extends State<OrphanageDataBody> {
//   final formKey = GlobalKey<FormState>();

//   final currentChildrenController = TextEditingController();
//   final totalCapacityController = TextEditingController();
//   final staffMembersController = TextEditingController();

//   @override
//   void dispose() {
//     currentChildrenController.dispose();
//     totalCapacityController.dispose();
//     staffMembersController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     context.read<StepIndicatorCubit>().goToStep(1);

//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               const CircleBackButton(),
//               const SizedBox(height: 20),
//               const StepIndicator(
//                 titles: ['Orphanage Administrator.',  'Set Up Your Work Schedule'],
//               ),
//               const SizedBox(height: 20),
//               CustomTextField(
//                 hint: 'Number Of Current Children',
//                 controller: currentChildrenController,
//                 validator: Validators.positiveNumber,
//               ),
//               CustomTextField(
//                 hint: 'Total Capacity',
//                 controller: totalCapacityController,
//                 validator: Validators.positiveNumber,
//               ),
//               CustomTextField(
//                 hint: 'Number Of Staff Members',
//                 controller: staffMembersController,
//                 validator: Validators.positiveNumber,
//               ),
//               const SizedBox(height: 24),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: CircleNextButton(
//                   onTap: () {
//                     if (formKey.currentState!.validate()) {
//                       context.push(
//                         WorkScheduleView(
//                           currentParams: widget.currentParams.copyWith(
//                             currentChildren: int.parse(currentChildrenController.text.trim()),
//                             totalCapacity: int.parse(totalCapacityController.text.trim()),
//                             staffCount: int.parse(staffMembersController.text.trim()),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
