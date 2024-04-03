import 'dart:io';

import 'package:flutter/material.dart';

import 'flavor_config.dart';

const double _kHeightBanner = 12.0;
const double _kOffsetBanner = 40.0;
final double _kSizeTriangle =
    _kOffsetBanner + 0.707 * _kHeightBanner * (Platform.isIOS ? 2 : 3);

class FlavorBanner extends StatelessWidget {
  final Widget child;
  final BannerConfig? bannerConfig;

  const FlavorBanner({
    Key? key,
    required this.child,
    this.bannerConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You need to make sure your flavor banner doesn't show up in production.
    // If you want to show the banner in production, delete this line below.
    if (FlavorConfig.isProduction()) return child;
    BannerConfig config = bannerConfig ?? _getDefaultBanner();

    return Stack(
      children: <Widget>[
        child,
        _buildBanner(
          context: context,
          bannerConfig: config,
        ),
      ],
    );
  }

  BannerConfig _getDefaultBanner() {
    return BannerConfig(
      bannerName: FlavorConfig.instance.name,
      bannerColor: FlavorConfig.instance.color,
    );
  }

  // Creating banner allies so the banner will not be too long and overlap the UI.
  String getBannerAlias(String bannerName) {
    switch (bannerName) {
      case "production":
        return "PROD";

      case "staging":
        return "STAGE";

      case "dev":
        return "DEV";

      default:
        return "";
    }
  }

  Widget _buildBanner({
    required BuildContext context,
    required BannerConfig bannerConfig,
    BannerLocation location = BannerLocation.topStart,
  }) {
    return CustomPaint(
      painter: BannerPainter(
        message: getBannerAlias(bannerConfig.bannerName),
        textDirection: TextDirection.ltr,
        layoutDirection: TextDirection.ltr,
        location: location,
        color: bannerConfig.bannerColor,
      ),
      child: ClipPath(
        clipper: _TriangleClipper(location: location),
        child: Container(
          width: _kSizeTriangle,
          height: _kSizeTriangle,
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class BannerConfig {
  final String bannerName;
  final Color bannerColor;

  BannerConfig({required this.bannerName, required this.bannerColor});
}

class _TriangleClipper extends CustomClipper<Path> {
  _TriangleClipper({
    required this.location,
  });

  BannerLocation location;

  @override
  Path getClip(Size size) {
    final path = Path();
    if (location == BannerLocation.topStart) {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, Platform.isIOS ? 0 : size.height / 4);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    }
    if (location == BannerLocation.topEnd) {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, Platform.isIOS ? 0 : size.height / 4);
      path.lineTo(0, 0);
    }
    if (location == BannerLocation.bottomStart) {
      path.lineTo(0, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    }
    if (location == BannerLocation.bottomEnd) {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(size.width, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
