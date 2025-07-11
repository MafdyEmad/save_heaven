import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/models/donation_model.dart';

class ReceiptScreen extends StatefulWidget {
  final DonationModel item;
  const ReceiptScreen({super.key, required this.item});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(shape: BoxShape.circle),
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: ApiEndpoints.imageProvider + widget.item.donorImage,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Icon(Icons.person),
              ),
            ),
            SizedBox(width: 10),
            Text(widget.item.donorName),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPagePadding,
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('DONATION  RECEIPT', style: context.textTheme.titleLarge),
            SizedBox(height: 20),
            _buildInformations(
              'date',
              DateFormat('MMMM dd, yyyy').format(widget.item.createdAt),
            ),
            Divider(height: 50),
            _buildInformations(
              'Receipt number',
              widget.item.receiptNumber.substring(0, 4),
            ),
            Divider(height: 50),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Donation Type',
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    widget.item.itemType ?? '',
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (widget.item.itemType == 'money')
                    Text(
                      '${widget.item.amount}\$',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (widget.item.itemType == 'food')
                    Text(
                      'Food quantity: ${widget.item.foodQuantity}',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (widget.item.itemType == 'clothes')
                    Text(
                      '${widget.item.piecesCount} Pieces',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (widget.item.itemType == 'clothes')
                    Text(
                      'Clothing condition: ${widget.item.clothingCondition}',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (widget.item.itemType == 'food')
                    Text(
                      'Packed and ready for collection: ${widget.item.isReadyForPickup == true ? 'Yes' : 'No'}',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),

            Divider(height: 50),
            _buildInformations(
              'donation method',
              widget.item.deliveryMethod ?? '',
            ),
          ],
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
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: Text(
              info,
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
