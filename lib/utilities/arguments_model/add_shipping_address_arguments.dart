import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/shipping_address.dart';

class AddShippingAddressArguments {
  final Database database;
  final ShippingAddressModel? shippingAddress;

  const AddShippingAddressArguments({
    required this.database,
    this.shippingAddress,

  });
}