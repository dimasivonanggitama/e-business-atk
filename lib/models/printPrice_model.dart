import 'package:cloud_firestore/cloud_firestore.dart';

class PrintPriceModel {
  final int? colorfulPagePrice;
  final String? documentID;
  final int? greyscalePagePrice;
  
  PrintPriceModel({
    this.colorfulPagePrice,
    this.documentID,
    this.greyscalePagePrice
  });

  PrintPriceModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      colorfulPagePrice = doc.data()!["colorfulPrice"],
      greyscalePagePrice = doc.data()!["greyscalePrice"];

  Map<String, dynamic> toMap() {
    return {
      'colorfulPrice': colorfulPagePrice,
      'greyscalePrice': greyscalePagePrice,
    };
  }

  PrintPriceModel copyWith({
    final int? colorfulPagePrice,
    final String? documentID,
    final int? greyscalePagePrice
  }) {
    return PrintPriceModel(
      colorfulPagePrice: colorfulPagePrice ?? this.colorfulPagePrice,
      documentID: documentID ?? this.documentID,
      greyscalePagePrice: greyscalePagePrice ?? this.greyscalePagePrice
    );
  }
}