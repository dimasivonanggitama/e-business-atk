import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/bloc/cart/cart_bloc.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_auth_form.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_button_increaseDecrease.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_condition/auth_condition_bloc.dart';
import 'custom_product_detail.dart';

class CustomProductCard extends StatelessWidget {
  final String gambarProduk;
  final int harga;
  final String idProduk;
  final bool isDetailMode;
  // final bool isProductSelected;
  final int jumlahStok;
  final String kategoriProduk;
  final String merekProduk;
  final String namaProduk;
  final Function()? onTapBackButton;

  final double height, width;

  CustomProductCard({
    required this.gambarProduk,
    required this.harga,
    required this.idProduk,
    this.isDetailMode = false,
    // required this.isProductSelected,
    required this.jumlahStok,
    required this.kategoriProduk,
    required this.merekProduk,
    required this.namaProduk,
    this.onTapBackButton,

    this.height = 350,
    this.width = 180
  });
  
  Widget build(BuildContext context) {
    bool showButtons = false;
    bool turnOffSplashEffect = false;
    // return Padding(
    //   padding: EdgeInsets.all(15.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border.all(),
    //       borderRadius: BorderRadius.circular(5)
    //     ),
    //     // child: ListView.builder(
    //     //   itemCount: , 
    //     //   itemBuilder: itemBuilder
    //     // ),
    //   ),
    // );
    return Container(
      clipBehavior: Clip.antiAlias,
      height: /*isDetailMode? null :*/ height,
      width: /*isDetailMode? null :*/ width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), 
        borderRadius: BorderRadius.circular(15), 
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3, 3),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ]
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: isDetailMode? null : () {
            // context.read<CartBloc>().add(ProductDetailed(idProduk, 1, state.uid));
            CustomProductDetail(
              context: context,
              merekProduk: merekProduk,
              namaProduk: namaProduk,
              gambarProduk: gambarProduk,
              idProduk: idProduk,
              isDetailMode: true,
              harga: harga,
              kategoriProduk: kategoriProduk,
              jumlahStok: jumlahStok,
            );
            // isDetailMode else null;
          }, //turnOffSplashEffect? null : _showPreview,
          splashColor: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Ink.image(
                height: 180,
                width: 180,
                // colorFilter: ColorFilter.mode(Colors.purple, BlendMode.color),
                image: (gambarProduk != "") 
                  ? NetworkImage(gambarProduk) 
                  : AssetImage('assets/images/home_Beli ATK.jpg') as ImageProvider,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "Item Produk ke-${index + 1}",
                      namaProduk,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    // Text(
                    //   kategoriProduk,
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //   )
                    // ),
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance.collection('kategori').doc(kategoriProduk).get(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data();
                          var value;
                          if (data != null) value = data['kategori'];
                          else value = "[Kategori Produk tidak ditemukan]";
                          return Text(
                            value,
                            style: TextStyle(
                              color: Colors.grey
                            )
                          );
                        }
                        return Center(child: Text('[Kategori Produk]'));
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Text(
                      harga.toString(), 
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    if (isDetailMode) Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          CustomButtonIncreaseDecrease(
                            decreaseOnTap: () {
                              // if logged in
                              context.read<CartBloc>().add(QuantityDecreased());
                              // else pop up auth component
                            },
                            increaseOnTap: () {
                              // if logged in
                              context.read<CartBloc>().add(QuantityIncreased());
                              // else pop up auth component
                            },
                            isBigSize: true,
                            // isDisableBottomPadding: true
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                isDisableBottomPadding: true,
                                isDisableLeftPadding: true,
                                onTap: onTapBackButton,
                                text: "Kembali"
                              ),
                              Expanded(
                                flex: 1,
                                child: BlocBuilder<AuthConditionBloc, AuthConditionState>(
                                  builder: (context, state) {
                                    return CustomButton(
                                      color: Colors.lightGreenAccent.shade200,
                                      icon: Icons.add_shopping_cart,
                                      iconSize: 18,
                                      isDisableBottomPadding: true,
                                      isDisableLeftPadding: true,
                                      isDisableRightPadding: true,
                                      onTap: () {
                                        if (state is AuthSuccess) /*log("Auth is Success. Ready to Go!");*/ ;//context.read<CartBloc>().add(ProductSubmitted(123, 1, state.uid));
                                        else showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 125), // if not using this, the card will be size of screen dimension
                                              child: CustomAuthForm(isInstructionTextShowed: true)
                                            );
                                          }
                                        );
                                      },
                                      text: "Keranjang"
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}