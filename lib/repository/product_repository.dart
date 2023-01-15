import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/models/product_model.dart';

import '../models/productCategory_model.dart';
import '../services/database_services.dart';

// abstract class ProductRepositoryAbstract {
//   Future<List<ProdukModel>> retrieveAllProduk();
//   Future<List<ProductCategoryModel>> retrieveKategoriProduk();
//   Future<dynamic> retrieveSpecificProduk(idProduk);
//   // get retrieveSpecificProduk(idProduk);
//   Future<String> saveFile(file);
//   set saveProdukData(ProdukModel produkData);
//   editProdukData(String pastUploadedImageURL, ProdukModel produkData, idProduk);
// }

// class ProductRepository implements ProductRepositoryAbstract {
class ProductRepository {
  DatabaseServices service = DatabaseServices();
  String collectionReference = "products";

  Future addProductCategory(ProductCategoryModel submittedData) async {
    await service.addData("categories", submittedData);
  }

  Future deleteItem(String cartID) async {
    return await service.deleteData(collectionReference, cartID);
  }

  Future deleteProductCategory(String categoryID) async {
    return await service.deleteData("categories", categoryID);
  }

  Future<List> retrieveAllProducts() async {
    var snapshot = await service.getData(collectionReference);

    return snapshot.docs.map(
      (docSnapshot) => ProductModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<List<ProductCategoryModel>> retrieveCategories() async {
    var snapshot = await service.getData("categories");

    return snapshot.docs.map(
      (docSnapshot) => ProductCategoryModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<ProductModel> retrieveSpecificProduct(String documentID) async {
    var snapshot = await service.getDataWithDocumentIDCondition(collectionReference, documentID);

    return snapshot.get().then(
      (docSnapshot) => ProductModel.fromDocumentSnapshot(docSnapshot as DocumentSnapshot<Map<String, dynamic>>)
    );
  }

  Future<String> saveFile(file) {
    return service.addFile(file);
  }

  Future saveProductData(dynamic submittedData) async {
    await service.addData(collectionReference, submittedData);
  }

  // editProdukData(String pastUploadedImageURL, ProductModel produkData, idProduk) {
  //   if (pastUploadedImageURL.isNotEmpty) service.deleteFile = pastUploadedImageURL;
  //   service.setDocumentReferenceOfProduk = idProduk;
  //   service.updateProduk = produkData;
  // }

  updateProduct({required String documentID, String pastUploadedImageURL = "", required ProductModel submittedProduct}) {
    if (pastUploadedImageURL.isNotEmpty) service.deleteFile = pastUploadedImageURL;
    service.updateData(collectionReference, documentID, submittedProduct);
  }

  updateProductCategory(String documentID, ProductCategoryModel submittedCategory) {
    service.updateData("categories", documentID, submittedCategory);
  }
}