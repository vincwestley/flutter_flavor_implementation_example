import 'package:flutter/material.dart';
import 'package:flutter_flavor_implementation_example/presentations/home_page.dart';
import 'package:flutter_flavor_implementation_example/utils/flavor_banner.dart';
import 'package:flutter_flavor_implementation_example/utils/flavor_config.dart';

void initializeApp() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlavorConfig.instance.values.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (_, child) {
        return FlavorBanner(
          child: child ?? const SizedBox(),
        );
      },
      home: HomePage(title: FlavorConfig.instance.values.appName),
    );
  }
}
