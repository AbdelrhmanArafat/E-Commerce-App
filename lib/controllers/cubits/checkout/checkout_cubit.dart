import 'package:ecommerce/models/delivery_method.dart';
import 'package:ecommerce/models/payment_method.dart';
import 'package:ecommerce/models/shipping_address.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:ecommerce/services/checkout_services.dart';
import 'package:ecommerce/services/stripe_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final checkoutServices = CheckoutServices();
  final stripeServices = StripeServices.instance;
  final authServices = AuthServicesImplement();

  Future<void> makePayment(double amount) async {
    emit(MakingPayment());
    try {
      await stripeServices.makePayment(amount, 'usd');
      emit(PaymentMade());
    } catch (error) {
      emit(MakingPaymentFailed(error.toString()));
    }
  }

  Future<void> addCard(PaymentMethodModel paymentMethod) async {
    emit(AddingCards());
    try {
      await checkoutServices.setPaymentMethod(paymentMethod);
      emit(CardsAdded());
    } catch (error) {
      emit(CardsAddedFailed(error.toString()));
    }
  }

  Future<void> fetchCards() async {
    emit(FetchingCards());
    try {
      final paymentMethods = await checkoutServices.paymentMethods();
      emit(CardsFetched(paymentMethods));
    } catch (error) {
      emit(CardsFetchFailed(error.toString()));
    }
  }

  Future<void> deleteCard(PaymentMethodModel paymentMethod) async {
    emit(DeletingCards(paymentMethod.id));
    try {
      await checkoutServices.deletePaymentMethod(paymentMethod);
      emit(CardsDeleted());
      await fetchCards();
    } catch (error) {
      emit(CardsDeletedFailed(error.toString()));
    }
  }

  Future<void> makeCardPreferred(PaymentMethodModel paymentMethod) async {
    emit(FetchingCards());
    try {
      final preferredPaymentMethods =
          await checkoutServices.paymentMethods(true);
      for (var method in preferredPaymentMethods) {
        final newPaymentMethod = method.copyWith(isPreferred: false);
        await checkoutServices.setPaymentMethod(newPaymentMethod);
      }
      final newPreferredPaymentMethod =
          paymentMethod.copyWith(isPreferred: true);
      await checkoutServices.setPaymentMethod(newPreferredPaymentMethod);
      emit(CardPreferredMade());
    } catch (error) {
      emit(CardPreferredFailed(error.toString()));
    }
  }

  Future<void> getCheckoutData() async {
    emit(CheckoutLoading());
    try {
      final currentUser = authServices.currentUser;
      final shippingAddresses =
          await checkoutServices.shippingAddresses(currentUser!.uid);
      final deliveryMethods = await checkoutServices.deliveryMethods();
      emit(
        CheckoutLoaded(
          shippingAddresses: shippingAddresses.isEmpty
              ? null
              : shippingAddresses[0],
          deliveryMethods: deliveryMethods,
        ),
      );
    } catch (e) {
      emit(CheckoutLoadedFailed(e.toString()));
    }
  }

  Future<void> getShippingAddresses() async {
    emit(FetchingAddresses());
    try {
      final currentUser = authServices.currentUser;
      final shippingAddresses =
          await checkoutServices.shippingAddresses(currentUser!.uid);
      emit(AddressesFetched(shippingAddresses));
    } catch (error) {
      emit(AddressesFetchFailed(error.toString()));
    }
  }

  Future<void> saveAddress(ShippingAddressModel address) async {
    emit(AddingAddresses());
    try {
      final currentUser = authServices.currentUser;
      await checkoutServices.saveAddress(address, currentUser!.uid);
      emit(AddressesAdded());
    } catch (error) {
      emit(AddressesAddedFailed(error.toString()));
    }
  }

}
