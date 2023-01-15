import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? brand;
  String? category;
  final String? documentID;
  // final String? gambarProduk;
  String? image;
  // final Future<String>? gambarProduk;
  final String? name;
  final int? price;
  final int? stockQuantity;
  ProductModel({this.brand, this.category, this.documentID, this.image, this.name, this.price, this.stockQuantity});

  ProductModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      image = doc.data()!["image"],
      price = doc.data()!["price"],
      stockQuantity = doc.data()!["stockQuantity"],
      category = doc.data()!["category"],
      brand = doc.data()!["brand"],
      name = doc.data()!["name"];

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'category': category,
      'image': image,
      'name': name,
      'price': price,
      'stockQuantity': stockQuantity,
    };
  }

  ProductModel copyWith({
  final String? brand,
  final String? category,
  final String? image,
  // final Future<String>? gambarProduk,
  final String? name,
  final int? price,
  final int? stockQuantity
  }) {
    return ProductModel(
      brand: brand ?? this.brand,
      category: category ?? this.category,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }
}