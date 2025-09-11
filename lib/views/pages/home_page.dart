import 'package:ecommerce/controllers/cubits/home/home_cubit.dart';
import 'package:ecommerce/utilities/assets.dart';
import 'package:ecommerce/views/widgets/header_of_list.dart';
import 'package:ecommerce/views/widgets/home_list_item.dart';
import 'package:ecommerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return SafeArea(
      top: false,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        buildWhen: (previous, current) =>
            current is HomeSuccess ||
            current is HomeLoading ||
            current is HomeFailure,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is HomeFailure) {
            return Center(
              child: MainDialog(
                context: context,
                title: 'Error',
                content: state.error,
              ).showAlertDialog(),
            );
          } else if (state is HomeSuccess) {
            final salesProducts = state.salesProduct;
            final newProducts = state.newProduct;
            return SingleChildScrollView(
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: HomeListItem(
                                product: salesProducts[index],
                                isNew: false,
                              ),
                            ),
                            itemCount: salesProducts.length,
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: HomeListItem(
                                product: newProducts[index],
                                isNew: true,
                              ),
                            ),
                            itemCount: newProducts.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
