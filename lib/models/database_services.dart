import 'dart:io';
import 'package:ebusiness_atk_mobile/models/kategoriProduk_model.dart';
import 'package:ebusiness_atk_mobile/models/produk_model.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/updateProduk.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_model.dart';

class DatabaseServices {
  late DocumentReference snapshot;
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _dbStorage = FirebaseStorage.instance;
//   static CollectionReference productCollection = Firestore.instance.collection('produk_atk');

//   static Future<String> uploadImage(File imageFile) async {
//     String fileName = basename(imageFile.path);

//     StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
//     StorageUploadTask task = ref.putFile(imageFile);
//     StorageTaskSnapshot snapshot = await task.onComplete;

//     return await snapshot.ref.getDownloadURL();
//   }
  // static get getProduk {
  //   final CollectionReference produk_atk = FirebaseFirestore.instance.collection('produk_atk');
  // }

  static void login() {}

  Future<String> addFile(file) async {
    final storageRef = _dbStorage.ref().child(basename(file.path));
    final task = storageRef.putFile(file);
    final snapshot = await task;
    return await snapshot.ref.getDownloadURL();
  }

  set addProduk(ProdukModel produkData) {
    _dbFirestore.collection('produk_atk').add(produkData.toMap());
  }

  set addCart(CartModel submittedProduct) {
    _dbFirestore.collection('cart').add(submittedProduct.toMap());
  }

  set deleteFile(fileName) {
    _dbStorage.ref().child(fileName);
  }

  set updateProduk(ProdukModel produkData) {
    snapshot.update(produkData.toMap());
  }

  set setDocumentReferenceOfProduk(documentID) {
    snapshot = _dbFirestore.collection("produk_atk").doc(documentID);
  }

  // Future<ProdukModel> getProduk(documentID) async {
  get getProduk async {
    // DocumentReference<Map<String, dynamic>> snapshot = await _dbFirestore.collection("produk_atk").doc(documentID);
    // DocumentReference snapshot = await _dbFirestore.collection("produk_atk").doc(documentID);
    return snapshot.get().then(
    // return snapshot.doc.data(
      (documentSnapshot) => ProdukModel.fromDocumentSnapshot(documentSnapshot as DocumentSnapshot<Map<String, dynamic>>)
      // (DocumentSnapshot documentSnapshot) => documentSnapshot.data() as Map<String, dynamic>

      // final data2 = documentSnapshot.data() as Map<String, dynamic>;
      // ProdukModel.fromDocumentSnapshot(data2);
    );
    // );
  }


  Future<List<ProdukModel>> getListofProduk() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _dbFirestore.collection("produk_atk").get();
    return snapshot.docs.map(
      (docSnapshot) => ProdukModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<KategoriProdukModel>> retrieveKategoriProduk() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _dbFirestore.collection("kategori").get();
    return snapshot.docs.map(
      (docSnapshot) => KategoriProdukModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }
  // get getUserCart async {
  Future<List<CartModel>> getUserCart(productID, userID) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _dbFirestore.collection("cart").where("productID", isEqualTo: productID).where("userID", isEqualTo: userID).get();
    return snapshot.docs.map(
      (docSnapshot) => CartModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  // Future<List<KategoriProdukModel>> retrieveKategoriProduk2() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("kategori").get();
  //   return snapshot.data!.docs.toList();
  // }

  // Future<String> retrieveKategoriProduk2(KategoriProdukModel kpm) async {
  //   DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection("kategori").doc(kpm.uid).get();
  //   return snapshot.get(field);
  // }

}

class UnitializeDatabaseServices extends DatabaseServices {}

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_bloc_tutorial/models/user_model.dart';

// import '../../models/user_model.dart';

// class DatabaseService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//     addUserData(UserModel userData) async {
//       await _db.collection("Users").doc(userData.uid).set(userData.toMap());
//     }

//     Future<List<UserModel>> retrieveUserData() async {
//       QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("Users").get();
//       return snapshot.docs.map(
//         (docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot)
//       ).toList();
//     }

//     Future<String> retrieveUserName(UserModel user) async {
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection("Users").doc(user.uid).get();
//       return snapshot.data()!["displayName"];
//     }
// }