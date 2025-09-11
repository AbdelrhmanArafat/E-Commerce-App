import 'package:ecommerce/controllers/cubits/product_details/product_details_cubit.dart';
import 'package:ecommerce/views/widgets/drop_down_menu.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorite = false;
  late String dropDownValue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: productDetailsCubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is ProductDetailsError) {
          return Scaffold(
            body: Center(
              child: MainDialog(
                context: context,
                title: 'Error',
                content: state.errorMessage,
              ).showAlertDialog(),
            ),
          );
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                product.title,
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
                    product.imageUrl,
                    height: size.height * 0.55,
                    width: double.infinity,
                    fit: BoxFit.fill,
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
                                  onChanged: (String? value) => productDetailsCubit.setSize(value!),
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
                                      color: isFavorite
                                          ? Colors.red
                                          : Colors.black45,
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
                              product.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "\$ ${product.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.category!,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                        BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
                          bloc: productDetailsCubit,
                          listenWhen: (previous, current) =>
                              current is AddedToCart ||
                              current is AddToCartError,
                          listener: (context, state) {
                            if (state is AddedToCart) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Product added to cart!'),
                                ),
                              );
                            } else if (state is AddToCartError) {
                              MainDialog(
                                context: context,
                                title: 'Error',
                                content: state.errorMessage,
                              ).showAlertDialog();
                            }
                          },
                          builder: (context, state) {
                            if (state is AddingToCart) {
                              return MainButton(
                                child: const CircularProgressIndicator.adaptive(),
                              );
                            }
                            return MainButton(
                              onPressed: () async =>
                                  await productDetailsCubit.addToCart(product),
                              text: 'Add to Cart',
                              hasCircleBorder: true,
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
