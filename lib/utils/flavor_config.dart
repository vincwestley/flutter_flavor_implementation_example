import 'package:flutter/material.dart';

// Define an enum for every environment you want to create.
enum Flavor { prod, staging, dev }

// Add more values as needed.
class FlavorValues {
  final String apiBaseUrl;
  final String appIcon;
  final String appName;

  FlavorValues({
    required this.apiBaseUrl,
    required this.appIcon,
    required this.appName,
  });
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static late FlavorConfig _instance;

  factory FlavorConfig({
    required Flavor flavor,
    // Color is an optional value that will be used for the flavor banner.
    // Flavor banner is one way to identify the environment you used.
    // You can remove this line of code if you don't need it.
    Color color = Colors.blue,
    required FlavorValues values,
  }) {
    _instance = FlavorConfig._internal(flavor, flavor.name, color, values);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  static FlavorConfig get instance {
    return _instance;
  }

  // Method to check your current environment in your realtime code
  static bool isDevelopment() => _instance.flavor == Flavor.dev;

  static bool isStaging() => _instance.flavor == Flavor.staging;

  static bool isProduction() => _instance.flavor == Flavor.prod;
}
