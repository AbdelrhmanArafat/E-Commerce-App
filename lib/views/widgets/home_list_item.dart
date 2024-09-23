import 'package:ecommerce/models/porduct.dart';
import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  final ProductModel product;

  const HomeListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 50,
                  width: 30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '${product.discount}%',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product.category!,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            product.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            '${product.price} \$',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
