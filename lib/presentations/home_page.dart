import 'package:flutter/material.dart';
import 'package:flutter_flavor_implementation_example/utils/flavor_config.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You currently running the app using ${FlavorConfig.instance.name} env',
            ),
            Text(
              "\nYour current environment base url is \n${FlavorConfig.instance.values.apiBaseUrl}",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
