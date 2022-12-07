import 'package:cloud_firestore/cloud_firestore.dart';

class KatalogModel {
  final String? gambarProduk;
  final int? harga;
  final int? jumlahStok;
  final String? kategoriProduk;
  final String? merekProduk;
  final String? namaProduk;
  KatalogModel({this.gambarProduk, this.harga, this.jumlahStok, this.kategoriProduk, this.merekProduk, this.namaProduk});

  KatalogModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : gambarProduk = doc.data()!["gambarProduk"],
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

  KatalogModel currentValue({
  final String? gambarProduk,
  final int? harga,
  final int? jumlahStok,
  final String? kategoriProduk,
  final String? merekProduk,
  final String? namaProduk
  }) {
    return KatalogModel(
      gambarProduk: gambarProduk ?? this.gambarProduk,
      harga: harga ?? this.harga,
      jumlahStok: jumlahStok ?? this.jumlahStok,
      kategoriProduk: kategoriProduk ?? this.kategoriProduk,
      merekProduk: merekProduk ?? this.merekProduk,
      namaProduk: namaProduk ?? this.namaProduk,
    );
  }
}