import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/cubit/orphanage_donation_state_cubit.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/screens/request_details_screen.dart';
import 'package:shimmer/shimmer.dart';

class AdoptionsRequestsScreen extends StatefulWidget {
  const AdoptionsRequestsScreen({super.key});

  @override
  State<AdoptionsRequestsScreen> createState() => _AdoptionsRequestsScreenState();
}

class _AdoptionsRequestsScreenState extends State<AdoptionsRequestsScreen> {
  final bloc = getIt<OrphanageDonationCubit>();

  @override
  void initState() {
    bloc.getRequests();
    super.initState();
  }

  final requestsStates = List.unmodifiable([
    GetDonationsRequestsLoading,
    GetDonationsRequestsSuccess,
    GetDonationsRequestsFail,
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                  right: AppDimensions.horizontalPagePadding,
                  left: AppDimensions.horizontalPagePadding,
                  top: 18,
                ),
                child: Column(
                  children: [
                    TabBar(
                      labelStyle: context.textTheme.headlineMedium,
                      dividerColor: Colors.transparent,
                      indicatorColor: Color(0xfffcd06b),
                      tabs: [
                        Tab(text: 'Adoption Requests'),
                        Tab(text: 'Donation Receipts'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: BlocBuilder<OrphanageDonationCubit, OrphanageDonationStateState>(
                        buildWhen: (previous, current) => requestsStates.contains(current.runtimeType),
                        builder: (context, state) {
                          if (state is GetDonationsRequestsLoading) {
                            return ListView.separated(
                              itemBuilder: (context, index) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(width: double.infinity, height: 120, color: Colors.white),
                              ),
                              separatorBuilder: (_, __) => SizedBox(height: 8),
                              itemCount: 10,
                            );
                          }

                          if (state is GetDonationsRequestsFail) {
                            return Center(child: Text(state.message, style: context.textTheme.headlineLarge));
                          }

                          final requests = (state as GetDonationsRequestsSuccess).requests;

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
                                    Image.asset(AssetsImages.don, width: 50),
                                    SizedBox(height: 8),
                                    Text(
                                      'This Month\'s Summary Adopted Children: 12',
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.headlineMedium?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (_, __) => SizedBox(height: 12),
                                  itemCount: requests.length,
                                  itemBuilder: (context, index) {
                                    final imageUrl = 'asdasd';
                                    final requestId = '#1234';
                                    final childName = 'Ali';
                                    final applicantName = 'Ahmed';
                                    final status = requests[index].status;

                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Color(0xffe6ecfa),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional.topEnd,
                                            child: Text(
                                              status,
                                              style: context.textTheme.headlineMedium?.copyWith(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
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
                                                      ? Icon(Icons.person, size: 40, color: Colors.grey)
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    childName,
                                                    style: context.textTheme.titleLarge?.copyWith(
                                                      fontWeight: FontWeight.w900,
                                                      color: AppPalette.primaryColor,
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Request ID: ',
                                                          style: context.textTheme.headlineLarge?.copyWith(
                                                            fontWeight: FontWeight.w900,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: requestId,
                                                          style: context.textTheme.headlineLarge?.copyWith(
                                                            fontWeight: FontWeight.w500,
                                                            color: AppPalette.primaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Applicant Name: ',
                                                          style: context.textTheme.headlineLarge?.copyWith(
                                                            fontWeight: FontWeight.w900,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: applicantName,
                                                          style: context.textTheme.headlineLarge?.copyWith(
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
                                                style: context.textTheme.headlineLarge?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                                                style: context.textTheme.headlineLarge?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  context.push(RequestDetailsScreen());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(18),
                                                  ),
                                                ),
                                                child: Text(
                                                  'View details',
                                                  style: context.textTheme.headlineSmall?.copyWith(
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
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
