import 'package:flutter_dotenv/flutter_dotenv.dart';

String documentIdFromLocalData() => DateTime.now().toIso8601String();

class AppConstants {
  static final String paymentIntentPath =
      dotenv.env['payment_Intent_Path'] ?? 'payment intent Path does not exist';

  static final String publishableKey =
      dotenv.env['publishable_Key'] ?? 'publishable key does not exist';

  static final String secretKey =
      dotenv.env['secret_Key'] ?? 'secret key does not exist';
}
