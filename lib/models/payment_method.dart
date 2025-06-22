class PaymentMethodModel {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expireDate;
  final String cvv;

  PaymentMethodModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expireDate,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expireDate,
      'cvv': cvv,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      id: map['id'] as String,
      cardHolderName: map['cardHolderName'] as String,
      cardNumber: map['cardNumber'] as String,
      expireDate: map['expiryDate'] as String,
      cvv: map['cvv'] as String,
    );
  }
}
