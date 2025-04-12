// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/models/porduct.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utilities/api_path.dart';

abstract class Database {
  Stream<List<ProductModel>> salesProductStream();
  Stream<List<ProductModel>> newProductStream();
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
}
