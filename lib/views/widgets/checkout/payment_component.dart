import 'package:ecommerce/utilities/assets.dart';
import 'package:flutter/material.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Image.network(
              AppAssets.masterCardIcon,
              fit: BoxFit.cover,
              height: 30,
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text('**** **** **** 9308'),
      ],
    );
  }
}
