// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/utilities/assets.dart';

class ProductModel {
  final String id;
  final String title;
  final int price;
  final String imageUrl;
  final int discount;
  final String? category;
  final double? rate;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.discount = 0,
    this.category = 'other',
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'discount': discount,
      'category': category,
      'rate': rate,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProductModel(
      id: documentId,
      title: map['title'] as String,
      price: map['price'] as int,
      imageUrl: map['imageUrl'] as String,
      discount: map['discount'] as int,
      category: map['category'] != null ? map['category'] as String : null,
      rate: map['rate'] != null ? map['rate'] as double : null,
    );
  }
}

List<ProductModel> dummyProduct = [
  ProductModel(
    id: "1",
    title: 'T-shirt',
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discount: 20,
    rate: 4,
  ),
  ProductModel(
    id: "1",
    title: 'T-shirt',
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    discount: 20,
    rate: 4,
  ),
  ProductModel(
    id: "1",
    title: 'T-shirt',
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    rate: 4,
  ),
  ProductModel(
    id: "1",
    title: 'T-shirt',
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discount: 20,
  ),
];
