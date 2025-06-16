import 'package:flutter/material.dart';

class PickupDetailsScreen extends StatelessWidget {
  final bool isCloth;
  const PickupDetailsScreen({super.key, required this.isCloth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pickup  Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .7,
          child: Card(
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isCloth ? Image.asset('assets/images/clothes.png') : Image.asset('assets/images/food.png'),
                  Text(
                    'Process ID',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff9F9F9F)),
                  ),
                  Text('ORD-1256778', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  Divider(color: Color(0xffFCD06B), height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff9F9F9F),
                              ),
                            ),
                            Text(
                              'Thrive Early Learning Centre -Dar Al Orman',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff9F9F9F),
                              ),
                            ),
                            Text(
                              'Thrive Early Learning Centre -th5th',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Placed by',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff9F9F9F),
                              ),
                            ),
                            Text(
                              'Today at 4:00pm',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Arrived in',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff9F9F9F),
                              ),
                            ),
                            Text(
                              'Today at 4:15pm',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Color(0xffFCD06B), height: 20),
                  Text(
                    'You Can Contact With One Of Our Team',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff9F9F9F)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 69,
                    decoration: BoxDecoration(
                      color: Color(0xffe6ecfa),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              'https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 6),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(
                                'Pickup Partner',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff9F9F9F),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Michel Johnson',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff000000),
                                ),
                              ),
                              Spacer(flex: 2),
                            ],
                          ),
                          Spacer(),
                          RotatedBox(
                            quarterTurns: 3,
                            child: Icon(Icons.call, size: 30, color: Color(0xff242760)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 37,
                    width: 137,
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
