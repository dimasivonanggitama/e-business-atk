import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/models/product_model.dart';
import 'package:ebusiness_atk_mobile/services/database_services.dart';

import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';

class OrderRepository {
  DatabaseServices service = DatabaseServices();
  String collectionReference = "orders";

  // Future<List<CartModel>> getDetailOrder(String userID) {
  //   service.getDataWithSingleCondition(collectionReference, "userID", userID);
  // }

  Future<List<OrderModel>> retrieveAllOrders() async {
    var snapshot = await service.getData(collectionReference);

    return snapshot.docs.map(
      (docSnapshot) => OrderModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<OrderModel>> retrieveUserOrders(String userID) async {
    var snapshot = await service.getDataWithSingleCondition(collectionReference, "userID", userID);

    return snapshot.docs.map(
      (docSnapshot) => OrderModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<UserModel> retrieveUserName(String documentID) async {
    var snapshot = await service.getDataWithDocumentIDCondition("users", documentID);

    return snapshot.get().then(
      (docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot as DocumentSnapshot<Map<String, dynamic>>)
    );
  }

  Future<ProductModel> retrieveSpecificProduct(String documentID) async {
    var snapshot = await service.getDataWithDocumentIDCondition(collectionReference, documentID);

    return snapshot.get().then(
      (docSnapshot) => ProductModel.fromDocumentSnapshot(docSnapshot as DocumentSnapshot<Map<String, dynamic>>)
    );
  }

  Future<List<CartModel>> retrieveSelectedItems(String orderID) async {
    var snapshot = await service.getDataWithSingleCondition("cart", "orderID", orderID);

    return snapshot.docs.map(
      (docSnapshot) => CartModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  updateOrderStatus(String documentID, OrderModel submittedOrder) {
    service.updateData(collectionReference, documentID, submittedOrder);
  }
}