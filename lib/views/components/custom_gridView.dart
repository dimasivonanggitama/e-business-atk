import 'package:ebusiness_atk_mobile/views/components/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/katalog/katalog_bloc.dart';

class CustomGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: BlocBuilder<KatalogBloc, KatalogState>(
        builder: (context, state) {
          if (state is KatalogInitial) context.read<KatalogBloc>().add(RowRequested(context));
          else if (state is GenerateRow) {
            return ListView.builder(
              itemCount: state.mappedData.length,
              itemBuilder: (context, row) {
                int column = 0;
                return Row(
                  children: [
                    for(column; column < state.mappedData[row].length; column++) Padding(
                      padding: EdgeInsets.only(
                        right: (column + 1 == state.mappedData[row].length)? 0 : 15,
                        bottom: 15
                      ),
                      child: CustomProductCard(
                        gambarProduk: state.mappedData[row][column].gambarProduk!,
                        harga: state.mappedData[row][column].harga!,
                        idProduk: state.mappedData[row][column].documentID!,
                        jumlahStok: state.mappedData[row][column].jumlahStok!,
                        kategoriProduk: state.mappedData[row][column].kategoriProduk!,
                        namaProduk: state.mappedData[row][column].namaProduk!,
                        merekProduk: state.mappedData[row][column].merekProduk!,
                      )
                    ),
                  ],
                );
              }
            );
          }
          return Container(color: Colors.white);
        }
      ),
    );
  }
}