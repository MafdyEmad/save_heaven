import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduledDoneScreen extends StatelessWidget {
  const ScheduledDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.arrow_back_ios)),
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff544C4C)),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Please make sure to arrive on time and bring your donation items.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff544C4C)),
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
                          children: [
                            Text(
                              'Dar Al Rahma Orphanage',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '12 Al-Mahdy St., Nasr City, Cairo',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'View on Google Maps',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_month_outlined, color: Color(0xff999999), size: 16),
                                Text(
                                  'Tuesday, April 23 - 2:00 PM',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
                    child: SvgPicture.asset('assets/icons/location.svg', width: 40, height: 40),
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
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(11)),
                ),
                onPressed: () {},
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xffE6ECFA)),
                ),
              ),
            ),
            SizedBox(height: 50),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: SizedBox(
                width: 172,
                height: 38,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Color(0xff242760)),

                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Go home',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xff242760)),
                      ),
                      Icon(Icons.arrow_forward, color: Color(0xff242760)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
