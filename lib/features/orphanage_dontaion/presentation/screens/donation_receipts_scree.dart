import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/cubit/orphanage_donation_state_cubit.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/screens/receipt_screen.dart';
import 'package:shimmer/shimmer.dart';

class DonationReceiptsScree extends StatefulWidget {
  const DonationReceiptsScree({super.key});

  @override
  State<DonationReceiptsScree> createState() => _DonationReceiptsScreeState();
}

class _DonationReceiptsScreeState extends State<DonationReceiptsScree> {
  final requestsStates = List.unmodifiable([
    GetDonationsLoading,
    GetDonationsSuccess,
    GetDonationsFail,
  ]);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrphanageDonationCubit, OrphanageDonationStateState>(
      buildWhen: (previous, current) =>
          requestsStates.contains(current.runtimeType),
      builder: (context, state) {
        if (state is GetDonationsLoading) {
          return ListView.separated(
            itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                height: 120,
                color: Colors.white,
              ),
            ),
            separatorBuilder: (_, __) => SizedBox(height: 8),
            itemCount: 10,
          );
        }

        if (state is GetDonationsFail) {
          return Center(
            child: Text(state.message, style: context.textTheme.headlineLarge),
          );
        }

        if (state is GetDonationsSuccess) {
          // if (false) {
          //   return Center(
          //     child: Text(
          //       'No receipt yet',
          //       style: context.textTheme.headlineLarge,
          //     ),
          //   );
          // }
          // final requests = state;
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppPalette.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset(AssetsImages.care, width: 50),
                    SizedBox(height: 8),
                    Text(
                      ' This Month\'s Summary Number of donors: 1',
                      textAlign: TextAlign.center,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  // itemCount: requests.length,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final imageUrl =
                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
                    final childName = 'Ali';

                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffe6ecfa),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 85,
                                height: 85,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage: imageUrl.isNotEmpty
                                      ? CachedNetworkImageProvider(imageUrl)
                                      : null,
                                  child: imageUrl.isEmpty
                                      ? Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                spacing: 6,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    childName,
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w900,
                                          color: AppPalette.primaryColor,
                                        ),
                                  ),
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.shirt,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Clothes',
                                        style: context.textTheme.headlineLarge,
                                      ),
                                    ],
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'ID: ',
                                          style: context.textTheme.headlineLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.grey,
                                              ),
                                        ),
                                        TextSpan(
                                          text: '#c-1234',
                                          style: context.textTheme.headlineLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppPalette.primaryColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Date',
                                style: context.textTheme.headlineLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                              ),
                              Text(
                                DateFormat(
                                  'MMMM dd, yyyy',
                                ).format(DateTime.now()),
                                style: context.textTheme.headlineLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.push(
                                    ReceiptScreen(
                                      orphanageImage: imageUrl,
                                      orphanageName: childName,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: Text(
                                  'View receipts',
                                  style: context.textTheme.headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
