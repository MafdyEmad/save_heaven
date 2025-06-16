import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClothesDonationScreen extends StatelessWidget {
  const ClothesDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Clothes Donation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff999999)),
            ),
            SizedBox(height: 20),
            Text(
              'Clothes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff242760)),
            ),
            SizedBox(height: 6),
            Text(
              'Important Notes About Clothing Donations:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xffFAB109)),
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
            Text('1. Clothing Condition', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    fillColor: WidgetStatePropertyAll(Color(0xff242760)),
                    contentPadding: EdgeInsets.zero,
                    value: null,
                    groupValue: 0,
                    onChanged: (_) {},
                    title: Text('New', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: RadioListTile(
                    fillColor: WidgetStatePropertyAll(Color(0xff242760)),
                    contentPadding: EdgeInsets.zero,
                    value: null,
                    groupValue: 0,
                    onChanged: (_) {},
                    title: Text('Good', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
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
            TextFormField(
              decoration: InputDecoration(
                hint: Text(
                  'eg. 3  Pieces',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff2C2C2C)),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xff242760)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('3. Select Delivery Method', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffe6ecfa),
                        borderRadius: BorderRadius.circular(14.74),
                        border: Border.all(width: 1, color: Color(0xffdadada)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Color(0xff242760),
                              child: SvgPicture.asset('assets/icons/selfDelivery.svg', width: 28, height: 28),
                            ),
                            Spacer(),
                            Text(
                              'Self-delivery',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffe6ecfa),
                        borderRadius: BorderRadius.circular(14.74),
                        border: Border.all(width: 1, color: Color(0xffdadada)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Color(0xff242760),
                              child: SvgPicture.asset('assets/icons/homePickup.svg', width: 28, height: 28),
                            ),
                            Spacer(),
                            Text('Home Pickup', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                          ],
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
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(11)),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xffE6ECFA)),
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
}
