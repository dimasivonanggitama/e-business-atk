import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/models/dbms_firestore_model.dart';
import 'package:ebusiness_atk_mobile/models/productCategory_model.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import '../services/dbms_firestore_service.dart';

class DBMSFirestoreRepository {
  DBMSFirestoreService service = DBMSFirestoreService();

  Future<List<ProductCategoryModel>> retrieveProductCategories(String collectionReferenceTarget) async {
    var snapshot = await service.getData(collectionReferenceTarget);
    return snapshot.docs.map(
      (docSnapshot) => ProductCategoryModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<ProductModel>> retrieveProducts(String collectionReferenceTarget) async {
    var snapshot = await service.getData(collectionReferenceTarget);
    return snapshot.docs.map(
      (docSnapshot) => ProductModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<UserModel>> retrieveUsers(String collectionReferenceTarget) async {
    var snapshot = await service.getData(collectionReferenceTarget);
    return snapshot.docs.map(
      (docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future createCollection(String newCollectionName, dynamic submittedData) async {
    await service.addData(newCollectionName, submittedData);
  }

  Future createCollectionWithCustomDocumentID(String documentID, String newCollectionName, dynamic submittedData) async {
    await service.addDataWithCustomDocumentID(documentID, newCollectionName, submittedData);
  }
}

class YourBaseClassOrInterface {
}