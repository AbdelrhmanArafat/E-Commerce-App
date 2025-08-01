class DeliveryMethodModel {
  final String id;
  final String name;
  final String days;
  final String imageUrl;
  final double price;

  DeliveryMethodModel({
    required this.id,
    required this.name,
    required this.days,
    required this.imageUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'days': days,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory DeliveryMethodModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return DeliveryMethodModel(
      id: documentId,
      name: map['name'] ?? '',
      days: map['days'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price']?? 0).toDouble(),
    );
  }
}
