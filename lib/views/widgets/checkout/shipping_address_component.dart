import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/shipping_address.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressComponent extends StatelessWidget {
  final ShippingAddressModel shippingAddress;

  const ShippingAddressComponent({super.key, required this.shippingAddress});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.shippingAddressesPageRoute,
                    arguments: database,
                  ),
                  child: Text(
                    'Change',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              shippingAddress.address,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${shippingAddress.city},'
              ' ${shippingAddress.state},'
              ' ${shippingAddress.country}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
