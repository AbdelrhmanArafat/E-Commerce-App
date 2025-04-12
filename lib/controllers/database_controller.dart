import 'package:ecommerce/models/porduct.dart';
import 'package:ecommerce/services/firestore_services.dart';

abstract class Database {
  Stream<List<ProductModel>> productStream();
}

class FireStoreDatabase implements Database {
  final services = FirestoreServices.instance;

  @override
  Stream<List<ProductModel>> productStream() => services.collectionStream(
        path: 'products/',
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );
}
