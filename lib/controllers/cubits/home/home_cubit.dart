import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImplement();

  Future<void> getHomeContent() async {
    emit(HomeLoading());
    try {
      final newProduct = await homeServices.getNewProduct();
      final salesProduct = await homeServices.getSalesProduct();
      emit(
        HomeSuccess(
          salesProduct: salesProduct,
          newProduct: newProduct,
        ),
      );
    } catch (error) {
      emit(HomeFailure(error.toString()));
    }
  }
}
