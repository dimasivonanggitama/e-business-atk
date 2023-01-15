import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String? documentID;
  final String? id;
  final String? category;
 ProductCategoryModel({this.documentID, this.id, this.category});

  ProductCategoryModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      id         = doc.data()!["id"],
      category   = doc.data()!["category"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category
    };
  }

  ProductCategoryModel copyWith({
    String? id,
    String? category
  }) {
    return ProductCategoryModel(
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }
}