// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/validators.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/donation/data/data_source/donation_remote_data_source.dart';
import 'package:save_heaven/screens/schedule_pickup_screen.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';

class ClothesDonationScreen extends StatefulWidget {
  final String orphanageId;
  final Orphanage orphanage;
  const ClothesDonationScreen({
    super.key,
    required this.orphanageId,
    required this.orphanage,
  });

  @override
  State<ClothesDonationScreen> createState() => _ClothesDonationScreenState();
}

class _ClothesDonationScreenState extends State<ClothesDonationScreen> {
  String clothCondition = '';
  String deliveryMethod = '';
  final TextEditingController pieces = TextEditingController();
  @override
  void initState() {
    pieces.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Clothes Donation',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios, size: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We appreciate your contribution to our kids',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              'Please follow these steps to complete your donation .',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff999999),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Clothes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xff242760),
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Important Notes About Clothing Donations:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xffFAB109),
              ),
            ),
            SizedBox(height: 2),
            Row(
              children: [
                SizedBox(width: 8),
                Icon(Icons.circle, color: Color(0xffFAB109), size: 6),

                Text(
                  '   It is recommended to wash clothes before donating.n',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 2),
            Row(
              children: [
                SizedBox(width: 8),
                Icon(Icons.circle, color: Color(0xffFAB109), size: 6),

                Text(
                  '   Ripped or damaged clothing is not permitted.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '1. Clothing Condition',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    fillColor: WidgetStatePropertyAll(Color(0xff242760)),
                    contentPadding: EdgeInsets.zero,
                    value: 'New',
                    groupValue: clothCondition,
                    onChanged: (_) {
                      clothCondition = 'New';
                      setState(() {});
                    },
                    title: Text(
                      'New',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: RadioListTile(
                    fillColor: WidgetStatePropertyAll(Color(0xff242760)),
                    contentPadding: EdgeInsets.zero,
                    value: 'Good',
                    groupValue: clothCondition,
                    onChanged: (_) {
                      clothCondition = 'Good';
                      setState(() {});
                    },
                    title: Text(
                      'Good',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '2. How many pieces of clothing?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4),
            CustomTextField(
              isNumbersOnly: true,
              hint: 'eg. 3  Pieces',
              controller: pieces,
              validator: Validators.numberOnly,
            ),

            Text(
              '3. Select Delivery Method',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          deliveryMethod = 'Self-delivery';
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffe6ecfa),
                          borderRadius: BorderRadius.circular(14.74),
                          border: deliveryMethod == 'Self-delivery'
                              ? Border.all(width: 3, color: Color(0xff242760))
                              : Border.all(width: 1, color: Color(0xffdadada)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Color(0xff242760),
                                child: SvgPicture.asset(
                                  'assets/icons/selfDelivery.svg',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Self-delivery',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          deliveryMethod = 'Home Pickup';
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffe6ecfa),
                          borderRadius: BorderRadius.circular(14.74),
                          border: deliveryMethod == 'Home Pickup'
                              ? Border.all(width: 3, color: Color(0xff242760))
                              : Border.all(width: 1, color: Color(0xffdadada)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Color(0xff242760),
                                child: SvgPicture.asset(
                                  'assets/icons/homePickup.svg',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Home Pickup',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff242760),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                onPressed: !enable()
                    ? null
                    : () {
                        context.push(
                          SchedulePickupScreen(
                            orphanage: widget.orphanage,
                            donationItems: DonationItems(
                              orphanageId: widget.orphanageId,
                              clothingCondition: clothCondition,
                              deliveryMethod: deliveryMethod,
                              itemType: 'clothes',
                              piecesCount: int.parse(pieces.text),
                            ),
                          ),
                        );
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffE6ECFA),
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: Color(0xffE6ECFA)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  bool enable() {
    return clothCondition.isNotEmpty &&
        deliveryMethod.isNotEmpty &&
        pieces.text.isNotEmpty;
  }
}
