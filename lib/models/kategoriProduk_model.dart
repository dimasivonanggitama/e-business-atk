import 'package:cloud_firestore/cloud_firestore.dart';

class KategoriProdukModel {
  final String? id;
  final String? kategori;
  KategoriProdukModel({this.id, this.kategori});

  KategoriProdukModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : id = doc.data()!["id"],
      kategori = doc.data()!["kategori"];
      // displayName = doc.data()!["displayName"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategori': kategori
    };
  }

  KategoriProdukModel copyWith({
    String? uid,
    String? id,
    String? kategori
  }) {
    return KategoriProdukModel(
      id: id ?? this.id,
      kategori: kategori ?? this.kategori,
    );
  }
}