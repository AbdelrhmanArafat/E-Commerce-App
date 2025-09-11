import 'package:ecommerce/models/add_to_cart.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utilities/api_path.dart';

abstract class CartServices {
  Future<void> addProductToCart(String userId, AddToCartModel cartProduct);
  Future<List<AddToCartModel>> getCartProducts(String uid);
}

class CartServicesImplement implements CartServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<void> addProductToCart(
          String userId, AddToCartModel cartProduct) async =>
      await firestoreServices.setData(
        path: ApiPaths.addToCart(
          userId,
          cartProduct.id,
        ),
        data: cartProduct.toMap(),
      );

  @override
  Future<List<AddToCartModel>> getCartProducts(String uid) async =>
      await firestoreServices.getCollection(
        path: ApiPaths.myProductCart(uid),
        builder: (data, documentId) => AddToCartModel.fromMap(data, documentId),
      );
}
