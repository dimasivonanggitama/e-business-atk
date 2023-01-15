import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/models/cart_model.dart';
import 'package:ebusiness_atk_mobile/models/printPrice_model.dart';
import '../models/deliveryFee_model.dart';
import '../models/user_model.dart';
import '../services/database_services.dart';

class CartRepository{
  DatabaseServices service = DatabaseServices();
  String collectionReference = "cart";

  Future createOrder(String documentID, dynamic submittedData) async {
    // return await service.addData("orders", submittedData);
    return await service.addDataWithCustomDocumentID("orders", documentID, submittedData);
  }

  Future deleteItem({required String cartID, String filePath = ""}) async {
    if (filePath.isNotEmpty) service.deleteFile = filePath;
    return await service.deleteData(collectionReference, cartID);
  }

  Future<List<DeliveryFeeModel>> retrieveDeliveryFee() async {
    var snapshot = await service.getData("deliveryFee");

    return snapshot.docs.map(
      (docSnapshot) => DeliveryFeeModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<PrintPriceModel>> retrievePrintPrice() async {
    var snapshot = await service.getData("printPrice");

    return snapshot.docs.map(
      (docSnapshot) => PrintPriceModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<CartModel>> retrieveSelectedItems(String userID) async {
    var snapshot = await service.getDataWithDoubleCondition(collectionReference, "isItemChecked", true, "userID", userID);

    return snapshot.docs.map(
      (docSnapshot) => CartModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<CartModel>> retrieveSpecificProductUserCart(String productID, String userID) async {
    var snapshot = await service.getDataWithDoubleCondition(collectionReference, "productID", productID, "userID", userID);

    return snapshot.docs.map(
      (docSnapshot) => CartModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<CartModel>> retrieveUserCart(String userID) async {
    var snapshot = await service.getDataWithSingleCondition(collectionReference, "userID", userID);

    return snapshot.docs.map(
      (docSnapshot) => CartModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<UserModel> retrieveUserInformation(String userID) async {
    var snapshot = await service.getDataWithDocumentIDCondition("users", userID);

    return snapshot.get().then(
      (docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot as DocumentSnapshot<Map<String, dynamic>>)
    );
  }

  Future saveProduct(submittedProduct) async {
    return await service.addData(collectionReference, submittedProduct);
  }

  updateCart(String documentID, CartModel submittedProduct) {
    service.updateData("cart", documentID, submittedProduct);
  }
  
  updateUserAddress({required String documentID, String submittedAddress = "", String submittedPhoneNumber = ""}) async {
    UserModel _userModel = await retrieveUserInformation(documentID);
    if (submittedAddress.isNotEmpty) _userModel.address = submittedAddress;
    else if (submittedPhoneNumber.isNotEmpty) _userModel.phoneNumber = submittedPhoneNumber;
    service.updateData("users", documentID, _userModel);
  }
}