import 'package:ebusiness_atk_mobile/views/pages/order_detailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/order/order_bloc.dart';
import '../../components/convert_decimalSeparator.dart';
import 'order_detailed_admin.dart';

class OrderAdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Daftar Pemesanan"),
      ),
      body: BlocBuilder<OrderBloc, OrderInitial>(
        builder: (context, state) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                height: 5,
                // thickness: 5,
              );
            },
            itemCount: state.listofUserOrders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(15),
                child: Container(
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
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: (){
                        context.read<OrderBloc>().add(OrderDetailed(state.listofUserOrders[index].documentID));
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return OrderDetailedAdminPage();
                        }));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.move_to_inbox),
                                    Padding(padding: EdgeInsets.only(right: 5)),
                                    Text(DateFormat.yMMMd().format(state.listofUserOrders[index].dateCreated.toDate())),
                                  ],
                                ),
                                Text(
                                  state.listofUserOrders[index].status,
                                  style: TextStyle(
                                    backgroundColor: Colors.yellowAccent
                                    // color: Colors.grey
                                  )
                                )
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Row(
                              children: [
                                imagesItem(
                                  totalPrintItems:   state.listofUserOrders[index].totalPrintItems,
                                  totalProductItems: state.listofUserOrders[index].totalProductItems
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text("${(state.listofUserOrders[index].totalPrintItems + state.listofUserOrders[index].totalProductItems).toString()} item dipilih")
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Total harga"),
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          decimalSeparator(state.listofUserOrders[index].totalPrice + state.listofUserOrders[index].deliveryFee),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                )
                              ]
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Sentuh untuk melihat detil", 
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic
                              )
                            )
                          )
                        ],
                      )
                    ),
                  ),
                ),
              );
    
            }
          );
        },
      ),
    );
  }

  Widget imagesItem({required int totalPrintItems, required int totalProductItems}) {
    if (totalPrintItems != 0 && totalProductItems == 0) return printImageItem();
    else if (totalPrintItems == 0 && totalProductItems != 0) return productImageItem();
    else return Row(
      children: [
        printImageItem(),
        productImageItem()
      ],
    );
  }

  Widget printImageItem() {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Container(
        height: 60,
        width: 60,
        child: Material(
          borderRadius: BorderRadius.circular(15),
          elevation: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: AssetImage('assets/images/home_Print_small.jpg'), 
              fit: BoxFit.cover,
              height: 180,
              width: 180,
            ),
          ),
        )
      )
    );
  }

  Widget productImageItem() {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Container(
        height: 60,
        width: 60,
        child: Material(
          borderRadius: BorderRadius.circular(15),
          elevation: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: AssetImage('assets/images/home_Beli ATK.jpg'), 
              fit: BoxFit.cover,
              height: 180,
              width: 180,
            )
          )
        )
      )
    );
  }
}