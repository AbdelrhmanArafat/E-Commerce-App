import 'package:ecommerce/models/porduct.dart';
import 'package:ecommerce/utilities/assets.dart';
import 'package:ecommerce/views/widgets/home_list_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildHeaderOfList(
    BuildContext context, {
    required String title,
    VoidCallback? onTap,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  buildHeaderOfList(
                    context,
                    title: 'Sale',
                    description: 'Super Summer Sale',
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: dummyProduct
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: HomeListItem(product: e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  buildHeaderOfList(
                    context,
                    title: 'New',
                    description: 'Super New Product!',
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: dummyProduct
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: HomeListItem(product: e),
                            ),
                          )
                          .toList(),
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
