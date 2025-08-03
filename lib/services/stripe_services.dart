import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  StripeServices._();

  static final StripeServices instance = StripeServices._();

  Future<void> makePayment(double amount, String currency) async {
    try {
      final clientSecret = await _createPaymentIntent(amount, currency);
      if (clientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'E-commerce App',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': (amount * 100).toInt(),
        'currency': currency,
      };
      final dio = Dio();
      final response = await dio.post(
        AppConstants.paymentIntentPath,
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer ${AppConstants.secretKey}',
            'content-type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data['client_secret'];
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
