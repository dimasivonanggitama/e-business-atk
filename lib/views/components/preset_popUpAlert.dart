import 'package:flutter/material.dart';

class PresetPopUpAlert {
  final BuildContext context;
  final String description;
  final void Function()? firstActionButton;
  final String firstActionButtonText;
  final void Function()? secondActionButton;
  final String? secondActionButtonText;
  final String? title;

  PresetPopUpAlert({
    required this.context, 
    this.title, 
    required this.description, 
    this.firstActionButton, 
    required this.firstActionButtonText, 
    this.secondActionButton,
    this.secondActionButtonText
  }) {
    showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Text(title!),
        content: Text(description),
        actions: <Widget>[
          if (secondActionButton != null) TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              secondActionButton;
            },
            child: Text(secondActionButtonText!),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              // firstActionButton!();
              firstActionButton;
            },
            child: Text(firstActionButtonText),
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
}