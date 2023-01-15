// import 'package:ebusiness_atk_mobile/views/pages/keranjang.dart';
import 'package:flutter/material.dart';

import 'cart.dart';

class print_previewPage extends StatefulWidget {
  const print_previewPage({Key? key}) : super(key: key);

  @override
  State<print_previewPage> createState() => _print_previewPageState();
}

class _print_previewPageState extends State<print_previewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Print"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              //createTitle("Preview")
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Preview",
                    style: TextStyle(fontSize: 30)
                  )
                ]
              )
            ),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.white
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Nama File: skripsi.docx"),
                                    Text("Halaman yang mengandung tinta warna dan gambar:"),
                                    Text("5 x 400 = 2000"),
                                    Text("Halaman yang mengandung tinta hitam:"),
                                    Text("25 x 200 = 5000"),
                                    Text("Total yang harus dibayar: 7.000"),
                                  ],
                                ),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(                
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Material(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              elevation: 5,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(
                                    context, true
                                  );
                                },
                                splashColor: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text("Kembali")
                                )
                              )
                            ),
                          ),
                          //Spacer(),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Material(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Colors.green[300],
                              elevation: 5,
                              child: InkWell(
                                onTap: () {
                                  
                                    Navigator.push(
                                      context, MaterialPageRoute(
                                        builder: (context) {
                                          return CartPage();
                                        }
                                      )
                                    );
                                },
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                splashColor: Colors.white.withOpacity(0.3),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text("Tambahkan ke Keranjang")
                                )
                              )
                            )
                          )
                        ]
                      )
                    )
                  )
                ],
              )
            )
          ]
        )
      )
    );
  }
}

