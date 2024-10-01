import 'package:ecommerce/utilities/assets.dart';

class ProductModel {
  final int id;
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
}

List<ProductModel> dummyProduct = [
  ProductModel(
    id: 1,
    title: 'T-shirt',
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discount: 20,
    rate: 4,
  ),
  ProductModel(
    id: 1,
    title: 'T-shirt',
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    discount: 20,
    rate: 4,
  ),
  ProductModel(
    id: 1,
    title: 'T-shirt',
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    rate: 4,
  ),
  ProductModel(
    id: 1,
    title: 'T-shirt',
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discount: 20,
  ),
];
