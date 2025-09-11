import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utilities/api_path.dart';

abstract class ProductDetailsServices {
  Future<ProductModel> getProductDetails(String productId);
}

class ProductDetailsServicesImplement implements ProductDetailsServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<ProductModel> getProductDetails(String productId) async =>
      await firestoreServices.getDocument(
        path: ApiPaths.product(productId),
        builder: (data, documentID) => ProductModel.fromMap(
          data,
          documentID,
        ),
      );
}
