import 'package:ecommerce/views/widgets/order_summary_component.dart';
import 'package:flutter/material.dart';

class CheckoutDeliveryDetails extends StatelessWidget {
  const CheckoutDeliveryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OrderSummaryComponent(title: 'Order', value: '125\$'),
        SizedBox(height: 8),
        OrderSummaryComponent(title: 'Delivery', value: '15\$'),
        SizedBox(height: 8),
        OrderSummaryComponent(title: 'Summary', value: '140\$'),
      ],
    );
  }
}
