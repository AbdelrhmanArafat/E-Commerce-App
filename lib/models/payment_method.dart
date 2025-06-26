class PaymentMethodModel {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expireDate;
  final String cvv;
  final bool isPreferred;

  const PaymentMethodModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expireDate,
    required this.cvv,
    this.isPreferred = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expireDate,
      'cvv': cvv,
      'isPreferred': isPreferred,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      id: map['id'] as String,
      cardHolderName: map['cardHolderName'] as String,
      cardNumber: map['cardNumber'] as String,
      expireDate: map['expiryDate'] as String,
      cvv: map['cvv'] as String,
      isPreferred: map['isPreferred'] as bool,
    );
  }

  PaymentMethodModel copyWith({
    String? id,
    String? cardHolderName,
    String? cardNumber,
    String? expireDate,
    String? cvv,
    bool? isPreferred,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expireDate: expireDate ?? this.expireDate,
      cvv: cvv ?? this.cvv,
      isPreferred: isPreferred ?? this.isPreferred,
    );
  }
}
