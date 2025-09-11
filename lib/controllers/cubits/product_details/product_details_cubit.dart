import 'package:ecommerce/models/add_to_cart.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:ecommerce/services/cart_services.dart';
import 'package:ecommerce/services/product_details_services.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final productDetailsServices = ProductDetailsServicesImplement();
  final cartServices = CartServicesImplement();
  final authServices = AuthServicesImplement();
  String? size;

  Future<void> fetchProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = await productDetailsServices.getProductDetails(productId);
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  Future<void> addToCart(ProductModel product) async {
    emit(AddingToCart());
    try {
      final currentUser = authServices.currentUser;
      if (size == null) {
        emit(AddToCartError('Please select a size'));
      }
      final cartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        productId: product.id,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        size: size!,
      );
      await cartServices.addProductToCart(
        currentUser!.uid,
        cartProduct,
      );
      emit(AddedToCart());
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }

  void setSize(String newSize) {
    size = newSize;
    emit(SizeSelected(newSize));
  }
}
