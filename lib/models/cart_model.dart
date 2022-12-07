import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String? documentID;
  final String? productID;
  final int? productQuantity;
  final String? userID;
  CartModel({this.documentID, this.productID, this.productQuantity, this.userID});

  CartModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      productID = doc.data()!["productID"],
      productQuantity = doc.data()!["productQuantity"],
      userID = doc.data()!["userID"];

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'productQuantity': productQuantity,
      'userID': userID,
    };
  }

  CartModel copyWith({
    final String? productID,
    final int? productQuantity,
    final String? userID
  }) {
    return CartModel(
      productID: productID ?? this.productID,
      productQuantity: productQuantity ?? this.productQuantity,
      userID: userID ?? this.userID
    );
  }
}