
import 'dart:developer';

import 'package:ebusiness_atk_mobile/views/components/preset_popUpAlert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/cart/cart_bloc.dart';
import 'convert_decimalSeparator.dart';
import 'custom_button_increaseDecrease.dart';

class CustomProductRow extends StatelessWidget {
  final String brand;
  final String cartID;
  final int cartItemPrice;
  final String category;
  final String filename;
  final String image;
  final bool isItemChecked;
  final String name;
  final int productPrice;
  final String productID;
  final int productQuantity;
  final int stockQuantity;
  final String userID;

  CustomProductRow({
    required this.brand,
    required this.cartID,
    required this.cartItemPrice,
    required this.category,
    required this.filename,
    required this.image,
    required this.isItemChecked,
    required this.name,
    required this.productPrice,
    required this.productID,
    this.productQuantity = 0,
    required this.stockQuantity,
    this.userID = ""
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isItemChecked? Colors.lightGreenAccent : null,
      child: InkWell(
        onTap: () => context.read<CartBloc>().add(ItemChecked(cartID, !isItemChecked, userID)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: SizedBox(
                  width: 24,
                  child: Checkbox(
                    value: isItemChecked, 
                    onChanged: (bool? value) {
                      context.read<CartBloc>().add(ItemChecked(cartID, value!, userID));
                    }
                  ),
                ),
              ),
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
                      child: (image.isEmpty)? Image(image: AssetImage('assets/images/home_Print_small.jpg'), fit: BoxFit.cover) : Image.network(
                        image,
                        fit: BoxFit.cover,
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          else return Padding(
                            padding: EdgeInsets.all(25),
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
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
                      width: 130,
                      child: Text((name.isEmpty)? filename : name, maxLines: 2, overflow: TextOverflow.ellipsis)
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      (category.isEmpty)? "Print" : category, 
                      style: TextStyle(
                        color: Colors.grey
                      )
                    )
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        (productID.isEmpty)? decimalSeparator(cartItemPrice) : "@ ${decimalSeparator(productPrice)}",
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => PresetPopUpAlert(
                              context: context, 
                              title: "Hapus item",
                              description: "Apakah anda ingin menghapus item ini?", 
                              firstActionButton: () async {
                                context.read<CartBloc>().add(DeleteItemTriggered(cartID, userID));
                                await PresetPopUpAlert(
                                  context: context, 
                                  description: "Item telah dihapus", 
                                  firstActionButtonText: "OK",
                                  firstActionButton: () => Navigator.pop(context, 'OK'),
                                  title: "Hapus item"
                                );
                                Navigator.pop(context, 'OK');
                              },
                              firstActionButtonText: "Ya",
                              secondActionButton: () => Navigator.pop(context, 'Cancel'),
                              secondActionButtonText: "Tidak"
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            splashColor: Colors.black.withOpacity(0.1),
                            child: Padding(
                            padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            )
                          ),
                        ),
      
                        //increase decrease
                        if (productQuantity != 0) BlocBuilder<CartBloc, CartInitial>(
                          builder: (context, state) {
                            return CustomButtonIncreaseDecrease(
                              decreaseOnTap: () => context.read<CartBloc>().add(QuantityDecreased(cartID, productID, productQuantity, userID)),
                              increaseOnTap: () => context.read<CartBloc>().add(QuantityIncreased(cartID, productID, productQuantity, userID)),
                              productQuantityCart: productQuantity,
                              isDisableBottomPadding: true
                            );
                          },
                        ),
      
                        // old increase decrease
                        // Material(
                        //   borderRadius: BorderRadius.all(Radius.circular(15)),
                        //   color: Colors.green,
                        //   elevation: 5,
                        //   child: InkWell(
                        //     onTap: (){},
                        //     borderRadius: BorderRadius.all(Radius.circular(15)),
                        //     splashColor: Colors.white.withOpacity(0.8),
                        //     child: Padding(
                        //       padding: EdgeInsets.all(5),
                        //       child: CircleAvatar(
                        //         backgroundColor: Colors.green,
                        //         radius: 10,
                        //         child: Text(
                        //           "-",
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.bold
                        //           )
                        //         ),
                        //       ),
                        //     )
                        //   ),
                        // ),
                        // CircleAvatar(
                        //   backgroundColor: Colors.transparent,
                        //   radius: 15,
                        //   child: Text(
                        //     "1",
                        //     style: TextStyle(
                        //       color: Colors.black
                        //     ) 
                        //   ),
                        // ),
                        // Material(
                        //   borderRadius: BorderRadius.all(Radius.circular(15)),
                        //   color: Colors.green,
                        //   elevation: 5,
                        //   child: InkWell(
                        //     onTap: (){},
                        //     borderRadius: BorderRadius.all(Radius.circular(15)),
                        //     splashColor: Colors.white.withOpacity(0.8),
                        //     child: Padding(
                        //       padding: EdgeInsets.all(5),
                        //       child: CircleAvatar(
                        //         backgroundColor: Colors.green,
                        //         radius: 10,
                        //         child: Text(
                        //           "+",
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.bold
                        //           )
                        //         ),
                        //       ),
                        //     )
                        //   ),
                        // ),
      
                      ],
                    )
                  ]
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}