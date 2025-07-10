import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/title_widget.dart';
import 'package:save_heaven/donor_nav_screen.dart';
import 'package:save_heaven/features/donation/data/data_source/donation_remote_data_source.dart';
import 'package:save_heaven/features/donation/presentation/cubit/donation_cubit.dart';
import 'package:save_heaven/features/payment/presentation/manager/payment%20cubit/payment_cubit.dart';
import 'payment_fields.dart';

class PaymentForm extends StatefulWidget {
  final bool isMony;
  final String orphanageId;
  const PaymentForm({
    super.key,
    required this.isMony,
    required this.orphanageId,
  });

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final bloc = getIt<DonationCubit>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = PaymentCubit.get(context);

    return BlocProvider(
      create: (context) => bloc,
      child: Builder(
        builder: (context) {
          return BlocListener<DonationCubit, DonationState>(
            listener: (context, state) {
              if (state is DonationDonateSuccess) {
                context.pop();
                showCustomDialog(
                  context,
                  title: "Donation Successful",
                  content:
                      "Thank you for your generous donation! Your support helps us take care of more orphans.",
                  confirmText: "OK",
                  cancelText: "",
                  onConfirm: () {
                    context.pushAndRemoveUntil(DonorNavScreen());
                  },
                  onCancel: () {},
                );
              } else if (state is DonationDonateFail) {
                context.pop();
                showSnackBar(context, state.message);
              } else if (state is DonationDonateLoading) {
                showLoading(context);
              }
            },

            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle("Please Choose Payment Method :"),
                    BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildRadioWithImage(
                              context: context,
                              imagePath: AssetsImages.visa,
                              value: 'Visa',
                              groupValue: state.paymentMethod,
                              onChanged: (value) {
                                cubit.changeMethod(value);
                              },
                            ),
                            _buildRadioWithImage(
                              context: context,
                              imagePath: AssetsImages.mastarCard,
                              value: 'MasterCard',
                              groupValue: state.paymentMethod,
                              onChanged: (value) {
                                cubit.changeMethod(value);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    PaymentFields(cubit: cubit),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: "Donate",
                      onPressed: () {
                        final DonateMony monyModel = DonateMony(
                          orphanageId: widget.orphanageId,
                          amount: int.parse(cubit.donationValue.text),
                          paymentMethod: cubit.state.paymentMethod,

                          cardNumber: cubit.cardNumber.text,
                          cvc: cubit.cvc.text,
                          expiryDate: cubit.expiryDate.text,
                          cardHolderName: cubit.cardHolder.text,
                        );

                        bloc.donate(
                          isMony: widget.isMony,
                          monyModel: monyModel,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRadioWithImage({
    required BuildContext context,
    required String imagePath,
    required String value,
    required String groupValue,
    required ValueChanged<String> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
            activeColor: Colors.green,
          ),
          Image.asset(imagePath, height: 40, width: 60, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
