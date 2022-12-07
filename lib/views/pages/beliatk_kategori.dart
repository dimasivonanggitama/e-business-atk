// import 'package:ebusiness_atk_mobile/views/pages/beliatk_hasilpencarian.dart';
import 'package:flutter/material.dart';

import 'beliatk_hasilpencarian.dart';

class beliatk_kategoriPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Beli ATK")
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        "Cari produk",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                )
                              ]
                            ),
                            child: Material(
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                              child: InkWell(
                                onTap: () {},
                                splashColor: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text("Misalnya: Penghapus Staedler 2B"),
                                ),
                              ),
                            )
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(3, 3),
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ]
                          ),
                          child: Material(
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                            color: Colors.grey,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context, MaterialPageRoute(
                                    builder: (context) {
                                      return beliatk_hasilpencarianPage();
                                    }
                                  )
                                );
                              },
                              splashColor: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Cari"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "ATAU",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Row(
                  children: [
                    Text(
                      "Pilih kategori",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _categoryMenu("Alat Tulis"),
                _categoryMenu("Buku Cetak dan Majalah"),
                _categoryMenu("Peralatan olahraga"),
                _categoryMenu("Alat Tulis"),
                _categoryMenu("Buku Cetak dan Majalah"),
                _categoryMenu("Peralatan olahraga"),
                _categoryMenu("Alat Tulis"),
                _categoryMenu("Buku Cetak dan Majalah"),
                _categoryMenu("Peralatan olahraga"),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  Widget _categoryMenu(String _text) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ]
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Ink.image(
                          height: 60,
                          width: 60,
                          // colorFilter: ColorFilter.mode(Colors.purple, BlendMode.color),
                          image: AssetImage('assets/images/home_Beli ATK.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        _text,
                        style: TextStyle(
                          fontSize: 18
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}