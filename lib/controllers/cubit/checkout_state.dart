part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class AddingCards extends CheckoutState {}

final class CardsAdded extends CheckoutState {}

final class CardsAddedFailed extends CheckoutState {
  final String error;

  CardsAddedFailed(this.error);
}

final class DeletingCards extends CheckoutState {}

final class CardsDeleted extends CheckoutState {}

final class CardsDeletedFailed extends CheckoutState {
  final String error;

  CardsDeletedFailed(this.error);
}

final class FetchingCards extends CheckoutState {}

final class CardsFetched extends CheckoutState {
  final List<PaymentMethodModel> paymentMethods;

  CardsFetched(this.paymentMethods);
}

final class CardsFetchFailed extends CheckoutState {
  final String error;

  CardsFetchFailed(this.error);
}