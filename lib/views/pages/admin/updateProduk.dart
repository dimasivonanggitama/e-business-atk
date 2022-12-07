import 'package:ebusiness_atk_mobile/views/pages/admin/produk_form.dart';

import '/views/pages/admin/tambahProduk.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class updateProduk extends StatelessWidget {
  var passingSnapshot;
  int currentIndex;

  updateProduk({this.passingSnapshot, required this.currentIndex});

  String title = "Update Produk";
  String button = "Update";

  @override
  Widget build(BuildContext context) {
    return ProdukFormField(
      title: "Update Produk",
      buttonText: "Update",
      passingSnapshot: passingSnapshot,
      currentIndex: currentIndex
    );
  }
}