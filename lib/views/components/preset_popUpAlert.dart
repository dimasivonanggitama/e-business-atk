import 'package:flutter/material.dart';

Future PresetPopUpAlert({
  required BuildContext context,
  required String description,
  void Function()? firstActionButton,
  required String firstActionButtonText,
  final void Function()? secondActionButton,
  final String? secondActionButtonText,
  required final String? title
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title!),
      content: Text(description),
      actions: [
        if (secondActionButton != null) TextButton(
          onPressed: secondActionButton,
          child: Text(secondActionButtonText!),
        ),
        TextButton(
          onPressed: firstActionButton,
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
