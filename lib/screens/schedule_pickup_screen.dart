import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SchedulePickupScreen extends StatefulWidget {
  const SchedulePickupScreen({super.key});

  @override
  State<SchedulePickupScreen> createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  final datePickerController = DateRangePickerController();
  @override
  void dispose() {
    datePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Schedule PickUp ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
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
            Center(
              child: Text(
                'Our team will come to take your service. ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Text(
                'Please complete these steps to complete your donation',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff999999)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                CustomPaint(
                  size: Size(double.infinity, MediaQuery.of(context).size.height * .4),
                  painter: DomePainter(),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        height: 4,
                        width: MediaQuery.sizeOf(context).width * .3,
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined, color: Color(0xff999999), size: 16),
                          SizedBox(width: 8),
                          Text(
                            'choose date',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff999999),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              datePickerController.backward!();
                            },
                            icon: Icon(Icons.arrow_back_ios, size: 15),
                          ),
                          IconButton(
                            onPressed: () {
                              datePickerController.forward!();
                            },
                            icon: Icon(Icons.arrow_forward_ios, size: 15),
                          ),
                        ],
                      ),
                      SfDateRangePicker(
                        controller: datePickerController,
                        minDate: DateTime.now(),
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.single,

                        selectionColor: Color(0xffe6ecfa),
                        rangeSelectionColor: Color(0xffe6ecfa),
                        todayHighlightColor: Color(0xffe6ecfa),
                        backgroundColor: Colors.transparent,
                        selectionTextStyle: TextStyle(color: Colors.black),
                        headerStyle: DateRangePickerHeaderStyle(
                          backgroundColor: Colors.transparent,

                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          todayTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          blackoutDateTextStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Color(0xff999999), size: 16),
                          SizedBox(width: 8),
                          Text(
                            'choose time',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff999999),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xffFCD06B), height: 30),
            Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffe6ecfa),
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(width: 1, color: Color(0xffdadada)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '10:00AM',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff242760)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffe6ecfa),
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(width: 1, color: Color(0xffdadada)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '10:00AM',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff242760)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff4f4f4),
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(11)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 2,
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
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double arcHeight = size.height * 0.2;

    final Path path = Path();

    final Rect arcRect = Rect.fromLTWH(0, 0, size.width, arcHeight);
    path.addArc(arcRect, pi, pi);

    path.moveTo(0, arcHeight / 2);
    path.lineTo(0, size.height);

    path.moveTo(size.width, arcHeight / 2);
    path.lineTo(size.width, size.height);

    final Rect shaderRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xffE6ECFA), const Color(0xffE6ECFA).withAlpha(0)],
    );

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..shader = gradient.createShader(shaderRect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
