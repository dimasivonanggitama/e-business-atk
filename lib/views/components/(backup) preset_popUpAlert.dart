import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'custom_button.dart';

class PresetPopUpAlertBackup {
  Future dialogFuture(BuildContext context, {required String type}) {
    String buttonText = "";
    String contentText = "";
    String titleText = "";

    if (type == "add") {
      titleText = "Informasi";
      contentText = "Data produk berhasil ditambahkan.";
      buttonText = "OK";
    }
    else if (type == "delete confirm") {
      titleText = "Peringatan";
      contentText = "Apakah anda yakin ingin menghapus data ini?";
      buttonText = "Ya";
    }
    else if (type == "delete success") {
      titleText = "Informasi";
      contentText = "Data produk berhasil dihapus.";
      buttonText = "OK";
    }

    return Future.delayed(Duration.zero,(){
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: <Widget>[
            (type == "delete confirm") ?
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text('Tidak'),
              ) : Text(""),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(buttonText),
            ),
          ],
        ),
      );
    });
  }

  void dialogVoid(BuildContext context, {required String type, required var passingSnapshot}) {
    String buttonText = "";
    String contentText = "";
    String titleText = "";

    if (type == "add") {
      titleText = "Informasi";
      contentText = "Data produk berhasil ditambahkan.";
      buttonText = "OK";
    }
    else if (type == "delete confirm") {
      titleText = "Peringatan";
      contentText = "Apakah anda yakin ingin menghapus data ini?";
      buttonText = "Ya";
    }
    else if (type == "delete success") {
      titleText = "Informasi";
      contentText = "Data produk berhasil dihapus.";
      buttonText = "OK";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titleText),
        content: Text(contentText),
        actions: <Widget>[
          (type == "delete confirm") ?
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text('Tidak'),
            ) : Text(""),
          TextButton(
            // onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(buttonText),
            onPressed: () {
              Navigator.pop(context, 'OK');
    // print("this text is supposed to be printed...");

            },
          ),
        ],
      ),
    );
  }
}