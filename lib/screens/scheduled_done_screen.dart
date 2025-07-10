import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/donor_nav_screen.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/features/donation/data/data_source/donation_remote_data_source.dart';

class ScheduledDoneScreen extends StatelessWidget {
  final Orphanage orphanage;
  final DonationItems donationItems;
  const ScheduledDoneScreen({
    super.key,
    required this.orphanage,
    required this.donationItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/success.svg'),
            SizedBox(height: 20),
            Text(
              'Your Visit Has Been Scheduled!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'We look forward to seeing you at your selected time.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff544C4C),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Please make sure to arrive on time and bring your donation items.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xff544C4C),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 140,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 120,
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              orphanage.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              orphanage.address,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color(0xff999999),
                                  size: 16,
                                ),
                                Text(
                                  '${DateFormat('dd MMMM yyyy').format(DateTime.parse(donationItems.deliveryDate!))} at ${donationItems.deliveryTime.toString()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 10),
                    child: SvgPicture.asset(
                      'assets/icons/location.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 122,
              height: 38,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff242760),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                onPressed: () {
                  context.pushAndRemoveUntil(DonorNavScreen());
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffE6ECFA),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
