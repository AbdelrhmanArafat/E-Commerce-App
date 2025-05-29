import 'package:ecommerce/models/add_to_cart.dart';
import 'package:ecommerce/models/delivery_method.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/shipping_address.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utilities/api_path.dart';

abstract class Database {
  Stream<List<ProductModel>> salesProductStream();
  Stream<List<ProductModel>> newProductStream();
  Stream<List<AddToCartModel>> myProductCartStream();
  Stream<List<DeliveryMethodModel>> myDeliveryMethodsStream();
  Stream<List<ShippingAddressModel>> getShippingAddresses();
  Future<void> getUserData(UserModel user);
  Future<void> addToCart(AddToCartModel addToCart);
  Future<void> saveAddress(ShippingAddressModel saveAddress);
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
  Stream<List<AddToCartModel>> myProductCartStream() =>
      services.collectionStream(
        path: ApiPaths.myProductCart(uid),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<DeliveryMethodModel>> myDeliveryMethodsStream() =>
      services.collectionStream(
        path: ApiPaths.deliveryMethod(),
        builder: (data, documentId) => DeliveryMethodModel.fromMap(
          data!,
          documentId,
        ),
      );

  @override
  Stream<List<ShippingAddressModel>> getShippingAddresses() =>
      services.collectionStream(
        path: ApiPaths.userShippingAddress(uid),
        builder: (data, documentId) => ShippingAddressModel.fromMap(
          data!,
          documentId,
        ),
      );

  @override
  Future<void> saveAddress(ShippingAddressModel saveAddress) =>
      services.setData(
        path: ApiPaths.newAddress(uid, saveAddress.id),
        data: saveAddress.toMap(),
      );
}
