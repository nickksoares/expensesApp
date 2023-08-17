import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextFiled extends StatelessWidget {
  const AdaptativeTextFiled(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.onSubmitted,
      required this.label});

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CupertinoTextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            placeholder: label,
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 12
            ),
          ),
        )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(labelText: label));
  }
}
