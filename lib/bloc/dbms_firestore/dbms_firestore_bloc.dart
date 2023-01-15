import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ebusiness_atk_mobile/models/cart_model.dart';
import 'package:ebusiness_atk_mobile/models/productCategory_model.dart';
import 'package:ebusiness_atk_mobile/repository/dbms_firebase_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';
import '../../models/user_model.dart';

part 'dbms_firestore_event.dart';
part 'dbms_firestore_state.dart';

class DBMSFirestoreBloc extends Bloc<DBMSFirestoreEvent, DBMSFirestoreInitial> {
  DBMSFirestoreRepository _dbmsFirestoreRepository = DBMSFirestoreRepository();
  DBMSFirestoreBloc(this._dbmsFirestoreRepository) : super(DBMSFirestoreInitial(
    firstFieldErrorMessage: "",
    firstFieldValue: "",
    isFirstFieldEmpty: true,
    isFirstFieldEverTyped: false,
    isSecondFieldEmpty: true,
    isSecondFieldEverTyped: false,
    secondFieldErrorMessage: "",
    secondFieldValue: ""
  )) {
    on<CollectionRequested>(
      (event, emit) {
        // _dbmsFirestoreRepository.getData();
      }
    );

    on<DeleteCollectionTriggered>(
      (event, emit) {
        // popUpMessage
      }
    );

    on<DuplicateCollectionTriggered>(
      (event, emit) async {
        if (state.isFirstFieldEmpty == false) {
          // List<ProductModel> listofCollectionTarget = await _dbmsFirestoreRepository.retrieveProducts(state.firstFieldValue);
          // for (int i = 0; i < listofCollectionTarget.length; i++) {
          //   ProductModel productModel = ProductModel(
          //     documentID:    listofCollectionTarget[i].documentID,
          //     brand:         listofCollectionTarget[i].brand,
          //     category:      listofCollectionTarget[i].category,
          //     image:         listofCollectionTarget[i].image,
          //     name:          listofCollectionTarget[i].name,
          //     price:         listofCollectionTarget[i].price,
          //     stockQuantity: listofCollectionTarget[i].stockQuantity
          //   );
          
          // List<ProductCategoryModel> listofCollectionTarget = await _dbmsFirestoreRepository.retrieveProductCategories(state.firstFieldValue);
          // for (int i = 0; i < listofCollectionTarget.length; i++) {
          //   ProductCategoryModel productCategoryModel = ProductCategoryModel(
          //     id:       listofCollectionTarget[i].id,
          //     category: listofCollectionTarget[i].category
          //   );
          //   await _dbmsFirestoreRepository.createCollectionWithCustomDocumentID(listofCollectionTarget[i].id!, state.secondFieldValue, productCategoryModel);
          // }
          
          // List<UserModel> listofCollectionTarget = await _dbmsFirestoreRepository.retrieveUsers(state.firstFieldValue);
          // for (int i = 0; i < listofCollectionTarget.length; i++) {
          //   UserModel productCategoryModel = UserModel(
          //     address:       listofCollectionTarget[i].address,
          //     email: listofCollectionTarget[i].email,
          //     name: listofCollectionTarget[i].name,
          //     password: listofCollectionTarget[i].password,
          //     phoneNumber: listofCollectionTarget[i].phoneNumber,
          //     status: listofCollectionTarget[i].status
          //   );
          //   await _dbmsFirestoreRepository.createCollectionWithCustomDocumentID(listofCollectionTarget[i].userID!, state.secondFieldValue, productCategoryModel);
          // }
        }
      }
    );

    on<FirstFieldOnChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            firstFieldValue: event.firstFieldValue,
            isFirstFieldEmpty: (event.firstFieldValue.isEmpty)? true : false,
            isFirstFieldEverTyped: true
          )
        );
      }
    );

    on<SecondFieldOnChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            secondFieldValue: event.secondFieldValue,
            isFirstFieldEmpty: (event.secondFieldValue.isEmpty)? true : false,
            isSecondFieldEverTyped: true
          )
        );
      }
    );
  }

  // Future<void> _popUpDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('AlertDialog Title'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: const <Widget>[
  //               Text('This is a demo alert dialog.'),
  //               Text('Would you like to approve of this message?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Approve'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}