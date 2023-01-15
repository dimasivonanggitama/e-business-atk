import 'dart:developer';

import 'package:ebusiness_atk_mobile/models/productCategory_model.dart';
import 'package:ebusiness_atk_mobile/models/product_model.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/updateProduk.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cart_model.dart';

class DatabaseServices {
  late DocumentReference snapshot;
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _dbStorage = FirebaseStorage.instance;

  late CollectionReference collection;
  late DocumentReference doc;
  late dynamic condition;
  // late dynamic setClassModel;
//   static CollectionReference productCollection = Firestore.instance.collection('produk_atk');

//   static Future<String> uploadImage(File imageFile) async {
//     String fileName = basename(imageFile.path);

//     StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
//     StorageUploadTask task = ref.putFile(imageFile);
//     StorageTaskSnapshot snapshot = await task.onComplete;

//     return await snapshot.ref.getDownloadURL();
//   }

  // Preparation

  // Execution
  Future<String> addFile(file) async {
    final storageRef = _dbStorage.ref().child(basename(file.path));
    final task = storageRef.putFile(file);
    final snapshot = await task;
    return await snapshot.ref.getDownloadURL();
  }

  Future addData(String colletionReference, submittedData) {
    return _dbFirestore.collection(colletionReference).add(submittedData.toMap());
  }

  Future addDataWithCustomDocumentID(String colletionReference, String documentID, submittedData) {
    return _dbFirestore.collection(colletionReference).doc(documentID).set(submittedData.toMap());
  }

  Future deleteData(String collectionReference, String documentID) {
    return _dbFirestore.collection(collectionReference).doc(documentID).delete();
  }

  set deleteFile(String path) {
    _dbStorage.ref().child(path);
  }

  Future updateData(String collectionReference, String documentID, submittedData) {
    return _dbFirestore.collection(collectionReference).doc(documentID).update(submittedData.toMap());
  }

  set updateProduk(ProductModel produkData) {
    snapshot.update(produkData.toMap());
  }

  set setDocumentReferenceOfProduk(documentID) {
    snapshot = _dbFirestore.collection("produk_atk").doc(documentID);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData(String collectionReference) async {
    return await _dbFirestore.collection(collectionReference).get();
  }

  Future<DocumentReference> getDataWithDocumentIDCondition(String collectionReference, String documentID) async {
    return await _dbFirestore.collection(collectionReference).doc(documentID);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataWithDoubleCondition(String collectionReference, String fieldName1, dynamic fieldValue1, String fieldName2, dynamic fieldValue2) async {
    return await _dbFirestore.collection(collectionReference).where(fieldName1, isEqualTo: fieldValue1).where(fieldName2, isEqualTo: fieldValue2).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataWithSingleCondition(String collectionReference, String fieldName, dynamic fieldValue) async {
    return await _dbFirestore.collection(collectionReference).where(fieldName, isEqualTo: fieldValue).get();
  }
}

class UnitializeDatabaseServices extends DatabaseServices {}

// Backup query snapshot:
  // Future<List<ProductModel>> getData(String collectionReference, modelClass) async {
    // QuerySnapshot<Map<String, dynamic>> snapshot = await _dbFirestore.collection(collectionReference).get();
    // return snapshot.docs.map(
    //   (docSnapshot) => ProductModel.fromDocumentSnapshot(docSnapshot)
    // ).toList();
  // }

  // Backup document snapshot:
  // Future getProduk async {
  //   DocumentReference snapshot = _dbFirestore.collection("produk_atk").doc(documentID);
  //   return snapshot.get().then(
  //     (documentSnapshot) => ProductModel.fromDocumentSnapshot(documentSnapshot as DocumentSnapshot<Map<String, dynamic>>)
  //   );
  // }