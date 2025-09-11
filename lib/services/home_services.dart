import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utilities/api_path.dart';

abstract class HomeServices {
  Future<List<ProductModel>> getSalesProduct();
  Future<List<ProductModel>> getNewProduct();
}

class HomeServicesImplement implements HomeServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductModel>> getNewProduct() async =>
      await firestoreServices.getCollection(
        path: ApiPaths.products(),
        builder: (data, documentId) => ProductModel.fromMap(data, documentId),
      );

  @override
  Future<List<ProductModel>> getSalesProduct() async =>
      await firestoreServices.getCollection(
        path: ApiPaths.products(),
        builder: (data, documentId) => ProductModel.fromMap(data, documentId),
        queryBuilder: (query) => query.where('discount', isNotEqualTo: 0),
      );
}
