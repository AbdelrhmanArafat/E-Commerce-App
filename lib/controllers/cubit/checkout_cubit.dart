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
      await checkoutServices.addPaymentMethod(paymentMethod);
      emit(CardsAdded());
    } catch (error) {
      emit(CardsAddedFailed(error.toString()));
    }
  }

  Future<void> fetchCards() async {
    emit(FetchingCards());
    try {
      final paymentMethods = await checkoutServices.paymentMethod();
      emit(CardsFetched(paymentMethods));
    } catch (error) {
      emit(CardsFetchFailed(error.toString()));
    }
  }

  Future<void> deleteCard(PaymentMethodModel paymentMethod) async {
    emit(DeletingCards());
    try {
      await checkoutServices.deletePaymentMethod(paymentMethod);
      emit(CardsDeleted());
    } catch (error) {
      emit(CardsDeletedFailed(error.toString()));
    }
  }
}
