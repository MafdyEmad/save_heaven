import 'package:flutter/material.dart';

class OrphanageCategoryItem extends StatelessWidget {
  final String title;
  final String iconPath;

  const OrphanageCategoryItem({super.key, required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          backgroundImage: AssetImage(iconPath),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
