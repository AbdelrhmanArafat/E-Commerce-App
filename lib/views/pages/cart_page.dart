import 'package:ecommerce/controllers/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/widgets/cart_list_item.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/main_dialog.dart';
import 'package:ecommerce/views/widgets/order_summary_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return SafeArea(
      child: BlocBuilder<CartCubit, CartState>(
        bloc: cartCubit,
        buildWhen: (previous, current) =>
            current is CartLoading ||
            current is CartLoaded ||
            current is CartError,
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CartLoaded) {
            final totalAmount = state.totalAmount;
            final cartItems = state.cartProducts;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: RefreshIndicator(
                onRefresh: () async {
                  await cartCubit.fetchCartProducts();
                },
                child: ListView(
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
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                    ),
                    const SizedBox(height: 16),
                    if (cartItems.isEmpty)
                      Center(
                        child: Text(
                          'No items in the cart',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    if (cartItems.isNotEmpty)
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
                    OrderSummaryComponent(
                      title: 'Total Amount',
                      value: totalAmount.toString(),
                    ),
                    const SizedBox(height: 32),
                    MainButton(
                      onPressed: () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed(AppRoutes.checkoutPageRoute),
                      text: 'Checkout',
                      hasCircleBorder: true,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          } else if (state is CartError) {
            return MainDialog(
              context: context,
              title: 'Error',
              content: state.errorMessage,
            ).showAlertDialog();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
