import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukModel {
  final String? documentID;
  // final String? gambarProduk;
  String? gambarProduk;
  // final Future<String>? gambarProduk;
  final int? harga;
  final int? jumlahStok;
  final String? kategoriProduk;
  final String? merekProduk;
  final String? namaProduk;
  ProdukModel({this.documentID, this.gambarProduk, this.harga, this.jumlahStok, this.kategoriProduk, this.merekProduk, this.namaProduk});

  ProdukModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : documentID = doc.id,
      gambarProduk = doc.data()!["gambarProduk"],
      harga = doc.data()!["harga"],
      jumlahStok = doc.data()!["jumlahStok"],
      kategoriProduk = doc.data()!["kategoriProduk"],
      merekProduk = doc.data()!["merekProduk"],
      namaProduk = doc.data()!["namaProduk"];

  Map<String, dynamic> toMap() {
    return {
      'gambarProduk': gambarProduk,
      'harga': harga,
      'jumlahStok': jumlahStok,
      'kategoriProduk': kategoriProduk,
      'merekProduk': merekProduk,
      'namaProduk': namaProduk,
    };
  }

  ProdukModel copyWith({
  final String? gambarProduk,
  // final Future<String>? gambarProduk,
  final int? harga,
  final int? jumlahStok,
  final String? kategoriProduk,
  final String? merekProduk,
  final String? namaProduk
  }) {
    return ProdukModel(
      gambarProduk: gambarProduk ?? this.gambarProduk,
      harga: harga ?? this.harga,
      jumlahStok: jumlahStok ?? this.jumlahStok,
      kategoriProduk: kategoriProduk ?? this.kategoriProduk,
      merekProduk: merekProduk ?? this.merekProduk,
      namaProduk: namaProduk ?? this.namaProduk,
    );
  }
}