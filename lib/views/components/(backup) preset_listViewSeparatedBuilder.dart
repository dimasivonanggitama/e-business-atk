import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_product_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/views/components/preset_popUpAlert.dart';

class PresetListViewSeparatedBuilder extends StatelessWidget {
  var snapshotDataDocs;

  final String collection;
  PresetListViewSeparatedBuilder({required this.collection});

  // final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance.collection('produk_atk').snapshots();
  final CollectionReference produk_atk = FirebaseFirestore.instance.collection('produk_atk');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // stream: _productStream,
      stream: produk_atk.snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          print("Data ada yang salah");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: 5,
              thickness: 5,
            );
          },
          // itemCount: totalItem,
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            // return Card( // add row, add more snapshot
            //   child: Row(
            //     children: [
            //       Text("${snapshotDataDocs[index]['namaProduk']}"),
            //       Text("${snapshotDataDocs[index]['merekProduk']}"),
            //       Text("${snapshotDataDocs[index]['jumlahStok']}"),
            //       Text("${snapshotDataDocs[index]['harga']}"),
            //     ],
            //   ),
            // );
            return Container();
            // return CustomProductRow(
              // gambarProduk: snapshot.data!.docs[index]['gambarProduk'],
              // namaProduk: snapshot.data!.docs[index]['namaProduk'], 
              // merekProduk: snapshot.data!.docs[index]['merekProduk'], 
              // kategoriProduk: snapshot.data!.docs[index]['kategoriProduk'],
              // jumlahStok: snapshot.data!.docs[index]['jumlahStok'], 
              // harga: snapshot.data!.docs[index]['harga'],
              // idProduk: index.toString(),
              // // onDelete: produk_atk.where('id', isEqualTo: )
              // onDelete: produk_atk.doc().delete()

              // onDelete: PresetPopUpAlert().dialogFuture(context, type: "delete confirm")
              // onDelete: test,
              // await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
              //   await myTransaction.delete(snapshot.data!.docs[index].reference);
              // })

              // passingSnapshot: snapshot,

            // );
          },
        );
      }
    );
  }

  void test() {
    print("this is working");
  }
  
}