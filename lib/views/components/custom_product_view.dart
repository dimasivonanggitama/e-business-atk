import 'dart:developer';

import 'package:ebusiness_atk_mobile/views/components/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/katalog/katalog_bloc.dart';
import '../../models/cart_model.dart';
import 'custom_product_row.dart';

class CustomProductView extends StatelessWidget {
  final bool isGridView;
  final List listofProducts;
  final List listofUserCart;
  final int maxColumn;
  final int maxRow;

  CustomProductView({required this.isGridView, required this.listofProducts, this.listofUserCart = const [], this.maxColumn = 0, this.maxRow = 0});
  
  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      int index = 0; // init
      return Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            for (int row = 0; row < maxRow; row++) Row(
              children: [
                for (int column = 0; column < maxColumn && index < listofProducts.length; column++, index++) Padding(
                  padding: EdgeInsets.only(
                    right: (column + 1 == maxColumn)? 0 : 15,
                    bottom: 15
                  ),
                  child: CustomProductCard(
                    gambarProduk:   listofProducts[index].image!,
                    harga:          listofProducts[index].price!,
                    idProduk:       listofProducts[index].documentID!,
                    jumlahStok:     listofProducts[index].stockQuantity!,
                    kategoriProduk: listofProducts[index].category!,
                    namaProduk:     listofProducts[index].name!,
                    merekProduk:    listofProducts[index].brand!,
                  )
                ),
              ],
            )
          ]
        )
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(15),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: 5,
              thickness: 5,
            );
          },
          itemCount: listofProducts.length,
          itemBuilder: (context, index) {
            return CustomProductRow(
              cartID:          listofUserCart[index].documentID,
              cartItemPrice:          listofUserCart[index].documentID,
              image:           listofProducts[index].gambarProduk!,
              productPrice:           listofProducts[index].harga!,
              productID:       listofProducts[index].documentID!,
              // isItemChecked:   cartState.listofUserCart[index].isItemChecked,
              filename: "",
              isItemChecked:   false,
              stockQuantity:   listofProducts[index].jumlahStok!,
              category:        listofProducts[index].kategoriProduk!,
              name:            listofProducts[index].namaProduk!,
              brand:           listofProducts[index].merekProduk!,
              productQuantity: listofUserCart[index].productQuantity,
              userID:          listofUserCart[index].userID
            );
          }
        )
      );
    }
  }
}