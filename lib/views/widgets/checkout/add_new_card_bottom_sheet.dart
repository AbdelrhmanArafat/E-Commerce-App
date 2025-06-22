import 'package:ecommerce/controllers/cubit/checkout_cubit.dart';
import 'package:ecommerce/models/payment_method.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  const AddNewCardBottomSheet({super.key});

  @override
  State<AddNewCardBottomSheet> createState() => _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState extends State<AddNewCardBottomSheet> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController cardHolderNameController;
  late final TextEditingController cardNumberController;
  late final TextEditingController expireDateController;
  late final TextEditingController cvvController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    cardHolderNameController = TextEditingController();
    cardNumberController = TextEditingController();
    expireDateController = TextEditingController();
    cvvController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return SizedBox(
      height: size.height * 0.7,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Add New Card',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Card Holder Name Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: cardHolderNameController,
                decoration: const InputDecoration(
                  labelText: 'Card Holder Name',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter card holder name'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // Card Number Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  String digitsOnly = value.replaceAll(' - ', '');

                  if (digitsOnly.length > 16) {
                    digitsOnly = digitsOnly.substring(0, 16);
                  }

                  String formatted = '';

                  for (int i = 0; i < digitsOnly.length; i++) {
                    formatted += digitsOnly[i];
                    if ((i + 1) % 4 == 0 && i + 1 != digitsOnly.length) {
                      formatted += ' - ';
                    }
                  }

                  final cursorPosition = formatted.length;

                  cardNumberController.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(offset: cursorPosition),
                  );
                },
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter card number'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // Expire Date Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: expireDateController,
                decoration: const InputDecoration(
                  labelText: 'Expire Date',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  String digitsOnly = value.replaceAll('/', '');

                  if (digitsOnly.length > 4) {
                    digitsOnly = digitsOnly.substring(0, 4);
                  }

                  String formatted = '';
                  for (int i = 0; i < digitsOnly.length; i++) {
                    if (i == 2) {
                      formatted += '/';
                    }
                    formatted += digitsOnly[i];
                  }

                  expireDateController.value = TextEditingValue(
                    text: formatted,
                    selection:
                        TextSelection.collapsed(offset: formatted.length),
                  );
                },
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter expire date'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // CVV Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length > 3) {
                    value = value.substring(0, 3);
                  }
                  cvvController.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                },
                validator: (value) =>
                    value != null && value.isEmpty ? 'Please enter CVV' : null,
              ),
            ),
            const SizedBox(height: 16),
            // Add Card Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<CheckoutCubit, CheckoutState>(
                bloc: checkoutCubit,
                listenWhen: (previous, current) =>
                    current is CardsAdded || current is CardsAddedFailed,
                listener: (context, state) {
                  if (state is CardsAdded) {
                    Navigator.pop(context);
                  } else if (state is CardsAddedFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    current is AddingCards ||
                    current is CardsAdded ||
                    current is CardsAddedFailed,
                builder: (context, state) {
                  if (State is AddingCards) {
                    return MainButton(
                      onPressed: null,
                      child: const CircularProgressIndicator.adaptive(),
                    );
                  }
                  return MainButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final paymentMethod = PaymentMethodModel(
                          id: DateTime.now().toIso8601String(),
                          cardHolderName: cardHolderNameController.text,
                          cardNumber: cardNumberController.text,
                          expireDate: expireDateController.text,
                          cvv: cvvController.text,
                        );
                        await checkoutCubit.addCard(paymentMethod);
                      }
                    },
                    text: 'Add Card',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
