// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/models/add_to_cart.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utilities/api_path.dart';

abstract class Database {
  Stream<List<ProductModel>> salesProductStream();
  Stream<List<ProductModel>> newProductStream();
  Stream<List<AddToCartModel>> myProductCart();
  Future<void> getUserData(UserModel user);
  Future<void> addToCart(AddToCartModel addToCart);
}

class FireStoreDatabase implements Database {
  final String uid;
  final services = FirestoreServices.instance;

  FireStoreDatabase(this.uid);

  @override
  Stream<List<ProductModel>> salesProductStream() => services.collectionStream(
        path: ApiPaths.products(),
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discount', isNotEqualTo: 0),
      );

  @override
  Stream<List<ProductModel>> newProductStream() => services.collectionStream(
        path: ApiPaths.products(),
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );

  @override
  Future<void> getUserData(UserModel user) async => await services.setData(
        path: ApiPaths.user(user.uid),
        data: user.toMap(),
      );

  @override
  Future<void> addToCart(AddToCartModel addToCart) async =>
      await services.setData(
        path: ApiPaths.addToCart(uid, addToCart.id),
        data: addToCart.toMap(),
      );

  @override
  Stream<List<AddToCartModel>> myProductCart() => services.collectionStream(
        path: ApiPaths.myProductCart(uid),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );
}
