import 'package:ebusiness_atk_mobile/views/components/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomProductDetail {
  final BuildContext context;
  final String gambarProduk;
  final int harga;
  final String idProduk;
  final bool isDetailMode;
  final int jumlahStok;
  final String kategoriProduk;
  final String merekProduk;
  final String namaProduk;

  CustomProductDetail({
    required this.context,
    required this.gambarProduk,
    required this.harga,
    required this.idProduk,
    this.isDetailMode = false,
    required this.jumlahStok,
    required this.kategoriProduk,
    required this.merekProduk,
    required this.namaProduk,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 190), // if not using this, the card will be size of screen dimension
          child: CustomProductCard(
            gambarProduk: gambarProduk,
            harga: harga,
            idProduk: idProduk,
            isDetailMode: isDetailMode,
            jumlahStok: jumlahStok,
            kategoriProduk: kategoriProduk,
            merekProduk: merekProduk,
            namaProduk: namaProduk,
            onTapBackButton: () => Navigator.of(context).pop(),
          ),
        );
      }
    );
  }
}