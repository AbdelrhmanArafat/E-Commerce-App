part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final ShippingAddressModel? shippingAddresses;
  final List<DeliveryMethodModel> deliveryMethods;

  CheckoutLoaded({
    this.shippingAddresses,
    required this.deliveryMethods,
  });
}

final class CheckoutLoadedFailed extends CheckoutState {
  final String error;

  CheckoutLoadedFailed(this.error);
}

final class FetchingAddresses extends CheckoutState {}

final class AddressesFetched extends CheckoutState {
  final List<ShippingAddressModel> shippingAddresses;

  AddressesFetched(this.shippingAddresses);
}

final class AddressesFetchFailed extends CheckoutState {
  final String error;

  AddressesFetchFailed(this.error);
}

final class AddingAddresses extends CheckoutState {}

final class AddressesAdded extends CheckoutState {}

final class AddressesAddedFailed extends CheckoutState {
  final String error;

  AddressesAddedFailed(this.error);
}

final class AddingCards extends CheckoutState {}

final class CardsAdded extends CheckoutState {}

final class CardsAddedFailed extends CheckoutState {
  final String error;

  CardsAddedFailed(this.error);
}

final class DeletingCards extends CheckoutState {
  final String cardId;

  DeletingCards(this.cardId);
}

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

final class MakingCardPreferred extends CheckoutState {}

final class CardPreferredMade extends CheckoutState {}

final class CardPreferredFailed extends CheckoutState {
  final String error;

  CardPreferredFailed(this.error);
}

final class MakingPayment extends CheckoutState {}

final class PaymentMade extends CheckoutState {}

final class MakingPaymentFailed extends CheckoutState {
  final String error;

  MakingPaymentFailed(this.error);
}
