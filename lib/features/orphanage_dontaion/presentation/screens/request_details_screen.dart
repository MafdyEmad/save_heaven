import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/models/adoption_requests.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/cubit/orphanage_donation_state_cubit.dart';

class RequestDetailsScreen extends StatefulWidget {
  final AdoptionRequestsModel request;
  const RequestDetailsScreen({super.key, required this.request});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final bloc = getIt<OrphanageDonationCubit>();
  final states = List.unmodifiable([
    RespondToRequestLoading,
    RespondToRequestSuccess,
    RespondToRequestFail,
  ]);
  late final Color statusColor;
  @override
  void initState() {
    statusColor = switch (widget.request.status) {
      'pending' => Colors.blue,
      'approved' => Colors.green,
      'rejected' => Colors.red,
      _ => Colors.blue,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.request.child.image.isEmpty
        ? ''
        : ApiEndpoints.imageProvider + widget.request.child.image;
    return BlocProvider.value(
      value: bloc,

      child: BlocListener<OrphanageDonationCubit, OrphanageDonationStateState>(
        listener: (context, state) {
          if (state is RespondToRequestSuccess) {
            context.pop();
            context.pop();
            bloc.getRequests();
          }
          if (state is RespondToRequestFail) {
            context.pop();
            showSnackBar(context, 'Failed to respond to request');
          }
          if (state is RespondToRequestLoading) {
            showLoading(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPagePadding,
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    width: double.infinity,
                    height: context.width * .3,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.person, size: 40, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.request.child.name,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppPalette.primaryColor,
                    ),
                  ),
                  Wrap(
                    children: [
                      Text(
                        '${DateTime.now().year - widget.request.child.birthdate.year + 1}-year-old',
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        widget.request.child.gender,
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        '${widget.request.child.skinTone} skin tone',
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        '${widget.request.child.hairColor} hair color',
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        'with ${widget.request.child.hairStyle} hair style',
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        '${widget.request.child.eyeColor} eye color',
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        widget.request.child.personality,
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        widget.request.child.religion,
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.request.child.gender,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: AppPalette.primaryColor,
                    ),
                  ),
                  Divider(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: context.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'MMMM dd, yyyy',
                        ).format(widget.request.createdAt),
                        style: context.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 50),
                  Text(
                    "application information",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppPalette.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInformations(
                    'submitted name',
                    widget.request.user.name,
                  ),
                  Divider(),
                  // _buildInformations(
                  //   'Birth date',
                  //   DateFormat('dd/mm/yyyy').format( widget.request.user.),
                  // ),
                  // Divider(),
                  _buildInformations(
                    'martial status',
                    widget.request.maritalStatus,
                  ),
                  Divider(),
                  _buildInformations('occupation', widget.request.occupation),
                  Divider(),
                  _buildInformations(
                    'monthly income',
                    widget.request.monthlyIncome.toString(),
                  ),
                  Divider(),
                  _buildInformations('location', widget.request.location),
                  Divider(),
                  _buildInformations('phone number', widget.request.phone),
                  Divider(),
                  SizedBox(height: 20),
                  Text(
                    'why do you want to adopt?',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      widget.request.reason,
                      style: context.textTheme.bodyLarge,
                    ),
                  ),

                  SizedBox(height: 20),
                  if (widget.request.status == 'pending') ...[
                    SizedBox(
                      width: context.width * .6,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        onPressed: () {
                          bloc.respondToRequest(widget.request.id, 'approved');
                        },
                        child: Text(
                          'Accept Request',
                          style: context.textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: context.width * .6,
                      height: 50,
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        onPressed: () {
                          bloc.respondToRequest(widget.request.id, 'rejected');
                        },
                        child: Text(
                          "Reject Request",
                          style: context.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ] else ...[
                    Text(
                      widget.request.status,
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: statusColor,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformations(String infoHeader, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            infoHeader,
            style: context.textTheme.headlineLarge?.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Align(
            // alignment: AlignmentDirectional.topEnd,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              info,
              style: context.textTheme.headlineLarge?.copyWith(
                color: AppPalette.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
