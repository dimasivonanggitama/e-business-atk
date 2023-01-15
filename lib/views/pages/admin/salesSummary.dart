import 'package:ebusiness_atk_mobile/app.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_subHeading.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_dropdownButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/order/order_bloc.dart';

class SalesSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Control Panel", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
      body: BlocBuilder<OrderBloc, OrderInitial>(
        builder: (context, state) {
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomSubHeading(text: "Rekapan Penjualan"),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                              ),
                              child: Text("Layanan Print", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                              ),
                              child: Text("Beli ATK", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                      // child: PresetDropdownButton(
                      //   currentDropdownValue: currentDropdownValue, 
                      //   labelText: labelText, 
                      //   itemText: itemText, 
                      //   onChanged: null
                      // )
                      child: 
                          Row(
                          children: [
                            Expanded(
                              child: 
                              // ListView(
                              //   shrinkWrap: true,
                              //   scrollDirection: Axis.horizontal,
                              //   children: [
                                  Text("data")
                              //   ],
                              // )
                            )
                          ],
                          )
                        
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
