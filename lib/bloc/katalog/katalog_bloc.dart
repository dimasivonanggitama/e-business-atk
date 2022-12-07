import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ebusiness_atk_mobile/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/produk_model.dart';

part 'katalog_event.dart';
part 'katalog_state.dart';

class KatalogBloc extends Bloc<KatalogEvent, KatalogState> {
  final DatabaseRepository _databaseRepository;
  KatalogBloc(this._databaseRepository) : super(KatalogInitial()) {

    Future<List<ProdukModel>> _retrieveAllProduk() {
      return _databaseRepository.retrieveAllProduk();
    }

    on<ProdukFetched>(
      (event, emit) async {
        // List<ProdukModel> listofProdukData = await _databaseRepository.retrieveAllProduk();
        List<ProdukModel> listofProdukData = await _retrieveAllProduk();
        emit(ProdukSuccessfullyFetched(listofProdukData));
      }
    );

    //on EditProdukPressed

    //on DeleteProdukPressed

    on<RowRequested>(
      (event, emit) async {
        final double screenWidth = MediaQuery.of(event.context).size.width;
        int maxItemRow = (screenWidth/180).floor(); // max item in a row
        int j;
        int k = 0;
        // int nextRow = maxItemRow;

        log("amountOfItem.: $maxItemRow");
        List<ProdukModel> listofProdukData = await _retrieveAllProduk();
        log("listofProdukData.length.toString(): ${listofProdukData.length.toString()}");
        int listofProdukDataLengthLeft = listofProdukData.length;

        var currentValue;
        List mappedData;
        // List row = List.generate((listofProdukData.length/maxItemRow).ceil(), (i) => List.generate(maxItemRow, (j) => listofProdukData[0]));
        mappedData = List.generate(
          (listofProdukData.length/maxItemRow).ceil(), (i) => List.generate(
            maxItemRow, (j) {
              log("i: $i, j: $j, k: $k, maxItemRow: $maxItemRow, listofProdukDataLengthLeft < maxItemRow: ${(listofProdukDataLengthLeft < maxItemRow)}");
              currentValue = listofProdukData[k]; 
              if (listofProdukDataLengthLeft != 0) {
                k++;
                listofProdukDataLengthLeft--;
              }
              if (listofProdukDataLengthLeft < maxItemRow) maxItemRow = listofProdukDataLengthLeft;
              return currentValue;
            }
          )
        );
        
        /* Note: 
          listofProdukData.length/maxItemRow).ceil() = total row needed
          i = current row index
          j = current column index in a row
          k = current data index
          currentValue = current data value
        */

        log("\nrow.length.toString(): ${mappedData.length.toString()}");
        for(int i = 0; i < mappedData.length; i++) {
          log("i: $i");
        }

        inspect(mappedData);
        log("321test123");
        emit(GenerateRow(mappedData));

      },
    );
  }
}
