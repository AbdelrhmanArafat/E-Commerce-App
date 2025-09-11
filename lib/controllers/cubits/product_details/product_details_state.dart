part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;

  ProductDetailsLoaded(this.product);
}

final class ProductDetailsError extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsError(this.errorMessage);
}

final class AddingToCart extends ProductDetailsState {}

final class AddedToCart extends ProductDetailsState {}

final class AddToCartError extends ProductDetailsState {
  final String errorMessage;

  AddToCartError(this.errorMessage);
}

final class SizeSelected extends ProductDetailsState {
  final String size;

  SizeSelected(this.size);
}