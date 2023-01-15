import 'dart:developer';

import '../../../bloc/catalogue/catalogue_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../../bloc/form/product_form/product_form_bloc.dart';
import '../../components/preset_popUpAlert.dart';
import 'tambahProduk.dart';

class ProductCatalogueAdminPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Katalog Produk"),
      ),
      // body: BlocBuilder<ProductFormBloc, FormInitial>(
      body: BlocBuilder<CatalogueBloc, CatalogueInitial>(
        builder: (context, state) {
          // return CustomProductView(
          //   isGridView: false, 
          //   listofProdukData: state.listofProductData,
          //   listofUserCart: [],
          // );
          return Padding(
            padding: EdgeInsets.all(15),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 5,
                  thickness: 5,
                );
              },
              itemCount: state.listofProductData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){},
                  child: Padding(
                    // padding: EdgeInsets.fromLTRB(value, 6, value, 6),
                    padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: Row(
                      children: [
                        // Checkbox(value: true),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Container(
                            height: 60,
                            width: 60,
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  state.listofProductData[index].image,
                                  height: 180,
                                  width: 180,
                                  fit: BoxFit.cover,
                                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    else return Padding(
                                      padding: EdgeInsets.all(25),
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              )
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(state.listofProductData[index].name)
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                state.listofProductData[index].category, 
                                style: TextStyle(
                                  color: Colors.grey
                                )
                              )
                            )
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  state.listofProductData[index].price.toString(),
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => PresetPopUpAlert(
                                        context: context, 
                                        title: "Hapus produk",
                                        description: "Apakah anda ingin menghapus produk ini?", 
                                        firstActionButton: () async {
                                          context.read<CatalogueBloc>().add(DeleteProductTriggered(
                                            context: context, 
                                            productID: state.listofProductData[index].documentID)
                                          );
                                          await PresetPopUpAlert(
                                            context: context, 
                                            description: "Item telah dihapus", 
                                            firstActionButtonText: "OK",
                                            firstActionButton: () => Navigator.pop(context, 'OK'),
                                            title: "Hapus item"
                                          );
                                          Navigator.pop(context, 'OK');
                                        },
                                        firstActionButtonText: "Ya",
                                        secondActionButton: () => Navigator.pop(context, 'Cancel'),
                                        secondActionButtonText: "Tidak"
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      splashColor: Colors.black.withOpacity(0.1),
                                      child: Padding(
                                      padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ),
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          context.read<ProductFormBloc>().add(ProductDataFetched(documentID: state.listofProductData[index].documentID)); 
                                          return tambahProduk();
                                        }));
                                      },
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      splashColor: Colors.black.withOpacity(0.1),
                                      child: Padding(
                                      padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      )
                                    ),
                                  ),
                                ]
                              )
                            ]
                          )
                        )
                      ]
                    )
                  )
                );
              }
            )
          );
        },
      )
    );
  }
}