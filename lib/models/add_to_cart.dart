class AddToCartModel {
  final String id;
  final String productId;
  final String title;
  final int price;
  final int quantity;
  final String imageUrl;
  final int? discount;
  final String color;
  final String size;

  AddToCartModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    this.quantity = 1,
    required this.imageUrl,
    this.discount = 0,
    this.color = 'black',
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'discount': discount,
      'color': color,
      'size': size,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
      title: map['title'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
      imageUrl: map['imageUrl'] as String,
      discount: map['discount'] as int,
      color: map['color'] as String,
      size: map['size'] as String,
    );
  }
}
