import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/shipping_address.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddShippingAddressPage extends StatefulWidget {
  final ShippingAddressModel? shippingAddress;

  const AddShippingAddressPage({super.key, this.shippingAddress});

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  ShippingAddressModel? shippingAddress;

  @override
  void initState() {
    super.initState();
    shippingAddress = widget.shippingAddress;
    if (shippingAddress != null) {
      fullNameController.text = shippingAddress!.fullName;
      addressController.text = shippingAddress!.address;
      countryController.text = shippingAddress!.country;
      cityController.text = shippingAddress!.city;
      stateController.text = shippingAddress!.state;
      zipCodeController.text = shippingAddress!.zipCode;
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    addressController.dispose();
    countryController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

  Future<void> saveAddress(Database database) async {
    try {
      if (formKey.currentState!.validate()) {
        final address = ShippingAddressModel(
          id: shippingAddress != null
              ? shippingAddress!.id
              : documentIdFromLocalData(),
          fullName: fullNameController.text.trim(),
          address: addressController.text.trim(),
          country: countryController.text.trim(),
          city: cityController.text.trim(),
          state: stateController.text.trim(),
          zipCode: zipCodeController.text.trim(),
        );
        await database.saveAddress(address);
        if (!mounted) return;
        Navigator.of(context).pop();
      }
    } catch (e) {
      MainDialog(
        context: context,
        title: 'Error on Saving Address',
        content: e.toString(),
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          shippingAddress != null
              ? 'Editing Shipping Address'
              : 'Adding Shipping Address',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'FullName',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Full name is required',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Address is required',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'City is required',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(
                    labelText: 'state',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'state is required',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: zipCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Zip Code is required',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Country is required',
                ),
                const SizedBox(height: 32),
                MainButton(
                  onPressed: () => saveAddress(database),
                  text: 'Save Address',
                  hasCircleBorder: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
