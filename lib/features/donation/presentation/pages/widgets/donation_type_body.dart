import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/adoption/presentation/pages/adoption_procedures_page.dart';
import 'package:save_heaven/features/donation/presentation/pages/widgets/components/donate_item_widget.dart';
import 'package:save_heaven/features/donation/presentation/pages/widgets/components/send_message_sheet.dart';
import 'package:save_heaven/features/payment/presentation/pages/payment_view.dart';

class DonationTypeBody extends StatelessWidget {
  const DonationTypeBody({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.03, top: height * 0.05, right: width * 0.03),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
                onPressed: () => context.pop(),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Donation',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.015),
                RichText(
                  text: TextSpan(
                    text: 'Choose How You Want To Donate\nOr ',
                    style: TextStyle(color: Colors.black, fontSize: width * 0.04, height: 1.5),
                    children: [
                      TextSpan(
                        text: 'Send Us Message',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                          decorationThickness: 2,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => SendMessageSheet(
                                orphanageName: "General Donation",
                                messageController: TextEditingController(),
                              ),
                            );
                          },
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.025),
                DonateItemWidget(
                  image: 'assets/images/money2.png',
                  title: 'Money',
                  onTap: () {
                    context.push(const PaymentView());
                  },
                ),
                DonateItemWidget(
                  image: 'assets/images/clothes.png',
                  title: 'Clothes',
                  onTap: () {
                    context.push(const AdoptionProceduresPage());
                  },
                ),
                DonateItemWidget(
                  image: 'assets/images/food.png',
                  title: 'Food',
                  onTap: () {
                    context.push(const AdoptionProceduresPage());
                  },
                ),
                SizedBox(height: height * 0.03),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
