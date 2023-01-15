import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? address;
  final dateCreated;
  final int? deliveryFee;
  final String? documentID;
  String? paymentMethod;
  String? phoneNumber;
  String? status;
  final int? totalPrice;
  final int? totalPrintItems;
  final int? totalProductItems;
  final String? userID;
  String? userName;
OrderModel({this.address, this.dateCreated, this.deliveryFee, this.documentID, this.paymentMethod, this.phoneNumber, this.status, this.totalPrice, this.totalPrintItems, this.totalProductItems, this.userID, this.userName});

  OrderModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID        = doc.id,
      // address           = doc.data()!["address"],
      dateCreated       = doc.data()!["dateCreated"],
      deliveryFee       = doc.data()!["deliveryFee"],
      paymentMethod     = doc.data()!["paymentMethod"],
      // phoneNumber       = doc.data()!["phoneNumber"],
      status            = doc.data()!["status"],
      totalPrice        = doc.data()!["totalPrice"],
      totalPrintItems   = doc.data()!["totalPrintItems"],
      totalProductItems = doc.data()!["totalProductItems"],
      userID            = doc.data()!["userID"];

  Map<String, dynamic> toMap() {
    return {
      // 'address' : address,
      'dateCreated' : DateTime.now(),
      'deliveryFee' : deliveryFee,
      'paymentMethod' : paymentMethod,
      'status': status,
      // 'phoneNumber': phoneNumber,
      'totalPrice': totalPrice,
      'totalPrintItems': totalPrintItems,
      'totalProductItems': totalProductItems,
      'userID': userID
    };
  }

  OrderModel copyWith({
  final String? address,
  final dateCreated,
  final int? deliveryFee,
  final String? paymentMethod,
  final String? phoneNumber,
  final String? status,
  final int? totalPrice,
  final int? totalPrintItems,
  final int? totalProductItems,
  final String? userID,
  final String? userName
  }) {
    return OrderModel(
      address: address ?? this.address,
      dateCreated: dateCreated ?? this.dateCreated,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      totalPrintItems: totalPrintItems ?? this.totalPrintItems,
      totalProductItems: totalProductItems ?? this.totalProductItems,
      userID: userID ?? this.userID,
      userName: userName ?? this.userName
    );
  }
}