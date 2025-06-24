import 'package:flutter/material.dart';

void showSnackBar(context, String message) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.grey.shade300,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    ),
    padding: const EdgeInsets.all(30),
    duration: const Duration(milliseconds: 2000),
    content: Center(
      child: Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
    ),
  ),
);
