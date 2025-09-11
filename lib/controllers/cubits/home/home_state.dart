part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductModel> salesProduct;
  final List<ProductModel> newProduct;

  HomeSuccess({
    required this.salesProduct,
    required this.newProduct,
  });
}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure(this.error);
}