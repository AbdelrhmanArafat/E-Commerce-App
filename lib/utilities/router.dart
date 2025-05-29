import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utilities/arguments_model/add_shipping_address_arguments.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/pages/auth_page.dart';
import 'package:ecommerce/views/pages/bottom_nav_bar_page.dart';
import 'package:ecommerce/views/pages/checkout/add_shipping_address_page.dart';
import 'package:ecommerce/views/pages/checkout/checkout_page.dart';
import 'package:ecommerce/views/pages/checkout/shipping_addresses_page.dart';
import 'package:ecommerce/views/pages/home_page.dart';
import 'package:ecommerce/views/pages/landing_page.dart';
import 'package:ecommerce/views/pages/product_details.dart';
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
    case AppRoutes.productDetailsPageRoute:
      final product = settings.arguments as ProductModel;
      return CupertinoPageRoute(
        builder: (_) => ProductDetailsPage(product: product),
        settings: settings,
      );
    case AppRoutes.checkoutPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const CheckoutPage(),
        settings: settings,
      );
    case AppRoutes.addShippingAddressPageRoute:
      final arguments = settings.arguments as AddShippingAddressArguments;
      final shippingAddress = arguments.shippingAddress;
      return CupertinoPageRoute(
        builder: (_) => AddShippingAddressPage(
          shippingAddress: shippingAddress,
        ),
        settings: settings,
      );
    case AppRoutes.shippingAddressesPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const ShippingAddressesPage(),
        settings: settings,
      );
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
        settings: settings,
      );
  }
}
