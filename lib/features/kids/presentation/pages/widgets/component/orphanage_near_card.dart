import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/kids/data/models/orphanage_near_card_model.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/features/kids/presentation/pages/display_all_kids_view.dart';
import 'package:save_heaven/features/kids/presentation/pages/kids_home_view.dart';

class OrphanageNearCard extends StatelessWidget {
  final Orphanage orphanage;

  const OrphanageNearCard({super.key, required this.orphanage});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: ApiEndpoints.imageProvider + (orphanage.image ?? ''),
              errorWidget: (context, url, error) => const Icon(Icons.person),
            ),
          ),

          Text(
            orphanage.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.03,
            ),
          ),

          Text(
            orphanage.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.026, color: Colors.black54),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          CustomButton(
            text: "Adopt",
            onPressed: () {
              context.push(DisplayAllKidsView());
            },
            width: width * 0.42,
            height: width * 0.08,
            fontSize: width * 0.03,
            padding: EdgeInsets.zero,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }
}
