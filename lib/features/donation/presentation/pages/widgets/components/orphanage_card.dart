import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/donation/presentation/pages/donation_type_page.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';

class OrphanageCard extends StatelessWidget {
  final Orphanage model;

  const OrphanageCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.035,
        horizontal: width * 0.03,
      ),
      height: width * 0.6,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: ApiEndpoints.imageProvider + (model.image ?? ''),
              errorWidget: (context, url, error) => const Icon(Icons.person),
            ),
          ),
          SizedBox(height: width * 0.01),
          Text(
            model.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.03,
            ),
          ),
          SizedBox(height: width * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsImages.visa, width: 24, height: 24),
              const SizedBox(width: 4),
              Image.asset(AssetsImages.mastarCard, width: 24, height: 24),
            ],
          ),
          SizedBox(height: width * 0.02),
          ElevatedButton(
            onPressed: () {
              context.push(DonationTypePage(orphanageId: model.id));
            },
            child: Text(
              'Donate♡',
              style: context.textTheme.headlineLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: width * 0.02),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 6),
          //     child: Text(
          //       model.address,
          //       textAlign: TextAlign.center,
          //       style: TextStyle(fontSize: width * 0.03, color: Colors.black54),
          //       maxLines: 3,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
