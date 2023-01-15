import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryFeeModel {
  final String? documentID;
  final int? price;
  
  DeliveryFeeModel({
    this.documentID,
    this.price,
  });

  DeliveryFeeModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      price = doc.data()!["price"];

  Map<String, dynamic> toMap() {
    return {
      'price': price,
    };
  }

  DeliveryFeeModel copyWith({
    final int? price,
  }) {
    return DeliveryFeeModel(
      price: price ?? this.price,
    );
  }
}