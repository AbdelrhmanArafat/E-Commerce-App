import 'package:ecommerce/controllers/cubits/checkout/checkout_cubit.dart';
import 'package:ecommerce/models/shipping_address.dart';

class AddShippingAddressArguments {
  final ShippingAddressModel? shippingAddress;
  final CheckoutCubit checkoutCubit;

  const AddShippingAddressArguments({
    this.shippingAddress,
    required this.checkoutCubit,
  });
}
