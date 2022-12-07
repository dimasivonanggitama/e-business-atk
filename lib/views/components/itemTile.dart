import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_popUpAlert_removeData.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/tambahProduk.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/updateProduk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../bloc/form/form_bloc.dart';
import '../../bloc/itemTile_bloc.dart';
import 'preset_popUpAlert.dart';

class itemTile extends StatelessWidget {
  final bool horizontalPadding;
  final String gambarProduk;
  final String idProduk;
  final String namaProduk;
  final String merekProduk;
  final String kategoriProduk;
  final int jumlahStok;
  final int harga;
  // final int currentIndex;
  // final void Function() onDelete;
  // final formatter = NumberFormat('#.000');

  var passingSnapshot;

  itemTile({
    this.horizontalPadding = true, 
    required this.gambarProduk,
    required this.idProduk,
    required this.namaProduk, 
    required this.merekProduk, 
    required this.kategoriProduk, 
    required this.jumlahStok, 
    required this.harga, 
    // required this.currentIndex,
    // required this.onDelete, 
    this.passingSnapshot
  }); 

  // final formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {
    
    // String gambarProduk2 = "";
    // gambarProduk2 = this.widget.passingSnapshot.data!.docs[0]['gambarProduk'];
  // }
  // Widget _itemTile({bool horizontalPadding = true}) {
    double value;
    horizontalPadding ? value = 15: value = 0;
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: EdgeInsets.fromLTRB(value, 6, value, 6),
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
                    // child: Image(
                    //   image: AssetImage('assets/images/home_Beli ATK.jpg'),
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.network(gambarProduk, fit: BoxFit.cover)
                  )
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(1),
                  child: Text(
                    namaProduk,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: Text(merekProduk)
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance.collection('kategori').doc(kategoriProduk).get(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.data();
                        var value = data!['kategori'];
                        return Text(
                          value,
                          style: TextStyle(
                            color: Colors.grey
                          )
                        );
                      }
                      return Center(child: Text('[Kategori Produk]'));
                    },
                  )
                )
              ],
            ),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      // formatter.format(this.widget.harga),
                      harga.toString(),
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Material(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       color: Colors.transparent,
                  //       child: InkWell(
                  //         onTap: (){},
                  //         borderRadius: BorderRadius.all(Radius.circular(15)),
                  //         splashColor: Colors.black.withOpacity(0.1),
                  //         child: Padding(
                  //         padding: EdgeInsets.all(5),
                  //           child: Icon(
                  //             Icons.delete_outline,
                  //             color: Colors.red,
                  //           ),
                  //         )
                  //       ),
                  //     ),
                  //     Material(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       color: Colors.green,
                  //       elevation: 5,
                  //       child: InkWell(
                  //         onTap: (){},
                  //         borderRadius: BorderRadius.all(Radius.circular(15)),
                  //         splashColor: Colors.white.withOpacity(0.8),
                  //         child: Padding(
                  //           padding: EdgeInsets.all(5),
                  //           child: CircleAvatar(
                  //             backgroundColor: Colors.green,
                  //             radius: 10,
                  //             child: Text(
                  //               "-",
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.bold
                  //               )
                  //             ),
                  //           ),
                  //         )
                  //       ),
                  //     ),
                  //     CircleAvatar(
                  //       backgroundColor: Colors.transparent,
                  //       radius: 15,
                  //       child: Text(
                  //         "1",
                  //         style: TextStyle(
                  //           color: Colors.black
                  //         ) 
                  //       ),
                  //     ),
                  //     Material(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       color: Colors.green,
                  //       elevation: 5,
                  //       child: InkWell(
                  //         onTap: (){},
                  //         borderRadius: BorderRadius.all(Radius.circular(15)),
                  //         splashColor: Colors.white.withOpacity(0.8),
                  //         child: Padding(
                  //           padding: EdgeInsets.all(5),
                  //           child: CircleAvatar(
                  //             backgroundColor: Colors.green,
                  //             radius: 10,
                  //             child: Text(
                  //               "+",
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.bold
                  //               )
                  //             ),
                  //           ),
                  //         )
                  //       ),
                  //     ),
                  //   ],
                  // )
                  Text("Stok: ${jumlahStok}")
                ]
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) {
                            // return updateProduk(passingSnapshot: passingSnapshot, currentIndex: currentIndex);
                            context.read<FormBloc>().add(ProdukDataFetched(documentID: idProduk));
                            return tambahProduk();
                            // return Container(color: Colors.white);
                          }
                        )
                      );
                    },
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    splashColor: Colors.black.withOpacity(0.1),
                    child: Padding(
                    padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.green,
                      ),
                    )
                  ),
                ),
              ]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.transparent,
                  child: InkWell(
                    // onTap: () async => await this.onDelete,
                    onTap: () { 
                      // if (this.onDelete != null) 
                      // this.onDelete; 
                      // print("please this work");
                      PresetPopUpAlertRemoveData().dialogVoid(context, type: "delete confirm", passingSnapshot: passingSnapshot

                      
    // print("this text is supposed to be printed...")
                      
                      );
                    },
                    // onTap: () async => await print("test"),
                    // onTap: () {},
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    splashColor: Colors.black.withOpacity(0.1),
                    child: Padding(
                    padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    )
                  ),
                ),
              ]
            )
          ]
        ),
      ),
    );
  }
}