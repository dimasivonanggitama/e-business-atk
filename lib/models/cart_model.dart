import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  int? cartItemPrice          = 0;
  int? colorfulPage           = 0;
  final String? documentID;
  String? filename            = "";
  String? filePath            = "";
  int? greyscalePage          = 0;
  bool? isItemChecked         = false;
  final String? orderID;
  String? productBrand        = "";
  String? productCategory     = "";
  String? productID           = "";
  String? productImage        = "";
  String? productName         = "";
  int? productPrice           = 0;
  int? productStockQuantity   = 0;
  // String? priceWithDecimal;
  // String? priceWithDecimalAndQuantity;
  int? priceWithQuantity      = 0;
  int? productQuantity        = 0;
  final String? userID;
  
  CartModel({
    this.cartItemPrice,
    this.colorfulPage,
    this.documentID,
    this.filename,
    this.filePath,
    this.greyscalePage, 
    this.isItemChecked, 
    this.orderID,
    this.productBrand,
    this.productCategory,
    this.productID,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productStockQuantity,
    // this.priceWithDecimal,
    // this.priceWithDecimalAndQuantity,
    this.priceWithQuantity, 
    this.productQuantity,
    this.userID
  });

  CartModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      colorfulPage = doc.data()!["colorfulPage"],
      filename = doc.data()!["filename"],
      filePath = doc.data()!["filePath"],
      greyscalePage = doc.data()!["greyscalePage"],
      isItemChecked = (doc.data()!["isItemChecked"] == null)? false : doc.data()!["isItemChecked"],
      orderID = doc.data()!["orderID"],
      productID = doc.data()!["productID"],
      productQuantity = (doc.data()!["productQuantity"] == null)? 0 : doc.data()!["productQuantity"],
      userID = doc.data()!["userID"];

  Map<String, dynamic> toMap() {
    return {
      'colorfulPage': colorfulPage,
      'filename': filename,
      'filePath': filePath,
      'greyscalePage': greyscalePage,
      'isItemChecked': isItemChecked,
      'orderID': orderID,
      'productID': productID,
      'productQuantity': productQuantity,
      'userID': userID
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