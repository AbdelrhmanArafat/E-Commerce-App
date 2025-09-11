import 'package:ecommerce/controllers/cubits/checkout/checkout_cubit.dart';
import 'package:ecommerce/utilities/arguments_model/add_shipping_address_arguments.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/widgets/checkout/checkout_delivery_detials.dart';
import 'package:ecommerce/views/widgets/checkout/delivery_method_item.dart';
import 'package:ecommerce/views/widgets/checkout/payment_component.dart';
import 'package:ecommerce/views/widgets/checkout/shipping_address_component.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        bloc: checkoutCubit,
        buildWhen: (previous, current) =>
            current is CheckoutLoading ||
            current is CheckoutLoaded ||
            current is CheckoutLoadedFailed,
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CheckoutLoadedFailed) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is CheckoutLoaded) {
            final shippingAddresses = state.shippingAddresses;
            final deliveryMethods = state.deliveryMethods;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shopping Address',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    if (shippingAddresses == null) ...{
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'No shipping addresses available',
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () =>
                                  Navigator.of(context).pushNamed(
                                AppRoutes.addShippingAddressPageRoute,
                                arguments: AddShippingAddressArguments(
                                  checkoutCubit: checkoutCubit,
                                  shippingAddress: shippingAddresses,
                                ),
                              ),
                              child: Text(
                                'Add New Shipping Address',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Colors.redAccent,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    } else
                      ShippingAddressComponent(
                        shippingAddress: shippingAddresses,
                        checkoutCubit: checkoutCubit,
                      ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.paymentMethodPageRoute,
                            );
                          },
                          child: Text(
                            'Change',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Colors.redAccent,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const PaymentComponent(),
                    const SizedBox(height: 24),
                    Text(
                      'Delivery Method',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    if (deliveryMethods.isEmpty)
                      const Center(
                        child: Text('No delivery methods available'),
                      ),
                    SizedBox(
                      height: size.height * 0.13,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: deliveryMethods.length,
                        itemBuilder: (_, index) => DeliveryMethodItem(
                          deliveryMethodModel: deliveryMethods[index],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const CheckoutDeliveryDetails(),
                    const SizedBox(height: 64),
                    //submit order button
                    BlocConsumer<CheckoutCubit, CheckoutState>(
                      bloc: checkoutCubit,
                      listenWhen: (previous, current) =>
                          current is MakingPaymentFailed ||
                          current is PaymentMade,
                      listener: (context, state) {
                        if (state is MakingPaymentFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        } else if (state is PaymentMade) {
                          Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                          );
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is PaymentMade ||
                          current is MakingPaymentFailed ||
                          current is MakingPayment,
                      builder: (context, state) {
                        if (state is MakingPayment) {
                          return MainButton(
                            hasCircleBorder: true,
                            child: const CircularProgressIndicator.adaptive(),
                          );
                        }
                        return MainButton(
                          onPressed: () async =>
                              await checkoutCubit.makePayment(900),
                          text: 'Submit Order',
                          hasCircleBorder: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
