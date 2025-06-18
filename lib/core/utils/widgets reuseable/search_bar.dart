import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/kids/presentation/pages/kids_filter_view.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: screenHeight * 0.055, // ارتفاع مشابه للصورة
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: const Text('Search...', style: TextStyle(color: Colors.grey)),
            ),
          ),
          SizedBox(width: screenWidth * 0.025), // مسافة بسيطة بين السيرش والزر
          Container(
            width: screenHeight * 0.05,
            height: screenHeight * 0.05,
            decoration: const BoxDecoration(color: Color(0xFF20255B), shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.tune, color: Colors.white, size: 18),
              onPressed: () => context.push(const KidsFilterView()),
              padding: EdgeInsets.zero,
              splashRadius: screenHeight * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
