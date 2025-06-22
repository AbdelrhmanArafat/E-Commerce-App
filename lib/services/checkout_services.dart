import 'package:ecommerce/models/payment_method.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utilities/api_path.dart';

abstract class CheckoutServicesBase {
  Future<void> addPaymentMethod(PaymentMethodModel paymentMethod);
  Future<void> deletePaymentMethod(PaymentMethodModel paymentMethod);
  Future<List<PaymentMethodModel>> paymentMethod();
}

class CheckoutServices implements CheckoutServicesBase {
  final firestoreServices = FirestoreServices.instance;
  final authServices = Auth();

  @override
  Future<void> addPaymentMethod(PaymentMethodModel paymentMethod) async {
    final currentUser = authServices.currentUser;
    await firestoreServices.setData(
      path: ApiPaths.addCards(
        currentUser!.uid,
        paymentMethod.id,
      ),
      data: paymentMethod.toMap(),
    );
  }

  @override
  Future<void> deletePaymentMethod(PaymentMethodModel paymentMethod) async {
    final currentUser = authServices.currentUser;
    await firestoreServices.deleteData(
      path: ApiPaths.addCards(
        currentUser!.uid,
        paymentMethod.id,
      ),
    );
  }

  @override
  Future<List<PaymentMethodModel>> paymentMethod() async {
    final currentUser = authServices.currentUser;
    return await firestoreServices.getCollection(
      path: ApiPaths.cards(currentUser!.uid),
      builder: (data, documentId) => PaymentMethodModel.fromMap(data),
    );
  }
}
