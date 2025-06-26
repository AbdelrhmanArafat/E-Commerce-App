import 'package:ecommerce/models/payment_method.dart';
import 'package:ecommerce/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final checkoutServices = CheckoutServices();

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
      final newPreferredPaymentMethod = paymentMethod.copyWith(isPreferred: true);
      await checkoutServices.setPaymentMethod(newPreferredPaymentMethod);
      emit(CardPreferredMade());
    } catch (error) {
      emit(CardPreferredFailed(error.toString()));
    }
  }
}
