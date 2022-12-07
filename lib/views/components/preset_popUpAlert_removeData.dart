import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'custom_button.dart';

class PresetPopUpAlertRemoveData {
  void dialogVoid(BuildContext mainContext, {required String type, var passingSnapshot}) {
    bool deleteSuccess;
    deleteSuccess = false;
    String buttonText = "";
    String contentText = "";
    String titleText = "";

    if (type == "delete confirm") {
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
      context: mainContext,
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
            onPressed: () async {
              await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                await myTransaction.delete(passingSnapshot.docs[0].reference);
              });
              Navigator.pop(context, 'OK');
              deleteSuccess = true;
              // print("this text is supposed to be printed...");
            },
          ),
        ],
      ),
    );
    
    // print("delete Success: $deleteSuccess");
        
    if (deleteSuccess == true) {
      titleText = "Informasi";
      contentText = "Data produk berhasil dihapus.";
      buttonText = "OK";
      showDialog(
        context: mainContext,
        builder: (BuildContext context) => AlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: <Widget>[
            TextButton(
              // onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(buttonText),
              onPressed: () {
                Navigator.pop(context, 'OK');
                deleteSuccess = false;
                // print("this text is supposed to be printed...");
              },
            ),
          ],
        ),
      );
    }
  }

  // void alertSuccess() {
  //   PresetPopUpAlertRemoveData(mainContext, type: "delete success");
  // }
}