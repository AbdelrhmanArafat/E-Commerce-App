import 'package:ecommerce/models/add_to_cart.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:ecommerce/services/cart_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final authServices = AuthServicesImplement();
  final cartServices = CartServicesImplement();

  Future<void> fetchCartProducts() async {
    emit(CartLoading());
    try {
      final currentUser = authServices.currentUser;
      final cartProduct = await cartServices.getCartProducts(currentUser!.uid);
      final totalAmount = cartProduct.fold<double>(
        0,
        (previousValue, element) => previousValue + element.price,
      );
      emit(CartLoaded(cartProduct,totalAmount));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
