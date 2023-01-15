import 'dart:developer';

import 'package:flutter/material.dart';

Future PresetPopUpWidgets({
  required BuildContext context,
  final double paddingHorizontal = 15,
  final double paddingVertical = 15,
  final List<Widget>? listofWidgets,
  final double listofWidgetsHeightApprox = 0,
  required final String title,
}) {
  double symmetricVerticalPadding = (MediaQuery.of(context).size.height)/2 - listofWidgetsHeightApprox;
  return showDialog(
    context: context,
    builder: (BuildContext context) => ListView(
      children: [
        Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: symmetricVerticalPadding),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Column(children: listofWidgets!),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}



  // Future dialogFuture(BuildContext context, {required String type}) {
  //   String buttonText = "";
  //   String contentText = "";
  //   String titleText = "";

  //   if (type == "add") {
  //     titleText = "Informasi";
  //     contentText = "Data produk berhasil ditambahkan.";
  //     buttonText = "OK";
  //   }
  //   else if (type == "delete confirm") {
  //     titleText = "Peringatan";
  //     contentText = "Apakah anda yakin ingin menghapus data ini?";
  //     buttonText = "Ya";
  //   }
  //   else if (type == "delete success") {
  //     titleText = "Informasi";
  //     contentText = "Data produk berhasil dihapus.";
  //     buttonText = "OK";
  //   }

  //   return Future.delayed(Duration.zero,(){
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: Text(titleText),
  //         content: Text(contentText),
  //         actions: <Widget>[
  //           (type == "delete confirm") ?
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, 'OK'),
  //               child: Text('Tidak'),
  //             ) : Text(""),
  //           TextButton(
  //             onPressed: () => Navigator.pop(context, 'OK'),
  //             child: Text(buttonText),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  // void dialogVoid(BuildContext context, {required String type, required var passingSnapshot}) {
  //   String buttonText = "";
  //   String contentText = "";
  //   String titleText = "";

  //   if (type == "add") {
  //     titleText = "Informasi";
  //     contentText = "Data produk berhasil ditambahkan.";
  //     buttonText = "OK";
  //   }
  //   else if (type == "delete confirm") {
  //     titleText = "Peringatan";
  //     contentText = "Apakah anda yakin ingin menghapus data ini?";
  //     buttonText = "Ya";
  //   }
  //   else if (type == "delete success") {
  //     titleText = "Informasi";
  //     contentText = "Data produk berhasil dihapus.";
  //     buttonText = "OK";
  //   }

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Text(titleText),
  //       content: Text(contentText),
  //       actions: <Widget>[
  //         (type == "delete confirm") ?
  //           TextButton(
  //             onPressed: () => Navigator.pop(context, 'OK'),
  //             child: Text('Tidak'),
  //           ) : Text(""),
  //         TextButton(
  //           // onPressed: () => Navigator.pop(context, 'OK'),
  //           child: Text(buttonText),
  //           onPressed: () {
  //             Navigator.pop(context, 'OK');
  //   // print("this text is supposed to be printed...");

  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
