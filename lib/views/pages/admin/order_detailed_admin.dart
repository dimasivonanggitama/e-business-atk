import 'dart:developer';

import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_subHeading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/order/order_bloc.dart';
import '../../components/convert_decimalSeparator.dart';
import '../../components/custom_twoText_oneRow.dart';
import '../../components/preset_popUpAlert.dart';

class OrderDetailedAdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detil Pemesanan"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: BlocBuilder<OrderBloc, OrderInitial>(
              builder: (context, state) {
                return Column(
                  children: [
                    CustomTwoTextOneRow(leftText: "Kode pemesanan:", rightText: state.orderID),
                    CustomTwoTextOneRow(flexLeftText: 2, flexRightText: 3, leftText: "Waktu pemesanan:", rightText: DateFormat("dd MMMM yyyy, HH:mm WIB").format(state.timestamp.toDate())),
                    CustomTwoTextOneRow(flexLeftText: 2, flexRightText: 3, leftText: "Nama pemesan:", rightText: state.userName),
                    CustomTwoTextOneRow(flexLeftText: 2, flexRightText: 3, leftText: "Status pemesanan:", rightText: state.status),
                    CustomButton(
                      color: Colors.lightGreenAccent.shade200,
                      isButtonDisabled: (state.status == "Selesai")? true : false,
                      onTap: () => PresetPopUpAlert(
                        context: context, 
                        title: "Update status pemesanan",
                        description: "Apakah anda ingin melakukan update status pemesanan?", 
                        firstActionButton: () async {
                          context.read<OrderBloc>().add(ChangeOrderStatusTriggered(state.orderID, state.status, state.userID));
                          await PresetPopUpAlert(
                            context: context, 
                            description: "Status pemesanan telah dilakukan update.", 
                            firstActionButtonText: "OK",
                            firstActionButton: () => Navigator.pop(context, 'OK'),
                            title: "Update status pemesanan"
                          );
                          Navigator.pop(context, 'OK');
                        },
                        firstActionButtonText: "Ya",
                        secondActionButton: () => Navigator.pop(context, 'Cancel'),
                        secondActionButtonText: "Tidak"
                      ),
                      text: state.changeOrderStatusButtonText,
                    ),
                    CustomSubHeading(text: "Detil item"),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: ListView.separated(                    
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 15,
                            thickness: 1,
                          );
                        },
                        itemCount: state.listofSelectedItems.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(15),
                                    elevation: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: (state.listofSelectedItems[index].productImage.isEmpty)? Image(image: AssetImage('assets/images/home_Print_small.jpg'), fit: BoxFit.cover) : Image.network(
                                        state.listofSelectedItems[index].productImage,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      width: 200,
                                      child: Text((state.listofSelectedItems[index].productName.isEmpty)? state.listofSelectedItems[index].filename : state.listofSelectedItems[index].productName, maxLines: 2, overflow: TextOverflow.ellipsis)
                                    )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      (state.listofSelectedItems[index].productCategory.isEmpty)? "Print" : state.listofSelectedItems[index].productCategory, 
                                      style: TextStyle(
                                        color: Colors.grey
                                      )
                                    )
                                  ),
                                  if (state.listofSelectedItems[index].productCategory.isEmpty) Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "${state.listofSelectedItems[index].colorfulPage} halaman berwarna",
                                    )
                                  ),
                                  if (state.listofSelectedItems[index].productCategory.isEmpty) Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "${state.listofSelectedItems[index].greyscalePage} halaman hitam-putih",
                                    )
                                  ),
                                  if (state.listofSelectedItems[index].productCategory.isEmpty) Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Total halaman: ${state.listofSelectedItems[index].colorfulPage + state.listofSelectedItems[index].greyscalePage} halaman",
                                    )
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                        (state.listofSelectedItems[index].productQuantity == 0)? "1 file" : "${state.listofSelectedItems[index].productQuantity} barang",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        decimalSeparator(state.listofSelectedItems[index].cartItemPrice),
                                        style: TextStyle(
                                          fontSize: 17
                                        ),
                                      ),
                                    ),
                                  ]
                                )
                              )
                            ]
                          );
                        }
                      )
                    ),
                    CustomSubHeading(text: "Info pengiriman"),
                    CustomTwoTextOneRow(leftText: "Opsi pengantaran:", rightText: (state.deliveryFee == 0)? "Tidak" : "Ya"),
                    if (state.deliveryFee != 0) CustomTwoTextOneRow(flexLeftText: 2, flexRightText: 4, leftText: "Alamat:", rightText: state.address, rightTextAlign: TextAlign.justify),
                    if (state.deliveryFee != 0) CustomTwoTextOneRow(flexLeftText: 2, flexRightText: 4, leftText: "Nomor telepon:", rightText: state.phoneNumber),
                    CustomSubHeading(text: "Rincian pembayaran"),
                    CustomTwoTextOneRow(leftText: "Metode pembayaran:", rightText: state.paymentMethod),
                    CustomTwoTextOneRow(leftText: "Jumlah item dari layanan print:", rightText: "${state.totalPrintItems} file"),
                    CustomTwoTextOneRow(leftText: "Jumlah item dari beli ATK:", rightText: "${state.totalProductItems} produk"),
                    if (state.deliveryFee != 0) CustomTwoTextOneRow(leftText: "Biaya pengantaran:", rightText: decimalSeparator(state.deliveryFee)),
                    Divider(
                      thickness: 1,
                    ),
                    CustomTwoTextOneRow(leftText: "Total harga pemesanan:", leftTextFontWeight: FontWeight.bold, rightText: decimalSeparator(state.totalPrice + state.deliveryFee), rightTextFontWeight: FontWeight.bold),
                  ],
                );
              }
            )
          ),
        ],
      )
    );
  }
}