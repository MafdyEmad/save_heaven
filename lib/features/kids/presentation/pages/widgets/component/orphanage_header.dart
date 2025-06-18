import 'package:flutter/material.dart';

class OrphanageHeader extends StatelessWidget {
  final String imagePath;
  final String name;
  final String city;
  final int kidsCount;

  const OrphanageHeader({
    super.key,
    required this.imagePath,
    required this.name,
    required this.city,
    required this.kidsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Text("$city - $kidsCount أطفال",
                    style: const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
