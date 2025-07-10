import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/donation/presentation/pages/widgets/components/donate_item_widget.dart';
import 'package:save_heaven/features/donation/presentation/pages/widgets/components/send_message_sheet.dart';
import 'package:save_heaven/features/payment/presentation/pages/payment_view.dart';
import 'package:save_heaven/screens/clothes_donation_screen.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/screens/food_donation_screen.dart';

class DonationTypeBody extends StatelessWidget {
  final String orphanageId;
  final Orphanage orphanage;
  const DonationTypeBody({
    super.key,
    required this.width,
    required this.orphanage,
    required this.height,
    required this.orphanageId,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: AppDimensions.horizontalPagePadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity),
          RichText(
            text: TextSpan(
              text: 'Choose How You Want To Donate\nOr ',
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.04,
                height: 1.5,
              ),
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
          SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: DonateItemWidget(
                image: 'assets/images/money.png',
                title: 'Money',
                onTap: () {
                  context.push(
                    PaymentView(isMony: true, orphanageId: orphanageId),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: DonateItemWidget(
                image: 'assets/images/clothes.png',
                title: 'Clothes',
                onTap: () {
                  context.push(
                    ClothesDonationScreen(
                      orphanageId: orphanageId,
                      orphanage: orphanage,
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: DonateItemWidget(
                image: 'assets/images/food.png',
                title: 'Food',
                onTap: () {
                  context.push(
                    FoodDonationScreen(
                      orphanageId: orphanageId,
                      orphanage: orphanage,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
