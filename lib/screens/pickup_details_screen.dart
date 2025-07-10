import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/features/donation/data/data_source/donation_remote_data_source.dart';
import 'package:save_heaven/features/donation/presentation/cubit/donation_cubit.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/screens/scheduled_done_screen.dart';

class PickupDetailsScreen extends StatefulWidget {
  final bool isCloth;
  final Orphanage orphanage;
  final DonationItems donationItems;
  const PickupDetailsScreen({
    super.key,
    required this.isCloth,
    required this.donationItems,
    required this.orphanage,
  });

  @override
  State<PickupDetailsScreen> createState() => _PickupDetailsScreenState();
}

class _PickupDetailsScreenState extends State<PickupDetailsScreen> {
  final bloc = getIt<DonationCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return BlocListener<DonationCubit, DonationState>(
            listener: (context, state) {
              if (state is DonationDonateSuccess) {
                context.pop();
                context.push(
                  ScheduledDoneScreen(
                    orphanage: widget.orphanage,
                    donationItems: widget.donationItems,
                  ),
                );
              } else if (state is DonationDonateFail) {
                context.pop();
                showSnackBar(context, state.message);
              } else if (state is DonationDonateLoading) {
                showLoading(context);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Pickup  Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back_ios, size: 26),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  // height: MediaQuery.sizeOf(context).height * .7,
                  height: MediaQuery.sizeOf(context).height * .6,
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.isCloth
                              ? Image.asset('assets/images/clothes.png')
                              : Image.asset('assets/images/food.png'),
                          // Text(
                          //   'Process ID',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w700,
                          //     color: Color(0xff9F9F9F),
                          //   ),
                          // ),
                          // Text(
                          //   'ORD-1256778',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w700,
                          //   ),
                          // ),
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
                                      widget.donationItems.deliveryLocation
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                      widget.orphanage.address,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
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
                                flex: 2,
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
                                      'Today at ${TimeOfDay.now().format(context)}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
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
                                      '${DateFormat('dd MMMM yyyy').format(DateTime.parse(widget.donationItems.deliveryDate!))} at ${widget.donationItems.deliveryTime.toString()}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Color(0xffFCD06B), height: 20),
                          // Text(
                          //   'You Can Contact With One Of Our Team',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w700,
                          //     color: Color(0xff9F9F9F),
                          //   ),
                          // ),
                          // SizedBox(height: 10),
                          // Container(
                          //   width: double.infinity,
                          //   height: 69,
                          //   decoration: BoxDecoration(
                          //     color: Color(0xffe6ecfa),
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Container(
                          //           width: 50,
                          //           height: 50,
                          //           clipBehavior: Clip.antiAliasWithSaveLayer,
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //           ),
                          //           child: Image.network(
                          //             'https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         SizedBox(width: 6),
                          //         Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Spacer(),
                          //             Text(
                          //               'Pickup Partner',
                          //               style: TextStyle(
                          //                 fontSize: 10,
                          //                 fontWeight: FontWeight.w500,
                          //                 color: Color(0xff9F9F9F),
                          //               ),
                          //             ),
                          //             SizedBox(height: 3),
                          //             Text(
                          //               'Michel Johnson',
                          //               style: TextStyle(
                          //                 fontSize: 12,
                          //                 fontWeight: FontWeight.w700,
                          //                 color: Color(0xff000000),
                          //               ),
                          //             ),
                          //             Spacer(flex: 2),
                          //           ],
                          //         ),
                          //         Spacer(),
                          //         RotatedBox(
                          //           quarterTurns: 3,
                          //           child: Icon(
                          //             Icons.call,
                          //             size: 30,
                          //             color: Color(0xff242760),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Spacer(),
                          SizedBox(
                            height: 37,
                            width: 137,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff242760),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                              onPressed: () {
                                print('asdasdasds');
                                bloc.donate(
                                  isMony: false,
                                  itemModel: widget.donationItems,
                                );
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
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
