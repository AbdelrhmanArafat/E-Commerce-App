import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/delivery_method.dart';
import 'package:ecommerce/views/widgets/checkout/checkout_delivery_detials.dart';
import 'package:ecommerce/views/widgets/checkout/delivery_method_item.dart';
import 'package:ecommerce/views/widgets/checkout/payment_component.dart';
import 'package:ecommerce/views/widgets/checkout/shipping_address_component.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
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
              const ShippingAddressComponent(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  InkWell(
                    onTap: () {},
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
              const PaymentComponent(),
              const SizedBox(height: 24),
              Text(
                'Delivery Method',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              StreamBuilder<List<DeliveryMethodModel>>(
                  stream: database.myDeliveryMethodsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final deliveryMethods = snapshot.data;
                      if (deliveryMethods == null || deliveryMethods.isEmpty) {
                        return const Center(
                          child: Text('No delivery methods available'),
                        );
                      }
                      return SizedBox(
                        height: size.height * 0.13,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: deliveryMethods.length,
                          itemBuilder: (context, index) => DeliveryMethodItem(
                            deliveryMethodModel: deliveryMethods[index],
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
              const SizedBox(height: 32),
              const CheckoutDeliveryDetails(),
              const SizedBox(height: 64),
              MainButton(
                onPressed: () {},
                text: 'Submit Order',
                hasCircleBorder: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
