import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/cart_model.dart';
import '../../repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartInitial> {
  CartRepository _cartRepository = CartRepository();
  CartBloc(this._cartRepository) : super(CartInitial(
    iconButton: Icons.add_shopping_cart,
    isSubmitButtonDisabled: false,
    productID: "",
    productQuantityCart: 0,
    productQuantityTemporary: 0,
    textButton: "Keranjang",
    userID: ""
  )) {
    on<ProductDetailed>(
      (event, emit) async {
        if (event.userID == "uid") {
          emit(
            state.currentValue(
              isSubmitButtonDisabled: true,
              productQuantityCart: 0,
              productQuantityTemporary: 0
            )
          );
        } else {
          final similarProductOnCart = await _cartRepository.retrieveUserCart(event.productID, event.userID);
          for (int i = 0; i <= similarProductOnCart.length; i++) {
            if (similarProductOnCart.length == 0) {
              emit(
                state.currentValue(
                  isSubmitButtonDisabled: true,
                  productQuantityCart: 0,
                  productQuantityTemporary: 0
                )
              );
            } else {
              emit(
                state.currentValue(
                  isSubmitButtonDisabled: false,
                  productQuantityCart: similarProductOnCart[i].productQuantity,
                  productQuantityTemporary: similarProductOnCart[i].productQuantity
                )
              );
            };
          }
        }
      }
    );

    on<ProductSubmitted>(
      (event, emit) async {
        CartModel submittedProduct = CartModel(
          productID: event.productID,
          productQuantity: state.productQuantityTemporary,
          userID: event.userID,
        );
        
        if (state.productQuantityCart == 0) _cartRepository.saveProduct = submittedProduct;
        else /*update*/;
      }
    );

    on<QuantityDecreased>(
      (event, emit) {
        emit(state.currentValue(productQuantityTemporary: (state.productQuantityTemporary - 1).abs()));
        productQuantityCondition(emit);
      }
    );

    on<QuantityIncreased>(
      (event, emit) {
        emit(state.currentValue(productQuantityTemporary: (state.productQuantityTemporary + 1).abs()));
        productQuantityCondition(emit);
      }
    );
  }

  void productQuantityCondition(Emitter<CartInitial> emit) {
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
