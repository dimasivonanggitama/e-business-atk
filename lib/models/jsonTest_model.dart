import 'package:cloud_firestore/cloud_firestore.dart';

class JsonTest {
  final String? documentID;
  final int? price;
  
  JsonTest({
    this.documentID,
    this.price,
  });

  JsonTest.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      price = doc.data()!["price"];

  Map<String, dynamic> toMap() {
    return {
      'price': price,
    };
  }

  JsonTest copyWith({
    final int? price,
  }) {
    return JsonTest(
      price: price ?? this.price,
    );
  }
}