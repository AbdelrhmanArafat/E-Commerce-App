import 'package:ecommerce/controllers/cubit/checkout_cubit.dart';
import 'package:ecommerce/views/widgets/checkout/add_new_card_bottom_sheet.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        centerTitle: true,
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        bloc: checkoutCubit,
        buildWhen: (previous, current) =>
            current is FetchingCards ||
            current is CardsFetched ||
            current is CardsFetchFailed,
        builder: (context, state) {
          if (state is FetchingCards) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CardsFetchFailed) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is CardsFetched) {
            final paymentMethods = state.paymentMethods;
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Payment Cards',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final paymentMethod = paymentMethods[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.credit_card),
                                    const SizedBox(width: 8),
                                    Text(paymentMethod.cardNumber),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {},
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: paymentMethods.length,
                    ),
                    const SizedBox(height: 16),
                    MainButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return BlocProvider.value(
                              value: checkoutCubit,
                              child: const AddNewCardBottomSheet(),
                            );
                          },
                        ).then(
                          (value) => checkoutCubit.fetchCards(),
                        );
                      },
                      text: 'Add New Card',
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('No payment methods available'),
            );
          }
        },
      ),
    );
  }
}
