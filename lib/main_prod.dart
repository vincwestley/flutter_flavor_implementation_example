import 'main.dart';
import 'utils/flavor_config.dart';

void main() async {
  FlavorConfig(
    flavor: Flavor.prod,
    values: FlavorValues(
      apiBaseUrl: "https://apibaseurl-prod.com",
      appIcon: "assets/images/app_icon_prod.png",
      appName: "Application Production",
    ),
  );

  // Call your main method in here
  initializeApp();
}
