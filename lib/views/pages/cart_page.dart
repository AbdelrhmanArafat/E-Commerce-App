import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/add_to_cart.dart';
import 'package:ecommerce/views/widgets/cart_list_item.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalAmount = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final myProducts = await Provider.of<Database>(context, listen: false)
        .myProductCart()
        .first;
    myProducts.forEach(
      (products) {
        totalAmount += products.price;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
          stream: database.myProductCart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final cartItems = snapshot.data;
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'My Cart',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 16),
                      if (cartItems == null || cartItems.isEmpty)
                        Center(
                          child: Text(
                            'No items in the cart',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      if (cartItems != null && cartItems.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CartListItem(
                              cartItem: cartItems[index],
                            );
                          },
                        ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                          Text(
                            totalAmount.toString(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      MainButton(
                        onPressed: () {},
                        text: 'Checkout',
                        hasCircleBorder: true,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
