import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ebusiness_atk_mobile/models/cart_model.dart';
import 'package:ebusiness_atk_mobile/models/printPrice_model.dart';
import 'package:ebusiness_atk_mobile/repository/printPrice_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

part 'print_service_event.dart';
part 'print_service_state.dart';

class PrintServiceBloc extends Bloc<PrintServiceEvent, PrintServiceInitial> {
  PrintPriceRepository _printPriceRepository = PrintPriceRepository();
  PrintServiceBloc(this._printPriceRepository) : super(PrintServiceInitial(
    colorfulPagePrice: 0,
    documentID: "",
    errorMessage: "",
    filename: "[File belum dipilih]",
    filePath: "",
    fileSelected: File(""),
    grandTotalPrice: 0,
    greyscalePagePrice: 0,
    iconSubmitButton: Icons.add_shopping_cart,
    isSnackBarShowedUp: false,
    isSubmitButtonDisabled: true,
    textSubmitButton: "Tambahkan ke Keranjang",
    totalColorfulPages: 0,
    totalGreyscalePages: 0,
    totalPriceofColorfulPages: 0,
    totalPriceofGreyscalePages: 0
  )) {
    on<FormSubmitted>(
      (event, emit) async {
        CartModel _cartModel = CartModel(
          colorfulPage:    state.totalColorfulPages,
          filename:        state.filename,
          greyscalePage:   state.totalGreyscalePages,
          isItemChecked:   false,
          orderID:         "",
          productID:       "",
          productQuantity: 0,
          userID:          event.userID
        );
        _cartModel.filePath = await _printPriceRepository.saveFile(state.fileSelected);
        _printPriceRepository.savePrintRequest(_cartModel);

        emit(
          state.currentValue(
            iconSubmitButton:       Icons.check_circle,
            isSubmitButtonDisabled: true,
            textSubmitButton:       "Ditambahkan",
          )
        );
        // List _printPrice = await _printPriceRepository.retrievePrintPrice();
        // for (int i = 0; i < _printPrice.length; i++) {
        //   emit(
        //     state.currentValue(
        //       colorfulPagePrice: _printPrice[i].colorfulPagePrice,
        //       documentID: _printPrice[i].documentID,
        //       greyscalePagePrice: _printPrice[i].greyscalePagePrice
        //     )
        //   );
        // }
      }
    );

    on<PrintPriceRequested>(
      (event, emit) async {
        List _printPrice = await _printPriceRepository.retrievePrintPrice();
        for (int i = 0; i < _printPrice.length; i++) {
          emit(
            state.currentValue(
              colorfulPagePrice: _printPrice[i].colorfulPagePrice,
              documentID: _printPrice[i].documentID,
              greyscalePagePrice: _printPrice[i].greyscalePagePrice
            )
          );
        }
      }
    );

    on<PrintPriceSubmitted>(
      (event, emit) async {
        PrintPriceModel _printPriceModel = PrintPriceModel(
          colorfulPagePrice:  event.colorfulPagePrice,
          greyscalePagePrice: event.greyscalePagePrice
        );
        await _printPriceRepository.updatePrintPrice(state.documentID, _printPriceModel);
      }
    );

    on<SelectFilePressed>((event, emit) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['doc', 'docx', 'pdf'],
      );
 
      if (result != null) {
        File file = File(result.files.single.path!); // for file to upload on firebase storage
        PlatformFile _platformFile = result.files.first;  // for properties to upload on firebase firestore
        emit(
          state.currentValue(
            filename: _platformFile.name,
            filePath: _platformFile.path,
            fileSelected: file
          )
        );
        submitButtonCheck(emit);
          // log(file.name);
          // log(file.bytes.toString());
          // log(file.size.toString());
          // log(file.extension.toString());
          // log(file.path.toString());
      } else {
        log("No file selected");
      }
      // await filePicker();
    });

    on<SnackBarDismissed>(
      (event, emit) {
        emit(state.currentValue(isSnackBarShowedUp: false));
      }
    );

    on<TotalColorfulPagesChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            totalColorfulPages: event.totalColorfulPages,
            totalPriceofColorfulPages: event.totalColorfulPages * state.colorfulPagePrice,
          )
        );
        emit(state.currentValue(grandTotalPrice: state.totalPriceofColorfulPages + state.totalPriceofGreyscalePages));
        submitButtonCheck(emit);
      }
    );

    on<TotalGreyscalePagesChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            totalGreyscalePages: event.totalGreyscalePages,
            totalPriceofGreyscalePages: event.totalGreyscalePages * state.greyscalePagePrice,
            grandTotalPrice: state.totalPriceofColorfulPages + state.totalPriceofGreyscalePages,
          )
        );
        emit(state.currentValue(grandTotalPrice: state.totalPriceofColorfulPages + state.totalPriceofGreyscalePages));
        submitButtonCheck(emit);
      }
    );

    on<ValueResetTriggered>(
      (event, emit) {
        emit(
          state.currentValue(
            colorfulPagePrice: 0,
            documentID: "",
            errorMessage: "",
            filename: "[File belum dipilih]",
            filePath: "",
            fileSelected: File(""),
            grandTotalPrice: 0,
            greyscalePagePrice: 0,
            iconSubmitButton: Icons.add_shopping_cart,
            isSnackBarShowedUp: false,
            isSubmitButtonDisabled: true,
            textSubmitButton: "Tambahkan ke Keranjang",
            totalColorfulPages: 0,
            totalGreyscalePages: 0,
            totalPriceofColorfulPages: 0,
            totalPriceofGreyscalePages: 0
          )
        );
      }
    );
  }

  void submitButtonCheck(Emitter<PrintServiceInitial> emit) {
    if (state.filename == "[File belum dipilih]" && state.filePath.isEmpty) {
      emit(state.currentValue(isSubmitButtonDisabled: true));
      // emit(
      //   state.currentValue(
      //     errorMessage: "Kesalahan: File harus dipilih terlebih dahulu!",
      //     isSnackBarShowedUp: true,
      //   )
      // );
    }
    else if (state.totalColorfulPages == 0 && state.totalGreyscalePages == 0) emit(state.currentValue(isSubmitButtonDisabled: true));
    else emit(state.currentValue(isSubmitButtonDisabled: false));

    if (state.textSubmitButton != "Tambahkan ke Keranjang" && state.iconSubmitButton != Icons.add_shopping_cart) {
      emit(
        state.currentValue(
          iconSubmitButton:       Icons.add_shopping_cart,
          textSubmitButton:       "Tambahkan ke Keranjang",
        )
      );
    }
  }

  // filePicker() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['doc', 'docx', 'pdf'],
  //   );

  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //   } else {
  //     print("No file selected");
  //   }
  // }
}
