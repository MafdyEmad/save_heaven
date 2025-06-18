import 'package:flutter/material.dart';

class DonateItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const DonateItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: width * 0.65,
            height: width * 0.65,
            fit: BoxFit.contain,
          ),
          SizedBox(height: width * 0.015),
          Text(
            title,
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: width * 0.04),
        ],
      ),
    );
  }
}
