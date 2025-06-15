import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';

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
                  String newValue = value.replaceAll('-', '');
                  if(newValue.length % 4 == 0 && newValue.length < 16) {
                    cardNumberController.text += '-';
                  }
                  if(value.length >= 20) {
                    cardNumberController.text = value.substring(0, 19);
                  }
                },
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter card number'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
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
                  if (value.length == 2 && !value.contains('/')) {
                    expireDateController.text += '/';
                  }
                  if (value.length == 6 && value.contains('/')) {
                    expireDateController.text = value.substring(0, 5);
                  }
                },
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter expire date'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
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
                  if (value.length >= 3) {
                    cvvController.text = value.substring(0, 3);
                  }
                },
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter CVV'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MainButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                text: 'Save Card',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
