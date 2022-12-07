// import 'package:ebusiness_atk_mobile/views/pages/admin/tambahProduk.dart';
// import 'package:ebusiness_atk_mobile/views/pages/beliatk_hasilpencarian.dart';
// import 'package:ebusiness_atk_mobile/views/pages/beliatk_kategori.dart';
// import 'package:ebusiness_atk_mobile/views/pages/print_upload.dart';
// import 'package:ebusiness_atk_mobile/views/pages/test.dart';
import 'dart:developer';

import 'package:ebusiness_atk_mobile/bloc/form/auth_form/auth_form_bloc.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '(backup) beliatk_hasilpencarian.dart';
import '../../bloc/auth_condition/auth_condition_bloc.dart';
// import '../../bloc/form/form_bloc.dart';
import 'admin/tambahProduk.dart';
import 'admin/katalogProduk.dart';
import 'auth_form.dart';
import 'beliatk_hasilpencarian.dart';
import 'beliatk_kategori.dart';
import 'print_upload.dart';
import 'test.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(child: Text("ATK Pak Eko")), 
        actions: [
            // context.read<AuthFormBloc>().add(AuthStarted());

          // BlocListener<AuthConditionBloc, AuthConditionState>(
          //   listener: (context, state) {
          //     context.read<AuthConditionBloc>().add(CurrentAuthRequested());
          //     // List<String> menu = ["a", "b"];
                      
          //             if (state is AuthFailure) log(state.toString());
          //             if (state is AuthSuccess) log(state.toString());

          //   },
          //   child: 
            BlocBuilder<AuthConditionBloc, AuthConditionState>(
              builder: (context, state) {
                context.read<AuthConditionBloc>().add(CurrentAuthRequested());
                // log("state.isAuthValid: ${state.isAuthValid}");
                return PopupMenuButton<int>(
                  // onSelected: (value) => handleClick(value, context),
                  itemBuilder: (BuildContext context) => [
                    //V1: return {'Tambah Produk', 'Katalog Produk', 'Login', 'Katalog Produk User (Old)', 'Test Page'}.map((String choice) {
                      //V2: 
                  //   return {
                  //     'Tambah Produk',
                  //     'Katalog Produk',
                  //     (!state.isAuthValid)? 'Masuk' : 'Keluar'
                  //     // else if (state.isAuthValid) 'Keluar',
                  //     'Katalog Produk User (Old)',
                  //     'Test Page'
                  //   }.map((String choice) {
                  //     return PopupMenuItem<String>(
                  //       value: choice,
                  //       child: Text(choice),
                  //     );
                  //   }).toList();
                  // },
                    PopupMenuItem( 
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Tambah Produk")
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(  
                        children: [
                          Icon(Icons.chrome_reader_mode, color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Katalog Produk")
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Row(  
                        children: [
                          Icon(Icons.chrome_reader_mode, color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Katalog Produk User (Old)")
                        ],
                      ),
                    ),
                    if (state is Unauthorized) PopupMenuItem(
                      value: 4,
                      child: Row(  
                        children: [
                          Icon(Icons.chrome_reader_mode, color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Masuk")
                        ],
                      ),
                    ),
                    if (state is AuthSuccess) PopupMenuItem(
                      value: 5,
                      child: Row(  
                        children: [
                          Icon(Icons.chrome_reader_mode, color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Keluar")
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 5,
                      child: Row(  
                        children: [
                          Icon(Icons.chrome_reader_mode, color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Test Page")
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) async {
                    // if value 1 show dialog
                    // if (value == 1) {
                    //   _showDialog(context);
                    //   // if value 2 show dialog
                    // } else if (value == 2) {
                    //   _showDialog(context);
                    // }
                    
                    switch (value) {
                      case 1:
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return tambahProduk(status: "add");
                        }));
                        break;
                      // case 'Tambah Produk': return tambahProduk();
                      case 2:
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return katalogProduk();
                        }));
                        break;
                      case 3:
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return beliatk_hasilpencarianPageOld();
                        }));
                        break;
                      case 4:
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AuthFormPage();
                        }));
                        break;
                      case 5:
                        context.read<AuthConditionBloc>().add(AuthSignedOut());
                        PresetSnackbar(context: context, message: "Anda telah keluar dari akun");
                        // context.read<AuthConditionBloc>().add(CurrentAuthRequested());
                        // return Text("");
                        break;
                      case 6:
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return testPage();
                        }));
                        break;
                      default:
                        // return Text("");
                    }
                },
                );
              }
            ),
          // ),
        ]
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.white
          color: Colors.amber
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              child: Container(
                  //Card
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Material(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return print_uploadPage();
                              // return testPage();
                              // return tambahProduk();
                              // return katalogProduk();
                            }));
                          },
                          splashColor: Colors.black.withOpacity(0.1),
                          child: Column(children: [
                            Ink.image(image: AssetImage('assets/images/home_Print.jpg'), height: 180, width: 360, fit: BoxFit.cover),
                            Padding(
                                padding: EdgeInsets.all(15),
                                child: (Text("Print",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ))))
                          ])))),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              child: Container(
                  //Card
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return beliatk_hasilpencarianPage();
                            }));
                          },
                          splashColor: Colors.black.withOpacity(0.1),
                          child: Column(children: [Ink.image(image: AssetImage('assets/images/home_Beli ATK.jpg'), height: 180, width: 360, fit: BoxFit.cover), Padding(padding: EdgeInsets.all(15), child: (Text("Beli ATK", style: TextStyle(fontSize: 20))))])))),
            ),
          ]),
        ]),
      ),
    );
  }

  // void handleClick(String value, BuildContext currentContext) {
  //     // context.read
  //     switch (value) {
  //       case 'Tambah Produk':
  //         Navigator.push(currentContext, MaterialPageRoute(builder: (context) {
  //           return tambahProduk(status: "add");
  //         }));
  //         break;
  //       // case 'Tambah Produk': return tambahProduk();
  //       case 'Katalog Produk':
  //         Navigator.push(currentContext, MaterialPageRoute(builder: (context) {
  //         return katalogProduk();
  //         }));
  //         break;
  //       case 'Katalog Produk User (Old)':
  //         Navigator.push(currentContext, MaterialPageRoute(builder: (context) {
  //         return beliatk_hasilpencarianPageOld();
  //         }));
  //         break;
  //       case 'Masuk':
  //       Navigator.push(currentContext, MaterialPageRoute(builder: (context) {
  //         return AuthFormPage();
  //         }));
  //         break;
  //       case 'Keluar':
  //         currentContext.read<AuthFormBloc>().add(AuthSignedOut());
  //         PresetSnackbar(context: currentContext, message: "Anda telah keluar dari akun");
  //         context.read<AuthConditionBloc>().add(CurrentAuthRequested());
  //         // return Text("");
  //         break;
  //       case 'Test Page':
  //       Navigator.push(currentContext, MaterialPageRoute(builder: (context) {
  //         return testPage();
  //         }));
  //         break;
  //       default:
  //         // return Text("");
  //     }
    
  // }
}
