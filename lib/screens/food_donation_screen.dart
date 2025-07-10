import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/donation/data/data_source/donation_remote_data_source.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/screens/schedule_pickup_screen.dart';

class FoodDonationScreen extends StatefulWidget {
  final String orphanageId;
  final Orphanage orphanage;
  const FoodDonationScreen({
    super.key,
    required this.orphanageId,
    required this.orphanage,
  });

  @override
  State<FoodDonationScreen> createState() => _FoodDonationScreenState();
}

class _FoodDonationScreenState extends State<FoodDonationScreen> {
  String foodType = '';
  final TextEditingController quantity = TextEditingController();
  String readyForCollection = '';
  String deliveryMethod = '';
  @override
  void initState() {
    super.initState();
    quantity.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Food Donation',
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
              'Food',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xff242760),
              ),
            ),
            Row(
              children: [
                Text(
                  '1-',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: 'Cooked',
                        groupValue: foodType,
                        onChanged: (_) {
                          foodType = 'Cooked';
                          setState(() {});
                        },
                        activeColor: Color(0xff242760),
                      ),
                      Text(
                        'Cooked',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: 'Dry',
                        groupValue: foodType,
                        onChanged: (_) {
                          foodType = 'Dry';
                          setState(() {});
                        },
                        activeColor: Color(0xff242760),
                      ),
                      Text(
                        'Dry',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: 'Canned',
                        groupValue: foodType,
                        onChanged: (_) {
                          foodType = 'Canned';
                          setState(() {});
                        },
                        activeColor: Color(0xff242760),
                      ),
                      Text(
                        'Canned',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '2-quantity',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4),
            CustomTextField(
              hint: 'eg. 3  Pieces',
              isNumbersOnly: true,
              controller: quantity,
            ),

            SizedBox(height: 20),
            Text(
              '3- Packed and Ready For Collection?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Yes',
                      groupValue: readyForCollection,
                      onChanged: (_) {
                        readyForCollection = 'Yes';
                        setState(() {});
                      },
                      activeColor: Color(0xff242760),
                    ),
                    Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'No',
                      groupValue: readyForCollection,
                      onChanged: (_) {
                        readyForCollection = 'No';
                        setState(() {});
                      },
                      activeColor: Color(0xff242760),
                    ),
                    Text(
                      'No',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

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
                            isCloth: false,
                            orphanage: widget.orphanage,
                            donationItems: DonationItems(
                              orphanageId: widget.orphanageId,
                              deliveryMethod: deliveryMethod,
                              itemType: 'food',
                              foodType: foodType,
                              isReadyForPickup: readyForCollection == 'Yes',
                              foodQuantity: quantity.text,
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
    return foodType.isNotEmpty &&
        deliveryMethod.isNotEmpty &&
        quantity.text.isNotEmpty;
  }
}
