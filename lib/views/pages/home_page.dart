import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utilities/assets.dart';
import 'package:ecommerce/views/widgets/header_of_list.dart';
import 'package:ecommerce/views/widgets/home_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  AppAssets.topBannerHomePageAsset,
                  width: double.infinity,
                  height: size.height * 0.3,
                  fit: BoxFit.fill,
                ),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.3,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Text(
                    'Street Clothes',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  HeaderOfList(
                    onTap: () {},
                    title: 'Sale',
                    description: 'Super Summer Sale',
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 330,
                    child: StreamBuilder<List<ProductModel>>(
                      stream: database.salesProductStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            return const Center(
                              child: Text('No Products Found!'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: HomeListItem(
                                product: products[index],
                                isNew: true,
                              ),
                            ),
                            itemCount: products.length,
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  HeaderOfList(
                    onTap: () {},
                    title: 'New',
                    description: 'Super New Product!',
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 330,
                    child: StreamBuilder<List<ProductModel>>(
                      stream: database.newProductStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            return const Center(
                              child: Text('No Products Found!'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: HomeListItem(
                                product: products[index],
                                isNew: true,
                              ),
                            ),
                            itemCount: products.length,
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
