import 'package:ecommerce/controllers/cubits/checkout/checkout_cubit.dart';
import 'package:ecommerce/controllers/cubits/product_details/product_details_cubit.dart';
import 'package:ecommerce/models/shipping_address.dart';
import 'package:ecommerce/utilities/arguments_model/add_shipping_address_arguments.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/pages/auth_page.dart';
import 'package:ecommerce/views/pages/bottom_nav_bar_page.dart';
import 'package:ecommerce/views/pages/checkout/add_shipping_address_page.dart';
import 'package:ecommerce/views/pages/checkout/checkout_page.dart';
import 'package:ecommerce/views/pages/checkout/payment_methods_page.dart';
import 'package:ecommerce/views/pages/checkout/shipping_addresses_page.dart';
import 'package:ecommerce/views/pages/home_page.dart';
import 'package:ecommerce/views/pages/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      final productId = settings.arguments as String;
      return CupertinoPageRoute(
        builder: (_) => BlocProvider(
          create: (context) {
            final cubit = ProductDetailsCubit();
            cubit.fetchProductDetails(productId);
            return cubit;
          },
          child: const ProductDetailsPage(),
        ),
        settings: settings,
      );
    case AppRoutes.checkoutPageRoute:
      return CupertinoPageRoute(
        builder: (_) => BlocProvider(
          create: (context) {
            final cubit = CheckoutCubit();
            cubit.getCheckoutData();
            return cubit;
          },
          child: const CheckoutPage(),
        ),
        settings: settings,
      );
    case AppRoutes.addShippingAddressPageRoute:
      final argument = settings.arguments as AddShippingAddressArguments;
      final checkoutCubit = argument.checkoutCubit;
      final shippingAddress = argument.shippingAddress;
      return CupertinoPageRoute(
        builder: (_) => BlocProvider.value(
          value: checkoutCubit,
          child: AddShippingAddressPage(
            shippingAddress: shippingAddress,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.shippingAddressesPageRoute:
      final checkoutCubit = settings.arguments as CheckoutCubit;
      return CupertinoPageRoute(
        builder: (_) => BlocProvider.value(
          value: checkoutCubit,
          child: const ShippingAddressesPage(),
        ),
        settings: settings,
      );
    case AppRoutes.paymentMethodPageRoute:
      return CupertinoPageRoute(
        builder: (_) => BlocProvider(
          create: (context) {
            final cubit = CheckoutCubit();
            cubit.fetchCards();
            return cubit;
          },
          child: const PaymentMethodsPage(),
        ),
        settings: settings,
      );
    default:
      return CupertinoPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
  }
}
