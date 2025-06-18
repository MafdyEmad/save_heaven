import 'package:flutter/material.dart';

Widget buildTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
