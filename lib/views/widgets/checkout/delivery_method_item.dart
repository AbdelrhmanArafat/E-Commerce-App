import 'package:ecommerce/models/delivery_method.dart';
import 'package:flutter/material.dart';

class DeliveryMethodItem extends StatelessWidget {
  final DeliveryMethodModel deliveryMethodModel;

  const DeliveryMethodItem({
    super.key,
    required this.deliveryMethodModel,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.network(
              deliveryMethodModel.imageUrl,
              fit: BoxFit.cover,
              height: 30,
            ),
            const SizedBox(height: 6),
            Text(
              "${deliveryMethodModel.days} days",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
