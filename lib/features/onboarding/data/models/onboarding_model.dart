import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final List<Color> gradientColors;
  final IconData iconData;
  final String? additionalInfo;

  const OnboardingModel({
    required this.title,
    required this.description,
    required this.gradientColors,
    required this.iconData,
    this.additionalInfo,
  });
}
