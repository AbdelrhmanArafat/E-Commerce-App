import 'package:ecommerce/controllers/cubits/checkout/checkout_cubit.dart';
import 'package:ecommerce/utilities/arguments_model/add_shipping_address_arguments.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/widgets/checkout/shipping_addresses_items.dart';
import 'package:ecommerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckoutCubit>(context).getShippingAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
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
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            bloc: checkoutCubit,
            buildWhen: (previous, current) =>
                current is FetchingAddresses ||
                current is AddressesFetched ||
                current is AddressesFetchFailed,
            builder: (context, state) {
              if (state is FetchingAddresses) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is AddressesFetchFailed) {
                return Center(
                  child: MainDialog(
                    context: context,
                    title: 'Error',
                    content: state.error,
                  ).showAlertDialog(),
                );
              } else if (state is AddressesFetched) {
                final shippingAddresses = state.shippingAddresses;
                return Column(
                  children: shippingAddresses
                      .map(
                        (shippingAddress) => ShippingAddressesItems(
                          shippingAddress: shippingAddress,
                        ),
                      )
                      .toList(),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AppRoutes.addShippingAddressPageRoute,
          arguments: AddShippingAddressArguments(
            checkoutCubit: checkoutCubit,
          ),
        ),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
