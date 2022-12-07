// import 'package:firebase_bloc_tutorial/models/user_model.dart';

import 'package:ebusiness_atk_mobile/models/produk_model.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/updateProduk.dart';

import '/models/kategoriProduk_model.dart';
import '/models/database_services.dart';

abstract class DatabaseRepositoryAbstract {
  Future<List<ProdukModel>> retrieveAllProduk();
  Future<List<KategoriProdukModel>> retrieveKategoriProduk();
  Future<dynamic> retrieveSpecificProduk(idProduk);
  // get retrieveSpecificProduk(idProduk);
  Future<String> saveFile(file);
  set saveProdukData(ProdukModel produkData);
  editProdukData(String pastUploadedImageURL, ProdukModel produkData, idProduk);
}

class DatabaseRepository implements DatabaseRepositoryAbstract {
  DatabaseServices service = DatabaseServices();

  // @override
  // Future<void> saveUserData(KategoriProdukModel user) {
  //   return service.addUserData(user);
  // }

  @override
  Future<List<ProdukModel>> retrieveAllProduk() {
    return service.getListofProduk();
  }

  @override
  Future<List<KategoriProdukModel>> retrieveKategoriProduk() {
    return service.retrieveKategoriProduk();
  }

  @override
  Future<dynamic> retrieveSpecificProduk(idProduk) {
    service.setDocumentReferenceOfProduk = idProduk;
    return service.getProduk;
  }

  @override
  Future<String> saveFile(file) {
    return service.addFile(file);
  }
  
  set saveProdukData(ProdukModel produkData) {
    service.addProduk = produkData;
  }

  @override
  editProdukData(String pastUploadedImageURL, ProdukModel produkData, idProduk) {
    if (pastUploadedImageURL.isNotEmpty) service.deleteFile = pastUploadedImageURL;
    service.setDocumentReferenceOfProduk = idProduk;
    service.updateProduk = produkData;
  }
}