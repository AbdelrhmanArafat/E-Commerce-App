import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/pages/auth_page.dart';
import 'package:ecommerce/views/pages/bottom_nav_bar_page.dart';
import 'package:ecommerce/views/pages/home_page.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.authPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
    case AppRoutes.homePageRoute:
      return CupertinoPageRoute(
        builder: (_) => const HomePage(),
        settings: settings,
      );
    case AppRoutes.bottomNavBarPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const BottomNavBarPage(),
        settings: settings,
      );
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => Container(),
      );
  }
}
