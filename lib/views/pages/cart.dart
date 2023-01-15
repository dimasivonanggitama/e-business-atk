
import 'dart:developer';

import 'package:ebusiness_atk_mobile/views/components/preset_popUpAlert.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_popUpWidgets.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_condition/auth_condition_bloc.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../components/convert_decimalSeparator.dart';
import '../components/custom_button.dart';
import '../components/custom_product_row.dart';
import '../components/custom_product_view.dart';
import '../components/preset_textField_controller.dart';
import 'home.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin{
  
  // Main Widget
  @override
  Widget build(BuildContext context) {
    
    double _currentScreenHeight = MediaQuery.of(context).size.height - 90; //-90 to avoid overflowed on top
    // double _navigationBarHeight = 77;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: BackButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                }
              ), 
            ModalRoute.withName("/Home")
            );
          }
        ),
        title: Text(
          "Keranjang", 
          style: TextStyle(
            shadows: [
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black
              )
            ]
          )
        )
      ),
      body: BlocBuilder<AuthConditionBloc, AuthConditionState>(
        builder: (context, authState) {
          if (authState is AuthSuccess) {
            return BlocBuilder<CartBloc, CartInitial>(
              builder: (context, cartState) {
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 5,
                              thickness: 5,
                            );
                          },
                          itemCount: cartState.listofUserCart.length,
                          itemBuilder: (context, index) {
                            return CustomProductRow(
                              brand:           cartState.listofUserCart[index].productBrand,
                              cartID:          cartState.listofUserCart[index].documentID,
                              cartItemPrice:   cartState.listofUserCart[index].cartItemPrice,
                              category:        cartState.listofUserCart[index].productCategory,
                              filename:        cartState.listofUserCart[index].filename,
                              image:           cartState.listofUserCart[index].productImage,
                              isItemChecked:   cartState.listofUserCart[index].isItemChecked,
                              name:            cartState.listofUserCart[index].productName,
                              productID:       cartState.listofUserCart[index].productID,
                              productPrice:    cartState.listofUserCart[index].productPrice,
                              productQuantity: cartState.listofUserCart[index].productQuantity,
                              stockQuantity:   cartState.listofUserCart[index].productStockQuantity,
                              userID:          cartState.listofUserCart[index].userID
                            );
                          }
                        )
                      )
                    ),
                    
                    _navigationBar(height: 77, totalItemsSelected: cartState.listofSelectedItems.length, totalPrice: cartState.grandTotalPrice, userID: authState.uid),
                    _expandedNavigationBody(currentScreenHeight: _currentScreenHeight, userID: authState.uid),
                  ]
                );
              },
            );
          }
          return Container();
        },
      )
    );
  }

  // Custom Variables
  bool click = false;
  bool _isDeliveryOptionOpened = false;
  bool _isDropDownOpened = false;
  String _currentDropDownValue = "Belum dipilih";
  var _dropDownItemValue = ["Belum dipilih", "Ya", "Tidak"];
  var _dropDownItemColor = [Colors.transparent, Colors.transparent, Colors.transparent];
  
  late AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: 800),
    vsync: this
  ); //..repeat();
  late Animation<double> _animation = CurvedAnimation(
    parent: _controller, 
    curve: Curves.fastOutSlowIn
  );
  
  late AnimationController _dropDownController = AnimationController(
    duration: Duration(milliseconds: 800),
    vsync: this
  ); //..repeat();
  late Animation<double> _dropDownAnimation = CurvedAnimation(
    parent: _dropDownController, 
    curve: Curves.fastOutSlowIn
  );
  
  late AnimationController _deliveryOptionController = AnimationController(
    duration: Duration(milliseconds: 800),
    vsync: this
  ); //..repeat();
  late Animation<double> _deliveryOptionAnimation = CurvedAnimation(
    parent: _deliveryOptionController, 
    curve: Curves.fastOutSlowIn
  );
  
  @override
  void dispose() {
    _controller.dispose();
    _dropDownController.dispose();
    _deliveryOptionController.dispose();
    super.dispose();
  }

  // Custom Widgets
  Widget _deliveryDropdownMenu(){
    return BlocBuilder<AuthConditionBloc, AuthConditionState>(
      builder: (context, authState) {
        return BlocBuilder<CartBloc, CartInitial>(
          builder: (context, cartState) {
            PresetTextFieldController deliveryAddressController = PresetTextFieldController(value: cartState.deliveryAddress);
            PresetTextFieldController phoneNumberController = PresetTextFieldController(value: cartState.phoneNumber);
            
            return Column(
              children: [
                _twoColumnOneRow(
                  flexLeftColumn: 1,
                  flexRightColumn: 2,
                  leftText: "Alamat pengantaran",
                  listofWidgets: [
                    Text(
                      (cartState.deliveryAddress.isEmpty)? "Belum diisi" : cartState.deliveryAddress, 
                      textAlign: TextAlign.justify
                    ),
                    TextButton(
                      onPressed: () async => await PresetPopUpWidgets(
                        context: context,
                        title: "Ubah alamat pengantaran",
                        listofWidgetsHeightApprox: 120,
                        listofWidgets: [
                          PresetTextField(
                            controller: deliveryAddressController.getController,
                            keyboardType: TextInputType.multiline,
                            labelText: "Alamat pengantaran",
                            maxLines: null,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: CustomButton(
                                  text: "Kembali",
                                  onTap: () => Navigator.pop(context, 'Cancel'),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: CustomButton(
                                  color: Colors.lightGreenAccent,
                                  isLeftPaddingDisabled: true,
                                  text: "Simpan",
                                  onTap: () {
                                    context.read<CartBloc>().add(DeliveryAddressSubmitted(deliveryAddressController.getController.text, (authState as AuthSuccess).uid));
                                    Navigator.pop(context, 'OK');
                                  },
                                ),
                              )
                            ],
                          )
                        ]
                      ),
                      child: Text("Ubah")
                    )
                  ]
                ),
                _twoColumnOneRow(
                  leftText: "Nomor telepon penerima",
                  listofWidgets: [
                    Text(
                      (cartState.phoneNumber.isEmpty)? "Belum diisi" : cartState.phoneNumber, 
                      textAlign: TextAlign.justify
                    ),
                    TextButton(
                      onPressed: () async => await PresetPopUpWidgets(
                        context: context,
                        title: "Ubah nomor telepon penerima",
                        listofWidgetsHeightApprox: 120,
                        listofWidgets: [
                          PresetTextField(
                            controller: phoneNumberController.getController,
                            keyboardType: TextInputType.multiline,
                            labelText: "Nomor telepon penerima",
                            maxLines: null,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: CustomButton(
                                  text: "Kembali",
                                  onTap: () => Navigator.pop(context, 'Cancel'),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: CustomButton(
                                  color: Colors.lightGreenAccent,
                                  isLeftPaddingDisabled: true,
                                  text: "Simpan",
                                  onTap: () {
                                    context.read<CartBloc>().add(PhoneNumberSubmitted(phoneNumberController.getController.text, (authState as AuthSuccess).uid));
                                    Navigator.pop(context, 'OK');
                                  },
                                ),
                              )
                            ],
                          )
                        ]
                      ),
                      child: Text("Ubah")
                    )
                  ]
                ),
              ]
            );
          }
        );
      },
    );
  }

  Widget _deliveryOption() {
    return Column(
      children: [

        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            _subHeading("Pengantaran"),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _isDropDownOpened = !_isDropDownOpened;
                      setState(() {
                        if (_isDropDownOpened) {
                          _dropDownController.forward();
                          for (int i = 0; i < _dropDownItemValue.length; i++) {
                            _dropDownItemColor[i] = Colors.transparent;
                            if (_currentDropDownValue == _dropDownItemValue[i]) {
                              _dropDownItemColor[i] = Colors.grey.shade300;
                            }
                            print(i);
                            print(_currentDropDownValue);
                            print(_dropDownItemValue[i]);
                          }
                        } else {
                          _dropDownController.reverse();
                        }
                        print("dropDownController");
                        print(_dropDownController.status);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 5,
                          child: Container(
                            width: 130,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_currentDropDownValue),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                                
                                BlocBuilder<AuthConditionBloc, AuthConditionState>(
                                  builder: (context, authState) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: SizeTransition(
                                            axis: Axis.vertical,
                                            sizeFactor: _dropDownAnimation,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 5, bottom: 5),
                                                          child: Material(
                                                            color: Colors.transparent,
                                                            borderRadius: BorderRadius.circular(15),
                                                            child: InkWell(
                                                              splashColor: Colors.black.withOpacity(0.3),
                                                              borderRadius: BorderRadius.circular(15),
                                                              onTap: () {
                                                                context.read<CartBloc>().add(DeliveryOptionSelected("Belum dipilih", false, (authState as AuthSuccess).uid));
                                                                setState(() {
                                                                  _currentDropDownValue = _dropDownItemValue[0];
                                                                  _dropDownController.reverse();
                                                                  _isDropDownOpened = false;
                                                                  if (_isDeliveryOptionOpened == true) {
                                                                    _isDeliveryOptionOpened = false;
                                                                    _deliveryOptionController.reverse();
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                  color: _dropDownItemColor[0]
                                                                ),
                                                                child: Text(_dropDownItemValue[0]),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row( // dropdown item "ya"
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 5, bottom: 5),
                                                          child: Material(
                                                            color: Colors.transparent,
                                                            borderRadius: BorderRadius.circular(15),
                                                            child: InkWell(
                                                              splashColor: Colors.black.withOpacity(0.3),
                                                              borderRadius: BorderRadius.circular(15),
                                                              onTap: () {
                                                                context.read<CartBloc>().add(DeliveryOptionSelected("Ya", true, (authState as AuthSuccess).uid));
                                                                setState(() {
                                                                  _currentDropDownValue = _dropDownItemValue[1];
                                                                  _dropDownController.reverse();
                                                                  _isDropDownOpened = false;
                                                                  _deliveryOptionController.forward();
                                                                  _isDeliveryOptionOpened = true;
                                                                });
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                  color: _dropDownItemColor[1]
                                                                ),
                                                                child: Text(_dropDownItemValue[1]),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 5),
                                                          child: Material(
                                                            color: Colors.transparent,
                                                            borderRadius: BorderRadius.circular(15),
                                                            child: InkWell(
                                                              splashColor: Colors.black.withOpacity(0.3),
                                                              borderRadius: BorderRadius.circular(15),
                                                              onTap: () {
                                                                context.read<CartBloc>().add(DeliveryOptionSelected("Tidak", false, (authState as AuthSuccess).uid));
                                                                setState(() {
                                                                  _currentDropDownValue = _dropDownItemValue[2];
                                                                  _dropDownController.reverse();
                                                                  _isDropDownOpened = false;
                                                                  if (_isDeliveryOptionOpened == true) {
                                                                    _isDeliveryOptionOpened = false;
                                                                    _deliveryOptionController.reverse();
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                  color: _dropDownItemColor[2]
                                                                ),
                                                                child: Text(_dropDownItemValue[2]),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizeTransition(
          axis: Axis.vertical,
          sizeFactor: _deliveryOptionAnimation,
          child: _deliveryDropdownMenu()
        )
      ]
    );
}

Widget _expandedNavigationBody({
    required double currentScreenHeight,
    required String userID
  }) {
    return Row(
    children: [
      Expanded(
        child: SizeTransition(
          axis: Axis.vertical,
          sizeFactor: _animation,
            child: Container(
              height: currentScreenHeight - 77,//_belowPanelHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.01,
                    0.2
                  ],
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.white
                  ],
                )
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                  children: [

                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    
                    Expanded(
                      child: BlocBuilder<CartBloc, CartInitial>(
                        builder: (context, cartState) {
                          return ListView(
                            children: [
                  
                              // selected item
                              _oneTextRow(text: "Item yang dipilih"),
                              Container(
                                child: Padding(
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
                                    itemCount: cartState.listofSelectedItems.length,
                                    itemBuilder: (context, index) {
                                      return _listofSelectedItems(
                                        cartItemPrice:   cartState.listofSelectedItems[index].cartItemPrice!,
                                        colorfulPage:    cartState.listofSelectedItems[index].colorfulPage!,
                                        filename:        cartState.listofSelectedItems[index].filename!,
                                        greyscalePage:   cartState.listofSelectedItems[index].greyscalePage!,
                                        productCategory: cartState.listofSelectedItems[index].productCategory!,
                                        productImage:    cartState.listofSelectedItems[index].productImage!,
                                        productName:     cartState.listofSelectedItems[index].productName!,
                                        productPrice:    cartState.listofSelectedItems[index].productPrice,
                                        productQuantity: cartState.listofSelectedItems[index].productQuantity
                                        // productBrand:     cartState.listofProducts[index].merekProduk!,
                                      );
                                    },
                                  )
                                ),
                              ),
                              _paymentSummary(),
                              _deliveryOption(),
    
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Material(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            elevation: 5,
                                            child: InkWell(
                                              onTap: () {
                                                // Navigator.pop(
                                                //   context, true
                                                // );
                                              },
                                              splashColor: Colors.black.withOpacity(0.1),
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Text("Lanjutkan Belanja")
                                              )
                                            )
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.all(15),
                                        //   child: Material(
                                        //     borderRadius: BorderRadius.all(Radius.circular(15)),
                                        //     color: Colors.green[300],
                                        //     elevation: 5,
                                        //     child: InkWell(
                                        //       onTap: () {
                                        //         // Navigator.push(
                                        //         //   context, MaterialPageRoute(
                                        //         //     builder: (context) {
                                        //         //       return keranjangPage();
                                        //         //     }
                                        //         //   )
                                        //         // );
                                        //         context.read<CartBloc>().add(CartSubmitted(context, userID));
                                        //       },
                                        //       borderRadius: BorderRadius.all(Radius.circular(5)),
                                        //       splashColor: Colors.white.withOpacity(0.3),
                                        //       child: Padding(
                                        //         padding: EdgeInsets.all(15),
                                        //         child: Text("Pilih Pembayaran")
                                        //       )
                                        //     )
                                        //   )
                                        // )
                                        CustomButton(
                                          color: Colors.lightGreenAccent.shade200,
                                          isButtonDisabled: cartState.isSubmitButtonDisabled,
                                          onTap: () => context.read<CartBloc>().add(CartSubmitted(context, userID)),
                                          text: "Pilih Pembayaran"
                                        )
                                      ]
                                    )
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ),
          ) //end of SizeTransition
        ),
      ],
    );
  }

  Widget _listofSelectedItems({
    required int cartItemPrice,
    required int colorfulPage,
    required String filename,
    required int greyscalePage,
    required String productCategory,
    required String productImage,
    required String productName,
    required int productPrice,
    required int productQuantity
  }) {
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
                child: (productImage.isEmpty)? Image(image: AssetImage('assets/images/home_Print_small.jpg'), fit: BoxFit.cover) : Image.network(
                  productImage,
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
                child: Text((productName.isEmpty)? filename : productName, maxLines: 2, overflow: TextOverflow.ellipsis)
              )
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                (productCategory.isEmpty)? "Print" : productCategory, 
                style: TextStyle(
                  color: Colors.grey
                )
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
                  (productQuantity == 0)? "1 file" : "$productQuantity barang",
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  (productPrice == 0)? decimalSeparator(cartItemPrice) : decimalSeparator(productPrice * productQuantity),
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

  // Widget _itemTile({bool horizontalPadding = true}) {
  //   double value;
  //   horizontalPadding ? value = 15: value = 0;
  //   return InkWell(
  //     onTap: (){},
  //     child: Padding(
  //       padding: EdgeInsets.fromLTRB(value, 6, value, 6),
  //       child: Row(
  //         children: [
  //           // Checkbox(value: true),
  //           Padding(
  //             padding: EdgeInsets.only(right: 15),
  //             child: Container(
  //               height: 60,
  //               width: 60,
  //               child: Material(
  //                 borderRadius: BorderRadius.circular(15),
  //                 elevation: 5,
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(15),
  //                   child: Image(
  //                     image: AssetImage('assets/images/home_Beli ATK.jpg'),
  //                     fit: BoxFit.cover,
  //                   ),
  //                 )
  //               ),
  //             ),
  //           ),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.all(5),
  //                 child: Text("iTem 1")
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.all(5),
  //                 child: Text(
  //                   "Deskripsi ...", 
  //                   style: TextStyle(
  //                     color: Colors.grey
  //                   )
  //                 )
  //               )
  //             ],
  //           ),
  //           Expanded(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.all(8),
  //                   child: Text(
  //                     "10.000",
  //                     style: TextStyle(
  //                       fontSize: 15
  //                     ),
  //                   ),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     Material(
  //                       borderRadius: BorderRadius.all(Radius.circular(15)),
  //                       color: Colors.transparent,
  //                       child: InkWell(
  //                         onTap: (){},
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         splashColor: Colors.black.withOpacity(0.1),
  //                         child: Padding(
  //                         padding: EdgeInsets.all(5),
  //                           child: Icon(
  //                             Icons.delete_outline,
  //                             color: Colors.red,
  //                           ),
  //                         )
  //                       ),
  //                     ),
  //                     Material(
  //                       borderRadius: BorderRadius.all(Radius.circular(15)),
  //                       color: Colors.green,
  //                       elevation: 5,
  //                       child: InkWell(
  //                         onTap: (){},
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         splashColor: Colors.white.withOpacity(0.8),
  //                         child: Padding(
  //                           padding: EdgeInsets.all(5),
  //                           child: CircleAvatar(
  //                             backgroundColor: Colors.green,
  //                             radius: 10,
  //                             child: Text(
  //                               "-",
  //                               style: TextStyle(
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.bold
  //                               )
  //                             ),
  //                           ),
  //                         )
  //                       ),
  //                     ),
  //                     CircleAvatar(
  //                       backgroundColor: Colors.transparent,
  //                       radius: 15,
  //                       child: Text(
  //                         "1",
  //                         style: TextStyle(
  //                           color: Colors.black
  //                         ) 
  //                       ),
  //                     ),
  //                     Material(
  //                       borderRadius: BorderRadius.all(Radius.circular(15)),
  //                       color: Colors.green,
  //                       elevation: 5,
  //                       child: InkWell(
  //                         onTap: (){},
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         splashColor: Colors.white.withOpacity(0.8),
  //                         child: Padding(
  //                           padding: EdgeInsets.all(5),
  //                           child: CircleAvatar(
  //                             backgroundColor: Colors.green,
  //                             radius: 10,
  //                             child: Text(
  //                               "+",
  //                               style: TextStyle(
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.bold
  //                               )
  //                             ),
  //                           ),
  //                         )
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ]
  //             )
  //           )
  //         ]
  //       ),
  //     ),
  //   );
  // }

  Widget _navigationBar({required double height, required int totalItemsSelected, required int totalPrice, required String userID}) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(
                () {
                  context.read<CartBloc>().add(NavigationBarTriggered(userID));
                  click = !click;
                  if (click) {
                    _controller.forward();
                  } else {
                    _controller.reverse(); 
                    _dropDownController.reverse();
                    _isDropDownOpened = false;
                  }
                }
              );
            },
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 5,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent.shade700
                        ],
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)
                                  )
                                ),
                                height: 2.5,
                                width: 50
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 1, 5, 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)
                                  )
                                ),
                                height: 2.5,
                                width: 50
                              ),
                            )
                          ],
                        ),
                      ]
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // "1 item dipilih",
                                    "$totalItemsSelected item dipilih",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    // "10.000",
                                    decimalSeparator(totalPrice),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) 
          ),
        ),
      ],
    );
  }
  
  Widget _oneTextRow({required String text, double textSize = 16, bool isTextBold = true}) {
    FontWeight textBold = FontWeight.normal;
    if (isTextBold == true) {
      textBold = FontWeight.bold;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: textBold
            ),
          )
        ],
      ),
    );
  }

  Widget _paymentSummary() {
    return BlocBuilder<CartBloc, CartInitial>(
      builder: (context, cartState) {
        return Column(
          children: [
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            _oneTextRow(text: "Ringkasan pembayaran"),
            // _subHeading("Ringkasan pembayaran"),
            _twoTextRow(leftText: "Total harga item", rightText: decimalSeparator(cartState.totalPriceofSelectedItems)),
            if (_currentDropDownValue == _dropDownItemValue[1]) _twoTextRow(leftText: "Biaya pengantaran", rightText: cartState.deliveryFeeDecimal)
          ]
        );
      },
    );
  }

  Widget _subHeading(String text) {
    // Note: this widget must be placed in Row
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Text(
            text, 
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
          Padding(padding: EdgeInsets.only(bottom: 15))
        ],
      ),
    );
  }

  Widget _twoColumnOneRow({
    int flexLeftColumn = 1,
    int flexRightColumn = 1,
    String leftText = "",
    // String rightText = ""
    List<Widget> listofWidgets = const []
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flexLeftColumn,
            child: Text(leftText),
          ),
          Expanded(
            flex: flexRightColumn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: listofWidgets
            ),
          ),
        ],
      ),
    );
  }

  Widget _twoTextRow({
    int flexLeftText = 1,
    int flexRightText = 1,
    String leftText = "",
    String rightText = ""
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flexLeftText,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(leftText)
              ],
            ),
          ),
          Expanded(
            flex: flexRightText,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(rightText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



