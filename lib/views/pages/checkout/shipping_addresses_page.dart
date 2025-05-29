import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/shipping_address.dart';
import 'package:ecommerce/utilities/arguments_model/add_shipping_address_arguments.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/widgets/checkout/shipping_addresses_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Addresses',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: StreamBuilder<List<ShippingAddressModel>>(
            stream: database.getShippingAddresses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final shippingAddress = snapshot.data;
                return Column(
                  children: shippingAddress!
                      .map(
                        (shippingAddress) => ShippingAddressesItems(
                          shippingAddress: shippingAddress,
                        ),
                      )
                      .toList(),
                );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AppRoutes.addShippingAddressPageRoute,
          arguments: AddShippingAddressArguments(database: database),
        ),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
