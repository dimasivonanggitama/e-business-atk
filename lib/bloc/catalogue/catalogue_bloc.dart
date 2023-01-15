import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ebusiness_atk_mobile/models/productCategory_model.dart';
import 'package:ebusiness_atk_mobile/repository/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../repository/cart_repository.dart';

part 'catalogue_event.dart';
part 'catalogue_state.dart';

class CatalogueBloc extends Bloc<CatalogueEvent, CatalogueInitial> {
  CartRepository _cartRepository = CartRepository();
  ProductRepository _productRepository;

  CatalogueBloc(this._productRepository) : super(CatalogueInitial(
    documentID: "",
    iconButton: Icons.add_shopping_cart,
    isSubmitButtonDisabled: false,
    listofProductData: [],
    maxColumn: 0,
    maxRow: 0,
    productQuantityCart: 0,
    productQuantityTemporary: 0,
    textButton: "Keranjang",
  )) {

    //on EditProdukPressed

    on<DeleteProductTriggered>(
      (event, emit) async {
        await _productRepository.deleteItem(event.productID);
        await catalogueRequested(event, emit);
      }
    );

    on<CatalogueRequested>(
      (event, emit) async {
        await catalogueRequested(event, emit);
      },
    );

    on<ProductDetailed>(
      (event, emit) async {
        await productDetailed(event, emit);
      }
    );

    on<ProductSubmitted>(
      (event, emit) async {
        CartModel submittedProduct = CartModel(
          colorfulPage:    0,
          filename:        "",
          greyscalePage:   0,
          isItemChecked:   false,
          orderID:         "",
          productID:       event.productID,
          productQuantity: state.productQuantityTemporary,
          userID:          event.userID,
        );
        
        // if (state.productQuantityCart == 0) _cartRepository.saveProduct = submittedProduct;
        if (state.productQuantityCart == 0) _cartRepository.saveProduct(submittedProduct);
        else _cartRepository.updateCart(state.documentID, submittedProduct);
        
        productQuantityCondition(emit);
        await productDetailed(event, emit);
      }
    );

    on<QuantityDecreased>(
      (event, emit) {
        if (state.productQuantityTemporary != 0) emit(state.currentValue(productQuantityTemporary: state.productQuantityTemporary - 1));
        productQuantityCondition(emit);
      }
    );

    on<QuantityIncreased>(
      (event, emit) {
        emit(state.currentValue(productQuantityTemporary: state.productQuantityTemporary + 1));
        productQuantityCondition(emit);
      }
    );
  }

  Future catalogueRequested(dynamic event, Emitter<CatalogueInitial> emit) async {
    final double screenWidth = MediaQuery.of(event.context).size.width;
    List listofProductData = await _productRepository.retrieveAllProducts();
    await convertCategoryIDtoName(listofProductData);
    int maxColumn = (screenWidth/180).floor();
    int maxRow = (listofProductData.length/maxColumn).ceil();

    emit(
      state.currentValue(
        listofProductData: listofProductData,
        maxColumn: maxColumn,
        maxRow: maxRow,
      )
    );
  }

  Future convertCategoryIDtoName(List listofProductData) async {
    List<ProductCategoryModel> listofProductCategory = await _productRepository.retrieveCategories();
    for(int i = 0; i < listofProductData.length; i++) {
      for(int j = 0; j < listofProductCategory.length; j++) {
        if (listofProductData[i].category == listofProductCategory[j].id) listofProductData[i].category = listofProductCategory[j].category;
      }
    }
  }

  Future productDetailed(dynamic event, Emitter<CatalogueInitial> emit) async {
    if (event.userID == "uid") {
      log("not logged yet");
      emit(
        state.currentValue(
          isSubmitButtonDisabled: true,
          productQuantityCart: 0,
          productQuantityTemporary: 0
        )
      );
    } else {
      List<CartModel> similarProductOnCart = await _cartRepository.retrieveSpecificProductUserCart(event.productID, event.userID);
      if (similarProductOnCart.length == 0) {
        log("logged in, NO similar product on cart");
        emit(
          state.currentValue(
            isSubmitButtonDisabled: true,
            productQuantityCart: 0,
            productQuantityTemporary: 0
          )
        );
      } else {
        for (int i = 0; i < similarProductOnCart.length; i++) {
          log("logged in and there is similar product on cart");
          emit(
            state.currentValue(
              documentID: similarProductOnCart[i].documentID,
              isSubmitButtonDisabled: false,
              productQuantityCart: similarProductOnCart[i].productQuantity,
              productQuantityTemporary: similarProductOnCart[i].productQuantity
            )
          );
        }
      };
    }
    productQuantityCondition(emit);
  }

  void productQuantityCondition(Emitter emit) {
    if (state.productQuantityTemporary == 0) {
      emit(
        state.currentValue(
          iconButton: Icons.add_shopping_cart,
          isSubmitButtonDisabled: true,
          textButton: "Keranjang"
        )
      );
    } else if (state.productQuantityTemporary == state.productQuantityCart) {
      emit(
        state.currentValue(
          iconButton: Icons.check_circle,
          isSubmitButtonDisabled: true,
          textButton: "Ditambahkan"
        )
      );
    } else {
      emit(
        state.currentValue(
          iconButton: Icons.add_shopping_cart,
          isSubmitButtonDisabled: false,
          textButton: "Keranjang"
        )
      );
    }
  }
}
