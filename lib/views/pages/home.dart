// import 'package:ebusiness_atk_mobile/views/pages/admin/tambahProduk.dart';
// import 'package:ebusiness_atk_mobile/views/pages/beliatk_hasilpencarian.dart';
// import 'package:ebusiness_atk_mobile/views/pages/beliatk_kategori.dart';
// import 'package:ebusiness_atk_mobile/views/pages/print_upload.dart';
// import 'package:ebusiness_atk_mobile/views/pages/test.dart';
import 'dart:developer';

import 'package:ebusiness_atk_mobile/bloc/form/auth_form/auth_form_bloc.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_snackbar.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/controlPanel.dart';
// import 'package:ebusiness_atk_mobile/views/pages/(backup)%20keranjang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '(backup) beliatk_hasilpencarian.dart';
import '../../bloc/auth_condition/auth_condition_bloc.dart';
// import '../../bloc/form/form_bloc.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/catalogue/catalogue_bloc.dart';
// import '../../bloc/katalog/katalog_bloc.dart';
import '../../bloc/order/order_bloc.dart';
import '../../bloc/print_service/print_service_bloc.dart';
import 'admin/tambahProduk.dart';
import 'admin/product_catalogue_admin.dart';
import 'auth_form.dart';
import 'order.dart';
import 'product_catalogue.dart';
import 'beliatk_kategori.dart';
import 'cart.dart';
import 'print_service.dart';
import 'test.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(child: Text("ATK Pak Eko")), 
        actions: [
          BlocBuilder<AuthConditionBloc, AuthConditionState>(
            builder: (context, state) {
              context.read<AuthConditionBloc>().add(CurrentAuthRequested());
              return PopupMenuButton<int>(
                itemBuilder: (BuildContext context) => [
                  if ((state is AuthSuccess) && state.status != "admin") PopupMenuItem( 
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.receipt, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Daftar Pemesanan")
                      ],
                    ),
                  ),
                  if ((state is AuthSuccess) && state.status != "admin") PopupMenuItem( 
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Keranjang")
                      ],
                    ),
                  ),
                  if ((state is AuthSuccess) && state.status != "regular") PopupMenuItem( 
                  // PopupMenuItem( 
                    value: 3,
                    child: Row(
                      children: [
                        Icon(Icons.local_police, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Control Panel")
                      ],
                    ),
                  ),
                  if ((state is AuthSuccess) && state.status == "superadmin") PopupMenuItem(
                    value: 4,
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
                    value: 5,
                    child: Row(  
                      children: [
                        Icon(Icons.key, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Masuk")
                      ],
                    ),
                  ),
                  if (state is AuthSuccess) PopupMenuItem(
                    value: 6,
                    child: Row(  
                      children: [
                        Icon(Icons.power_settings_new, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Log Out")
                      ],
                    ),
                  ),
                  if ((state is AuthSuccess) && state.status == "superadmin") PopupMenuItem(
                    value: 7,
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
                  switch (value) {
                    // case 'Tambah Produk': return tambahProduk();
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        // if (state is AuthSuccess) context.read<OrderBloc>().add(OrderRequested(state.uid));
                        if (state is AuthSuccess) context.read<OrderBloc>().add(OrdersRequested(state.uid));
                        return OrderPage();
                      }));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        if (state is AuthSuccess) context.read<CartBloc>().add(CartRequested(state.uid));
                        return CartPage();
                      }));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        // return tambahProduk(status: "add");
                        return ControlPanelPage();
                      }));
                      break;
                    case 4:
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return beliatk_hasilpencarianPageOld();
                      }));
                      break;
                    case 5:
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AuthFormPage();
                      }));
                      break;
                    case 6:
                      context.read<AuthConditionBloc>().add(AuthSignedOut());
                      PresetSnackbar(context: context, message: "Anda telah keluar dari akun");
                      // context.read<AuthConditionBloc>().add(CurrentAuthRequested());
                      // return Text("");
                      break;
                    case 7:
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
        ]
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.amber),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
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
                          context.read<PrintServiceBloc>().add(ValueResetTriggered());
                          context.read<PrintServiceBloc>().add(PrintPriceRequested());
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return PrintServicePage();
                          }));
                        },
                        splashColor: Colors.black.withOpacity(0.1),
                        child: Column(
                          children: [
                            Ink.image(image: AssetImage('assets/images/home_Print.jpg'), height: 180, width: 360, fit: BoxFit.cover),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: (
                                Text("Print", style: TextStyle(fontSize: 20))
                              )
                            )
                          ]
                        )
                      )
                    )
                  ),
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
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
                          context.read<CatalogueBloc>().add(CatalogueRequested(context));
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ProductCataloguePage();
                          }));
                        },
                        splashColor: Colors.black.withOpacity(0.1),
                        child: Column(
                          children: [
                            Ink.image(image: AssetImage('assets/images/home_Beli ATK.jpg'), height: 180, width: 360, fit: BoxFit.cover), 
                            Padding(
                              padding: EdgeInsets.all(15), 
                              child: (
                                Text("Beli ATK", style: TextStyle(fontSize: 20))
                              )
                            )
                          ]
                        )
                      )
                    )
                  ),
                ),
              ]
            ),
          ]
        ),
      ),
    );
  }
}
