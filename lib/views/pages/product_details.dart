import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/add_to_cart.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:ecommerce/views/widgets/drop_down_menu.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorite = false;
  late String dropDownValue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imageUrl,
              height: size.height * 0.55,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // dropDownMenu, Favorite Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: DropDownMenuComponent(
                            hint: 'Size',
                            items: const ['S', 'M', 'L', 'XL', 'XXL'],
                            onChanged: (String? value) {
                              dropDownValue = value!;
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$ ${widget.product.price}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.category!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.withOpacity(0.9),
                        ),
                  ),
                  Text(
                    'This is a dummy description for this product!'
                    ' I think we will add it in the future! I need to add more lines,'
                    ' so I add these words just to have more than two lines!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  // Add to Cart Button
                  MainButton(
                    onPressed: () async {
                      try {
                        final addToCart = AddToCartModel(
                          id: documentIdFromLocalData(),
                          productId: widget.product.id,
                          title: widget.product.title,
                          price: widget.product.price,
                          imageUrl: widget.product.imageUrl,
                          size: dropDownValue,
                        );
                        await database.addToCart(addToCart);
                      } on Exception catch (_) {
                        return MainDialog(
                          context: context,
                          title: 'Error',
                          content: 'Couldn\'t add to cart, please try again!',
                        ).showAlertDialog();
                      }
                    },
                    text: 'Add to Cart',
                    hasCircleBorder: true,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
