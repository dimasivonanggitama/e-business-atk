import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_popUpAlert.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/form/form_bloc.dart';
import '../../models/produk_model.dart';
import '../../repository/repository.dart';

class testPage extends StatefulWidget {
  const testPage({Key? key}) : super(key: key);

// AnimationController timerController;

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {

  void test(BuildContext context) async {
    final DatabaseRepository _databaseRepository = DatabaseRepository();
    final double screenWidth = MediaQuery.of(context).size.width;
    int maxItemRow = (screenWidth/180).floor();
    int j;
    int k = 0;
    // int nextRow = maxItemRow;

    log("amountOfItem.: $maxItemRow");
    List<ProdukModel> listofProdukData = await _databaseRepository.retrieveAllProduk();
    log("listofProdukData.length.toString(): ${listofProdukData.length.toString()}");
    // List itemRow = [];
    int listofProdukDataLengthLeft = listofProdukData.length;
    var currentValue;
    // List row = [];
    List row;
    // List row = List.generate((listofProdukData.length/maxItemRow).ceil(), (i) => List.generate(maxItemRow, (j) => listofProdukData[0]));
    row = List.generate(
      (listofProdukData.length/maxItemRow).ceil(), (i) => List.generate(
        maxItemRow, (j) {
          currentValue = listofProdukData[k]; 
          if (listofProdukDataLengthLeft != 0) {
            k++;
            listofProdukDataLengthLeft--;
          }
          if (listofProdukDataLengthLeft < maxItemRow) maxItemRow = listofProdukDataLengthLeft;
          log("i: $i, j: $j, k: $k, maxItemRow: $maxItemRow, listofProdukDataLengthLeft < maxItemRow: ${(listofProdukDataLengthLeft < maxItemRow)}");
          return currentValue;
        }
      )
    );

    // maxItemRow = (screenWidth/180).floor();
    // k = 0;

    // log("maxItemRow: $maxItemRow, (listofProdukData.length/maxItemRow).ceil(): ${(listofProdukData.length/maxItemRow).ceil()}");
    // for (int i = 0; i < (listofProdukData.length/maxItemRow).ceil(); i++) {
    //   log("i: $i");
    //   // for (j = 0; j < nextRow && k < listofProdukData.length; j++) {
    //   for (j = 0; j < maxItemRow && k < listofProdukData.length; j++) {
    //     log(" j: $j");
    //     // newList = [
    //     //   listofProdukData[i],
    //     //   listofProdukData[i]
    //     // ];
    //     // itemRow.add(listofProdukData[k]);
    //     // itemRow.insert(j, listofProdukData[k]);
    //     // itemRow.insert(j, j);
    //     // i = j;
    //     // row.insert(i, listofProdukData[k]);
    //     row[i][j] = listofProdukData[k];
    //     k++;
    //     // if (j + 1 == nextRow || k + 1 == listofProdukData.length) row[i] = itemRow;
    //     // else row[i] = itemRow;
    //   }

    //   // Note: After j's for-loop == false, now the current value of j is same as nextRow or itemCount
    //   // if (j == nextRow && j != listofProdukData.length) {
    //   //   i = j - 1;
    //   //   nextRow += maxItemRow;
    //   // }
    //   // row.add(itemRow);
    //   // row[i] = itemRow;
    //   // row.insert(i, itemRow);
    //   // itemRow.removeLast();

    //   // nextRow += maxItemRow;
    //   // log("nextRow: $nextRow");
    // }
    

    log("\nrow.length.toString(): ${row.length.toString()}");
    for(int i = 0; i < row.length; i++) {
      log("i: $i");
    }

    inspect(row);
    log("321test12345678");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Page"),
      ),
      body: Column(
        children: [

          Center(
            child: TextButton(
              onPressed: () => test(context), 
              child: Text("This is a text button")
            ),
          )

        ],
      ),
    );
    // );
  }

}


