import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';

class ReceiptScreen extends StatefulWidget {
  final String orphanageImage;
  final String orphanageName;
  const ReceiptScreen({super.key, required this.orphanageImage, required this.orphanageName});

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
            SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: widget.orphanageImage,
                errorWidget: (context, url, error) => Icon(Icons.person),
              ),
            ),
            Text(widget.orphanageName),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPagePadding),
        child: Column(
          children: [
            Text('DONATION  RECEIPT', style: context.textTheme.titleLarge),
            SizedBox(height: 20),
            _buildInformations('date', DateFormat('MMMM dd, yyyy').format(DateTime.now())),
            Divider(height: 50),
            _buildInformations('Receipt number', 'd-23-233'),
            Divider(height: 50),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Donation Type',
                    style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'clothes',
                    style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Quantity: 10 pieces',
                    style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Washed and packed: Yes',
                    style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),

            Divider(height: 50),
            _buildInformations('donation method', ' picked up from home'),
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
            style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: Text(info, style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }
}
