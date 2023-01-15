import 'package:cloud_firestore/cloud_firestore.dart';

class DBMSFirestoreModel {
  final String? documentID;
  final bool? isItemChecked;
  final String? orderID;
  final String? productID;
  String? priceWithDecimal;
  final int? productQuantity;
  final String? userID;
  DBMSFirestoreModel({this.documentID, this.isItemChecked, this.orderID, this.productID, this.priceWithDecimal, this.productQuantity, this.userID});

  DBMSFirestoreModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      isItemChecked = doc.data()!["isItemChecked"],
      orderID = doc.data()!["orderID"],
      productID = doc.data()!["productID"],
      productQuantity = doc.data()!["productQuantity"],
      userID = doc.data()!["userID"];

  Map<String, dynamic> toMap() {
    return {
      'isItemChecked': isItemChecked,
      'orderID': orderID,
      'productID': productID,
      'productQuantity': productQuantity,
      'userID': userID
    };
  }

  DBMSFirestoreModel copyWith({
    final String? productID,
    final int? productQuantity,
    final String? userID
  }) {
    return DBMSFirestoreModel(
      productID: productID ?? this.productID,
      productQuantity: productQuantity ?? this.productQuantity,
      userID: userID ?? this.userID
    );
  }
}