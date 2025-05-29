import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/shipping_address.dart';
import 'package:ecommerce/utilities/arguments_model/add_shipping_address_arguments.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressesItems extends StatefulWidget {
  final ShippingAddressModel shippingAddress;

  const ShippingAddressesItems({super.key, required this.shippingAddress});

  @override
  State<ShippingAddressesItems> createState() => _ShippingAddressesItemsState();
}

class _ShippingAddressesItemsState extends State<ShippingAddressesItems> {
  late bool checkValue;

  @override
  void initState() {
    super.initState();
    checkValue = widget.shippingAddress.isDefault;
  }

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
                  widget.shippingAddress.fullName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.addShippingAddressPageRoute,
                    arguments: AddShippingAddressArguments(
                      database: database,
                      shippingAddress: widget.shippingAddress,
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.shippingAddress.address,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${widget.shippingAddress.city},'
              ' ${widget.shippingAddress.state},'
              ' ${widget.shippingAddress.country}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text('Default Shipping Address'),
              value: checkValue,
              onChanged: (newValue) async {
                setState(() {
                  checkValue = newValue!;
                });
                final newAddress = widget.shippingAddress.copyWith(isDefault: newValue);
                await database.saveAddress(newAddress);
              },
              activeColor: Colors.black,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }
}
