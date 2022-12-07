import 'dart:developer';

import '../../../bloc/katalog/katalog_bloc.dart';
import '../../components/itemTile.dart';
import '../../components/preset_listViewSeparatedBuilder.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class katalogProduk extends StatelessWidget {
  const katalogProduk({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Katalog Produk"),
      ),
      body: BlocBuilder<KatalogBloc, KatalogState>(
        builder: (context, state) {
          if (state is KatalogInitial) context.read<KatalogBloc>().add(ProdukFetched());
          else if (state is ProdukSuccessfullyFetched) {
            return PresetListViewSeparatedBuilder( 
              itemCount: state.listofProdukData.length,
              itemBuilder: (context, index) {
                return itemTile(
                  gambarProduk: state.listofProdukData[index].gambarProduk!,
                  harga: state.listofProdukData[index].harga!,
                  idProduk: state.listofProdukData[index].documentID!,
                  jumlahStok: state.listofProdukData[index].jumlahStok!,
                  kategoriProduk: state.listofProdukData[index].kategoriProduk!,
                  namaProduk: state.listofProdukData[index].namaProduk!, 
                  merekProduk: state.listofProdukData[index].merekProduk!,
                );
              },
            );
          }
          return Container(color: Colors.white);
        },
      )
      
    );
  }
}