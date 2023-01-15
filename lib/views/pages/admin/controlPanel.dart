import 'package:ebusiness_atk_mobile/bloc/auth_condition/auth_condition_bloc.dart';
import 'package:ebusiness_atk_mobile/bloc/form/product_form/product_form_bloc.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/product_catalogue_admin.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/product_category.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/salesSummary.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin_super/dbms_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/catalogue/catalogue_bloc.dart';
import '../../../bloc/order/order_bloc.dart';
import '../../../bloc/print_service/print_service_bloc.dart';
import 'deliveryFee.dart';
import 'order_admin.dart';
import 'print_price.dart';
import 'tambahProduk.dart';

class ControlPanelPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     //di dalam listview ini terdapat beberapa widget drawable
      //     children: [
      //       UserAccountsDrawerHeader(
      //         //membuat gambar profil
      //         currentAccountPicture: Image(
      //           image: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")
      //         ),
      //         //membuat nama akun
      //         accountName: Text("Sahretech"), 
      //         //membuat nama email
      //         accountEmail: Text("ig: @sahretech"),
      //         //memberikan background
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //             image: NetworkImage("https://cdn.pixabay.com/photo/2016/04/24/20/52/laundry-1350593_960_720.jpg"), 
      //             fit: BoxFit.cover
      //           )
      //         ),
      //       ), 
      //       //membuat list menu
      //       ListTile( leading: Icon(Icons.home), title: Text("Katalog Produk"), onTap: (){
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                   // return tambahProduk(status: "add");
      //                   return katalogProduk();
      //                 }));
      //                 },),
      //       ListTile( leading: Icon(Icons.people), title: Text("Pegawai"), onTap: (){},), 
      //       ListTile( leading: Icon(Icons.money), title: Text("Transaksi"), onTap: (){},), 
      //       Divider(),
      //       ListTile( leading: Icon(Icons.emoji_emotions), title: Text("Profil"), onTap: (){},), 
      //       ListTile( leading: Icon(Icons.info), title: Text("Tentang"), onTap: (){},), 
      //     ],
      //   ),
      // )
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Text("Welcome to Control Panel", style: TextStyle(color: Colors.white)),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Produk", style: TextStyle(color: Colors.white)),
              tileColor: Colors.brown,
            ),
            ListTile( 
              leading: Icon(Icons.production_quantity_limits),
              title: Text("Katalog Produk"),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      // context.read<ProductFormBloc>().add(ProductCatalogueAdminRequested());
                      context.read<CatalogueBloc>().add(CatalogueRequested(context));
                      return ProductCatalogueAdminPage();
                    }
                  )
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.add_box), 
              title: Text("Tambah Produk"), 
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return tambahProduk();
                    }
                  )
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.category), 
              title: Text("Kategori Produk"), 
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      context.read<ProductFormBloc>().add(CategoryDropdownItemsFetched());
                      return ProductCategoryPage();
                    }
                  )
                );
              }
            ),
            ListTile(
              title: Text("Pemesanan", style: TextStyle(color: Colors.white)),
              tileColor: Colors.brown,
            ),
            BlocBuilder<AuthConditionBloc, AuthConditionState>(
              builder: (context, state) {
                return ListTile(
                  leading: Icon(Icons.receipt), 
                  title: Text("Daftar Pemesanan"), 
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) {
                          context.read<OrderBloc>().add(OrdersRequested((state as AuthSuccess).uid));
                          return OrderAdminPage();
                        }
                      )
                    );
                  }
                );
              },
            ),
            ListTile(
              title: Text("Print", style: TextStyle(color: Colors.white)),
              tileColor: Colors.brown,
            ),
            ListTile(
              leading: Icon(Icons.print), 
              title: Text("Harga Dasar Print"), 
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      context.read<PrintServiceBloc>().add(PrintPriceRequested());
                      return PrintPricePage();
                    }
                  )
                );
              }
            ),
            ListTile(
              title: Text("Pengantaran", style: TextStyle(color: Colors.white)),
              tileColor: Colors.brown,
            ),
            ListTile(
              leading: Icon(Icons.delivery_dining), 
              title: Text("Biaya Pengantaran"), 
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return DeliveryFeePage();
                    }
                  )
                );
              }
            ),
            ListTile(
              title: Text("Penjualan", style: TextStyle(color: Colors.white)),
              tileColor: Colors.brown,
            ),
            ListTile(
              leading: Icon(Icons.summarize), 
              title: Text("Rekapan Penjualan"), 
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return SalesSummaryPage();
                    }
                  )
                );
              }
            ),
            Divider(),
            BlocBuilder<AuthConditionBloc, AuthConditionState>(
              builder: (context, state) {
                if ((state is AuthSuccess) && state.status == "superadmin") ListTile(
                  leading: Icon(Icons.data_array), title: Text("Database Management"), onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DBMSFirestorePage();
                    }));
                  }
                );
                return Text("");
              }
            )
          ],
        )
      ),
    );
  }
}