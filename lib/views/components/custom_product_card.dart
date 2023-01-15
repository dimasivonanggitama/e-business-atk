import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ebusiness_atk_mobile/bloc/katalog/katalog_bloc.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_auth_form.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_button_increaseDecrease.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_condition/auth_condition_bloc.dart';
import '../../bloc/catalogue/catalogue_bloc.dart';
import '../pages/auth_form.dart';
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
    return BlocBuilder<AuthConditionBloc, AuthConditionState>(
      builder: (context, authState) {
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
                if (authState is AuthSuccess) context.read<CatalogueBloc>().add(ProductDetailed(idProduk, authState.uid));
                else context.read<CatalogueBloc>().add(ProductDetailed(idProduk, "uid"));
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
                  // // For image splash effect while tapping on card:
                  // Ink.image(
                  //   height: 180,
                  //   width: 180,
                  //   // colorFilter: ColorFilter.mode(Colors.purple, BlendMode.color),
                  //   image: (gambarProduk != "") 
                  //     ? NetworkImage(gambarProduk) 
                  //     : AssetImage('assets/images/home_Beli ATK.jpg') as ImageProvider,
                  //   fit: BoxFit.cover,
                  // ),
                  
                  // // For image loading progress:
                  Image.network(
                    (gambarProduk != "") 
                      ? gambarProduk
                      : 'assets/images/home_Beli ATK.jpg',
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      else return Padding(
                        padding: EdgeInsets.all(65),
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          namaProduk,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.only(top: 15)),
                          Text(
                            kategoriProduk,
                            style: TextStyle(
                              color: Colors.grey
                            )
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
                              BlocBuilder<CatalogueBloc, CatalogueInitial>(
                                builder: (context, state) {
                                  return CustomButtonIncreaseDecrease(
                                    decreaseOnTap: () => context.read<CatalogueBloc>().add(QuantityDecreased()),
                                    increaseOnTap: () => context.read<CatalogueBloc>().add(QuantityIncreased()),
                                    isBigSize: true,
                                    productQuantityCart: state.productQuantityTemporary
                                    // isDisableBottomPadding: true
                                  );
                                },
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                    isBottomPaddingDisabled: true,
                                    isLeftPaddingDisabled: true,
                                    onTap: onTapBackButton,
                                    text: "Kembali"
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        BlocBuilder<CatalogueBloc, CatalogueInitial>(
                                          builder: (context, catalogueState) {
                                            return CustomButton(
                                              color: Colors.lightGreenAccent.shade200,
                                              icon: catalogueState.iconButton,
                                              iconSize: 18,
                                              isBottomPaddingDisabled: true,
                                              isButtonDisabled: catalogueState.isSubmitButtonDisabled,
                                              isLeftPaddingDisabled: true,
                                              isRightPaddingDisabled: true,
                                              onTap: () {
                                                if (authState is AuthSuccess) {
                                                  // log("Auth is Success. Ready to Go!");
                                                  context.read<CatalogueBloc>().add(ProductSubmitted(idProduk, authState.uid));
                                                }
                                                else Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                  return CustomAuthForm(isInstructionTextShowed: true);
                                                }));
                                              },
                                              text: catalogueState.textButton
                                            );
                                          },
                                        ),
                                      ],
                                    )
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
      },
    );
  }
}