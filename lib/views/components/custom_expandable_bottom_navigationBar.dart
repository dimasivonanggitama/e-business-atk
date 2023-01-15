// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../bloc/cart/cart_bloc.dart';

// class CustomExpandableButtonNavigationBar extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _navigationBar(),
        
//         Row(
//           children: [
//           Expanded(
//             child: SizeTransition(
//               axis: Axis.vertical,
//               sizeFactor: _animation,
//                 child: Container(
//                   height: _currentScreenHeight - _belowPanelHeight,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       stops: [
//                         0.01,
//                         0.2
//                       ],
//                       colors: [
//                         Colors.lightBlueAccent,
//                         Colors.white
//                       ],
//                     )
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
//                     child: Column(
//                       children: [

//                         Divider(
//                           color: Colors.black,
//                           thickness: 1,
//                         ),
                        
//                         Expanded(
//                           child: ListView(
//                             children: [
                  
//                               // picked item
//                               _oneTextRow(text: "Item yang dipilih"),
//                               Container(
//                                 child: Padding(
//                                   padding: EdgeInsets.only(bottom: 15),
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.only(right: 15),
//                                         child: Container(
//                                           height: 60,
//                                           width: 60,
//                                           child: Material(
//                                             borderRadius: BorderRadius.circular(15),
//                                             elevation: 5,
//                                             child: ClipRRect(
//                                               borderRadius: BorderRadius.circular(15),
//                                               child: Image(
//                                                 image: AssetImage('assets/images/home_Beli ATK.jpg'),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             )
//                                           ),
//                                         ),
//                                       ),
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.all(5),
//                                             child: Text("iTem 1")
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.all(5),
//                                             child: Text(
//                                               "Deskripsi ...", 
//                                               style: TextStyle(
//                                                 color: Colors.grey
//                                               )
//                                             )
//                                           ),
//                                         ],
//                                       ),
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           crossAxisAlignment: CrossAxisAlignment.end,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.all(3),
//                                               child: Text(
//                                                 "1 barang",
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.all(5),
//                                               child: Text(
//                                                 "10.000",
//                                                 style: TextStyle(
//                                                   fontSize: 17
//                                                 ),
//                                               ),
//                                             ),
//                                           ]
//                                         )
//                                       )
//                                     ]
//                                   ),
//                                 ),
//                               ),
//                               Divider(
//                                 color: Colors.black,
//                                 thickness: 1,
//                               ),
//                               _oneTextRow(text: "Ringkasan pembayaran"),
//                               _twoTextRow("Harga", "[Harga]"),
                              
//                               Divider(
//                                 color: Colors.black,
//                                 thickness: 1,
//                               ),

//                               // Pengantaran
//                               Stack(
//                                 children: [ 
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 35),
//                                     child: SizeTransition(
//                                       axis: Axis.vertical,
//                                       sizeFactor: _deliveryOptionAnimation,
//                                       child: _deliveryOption()
//                                     ),
//                                   ),

//                                   Padding(
//                                     padding: EdgeInsets.only(bottom: 15),
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Expanded(
//                                           child: Container(
//                                             child: Text(
//                                               "Pengantaran",
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             children: [
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   _isDropDownOpened = !_isDropDownOpened;
//                                                   setState(() {
//                                                     if (_isDropDownOpened) {
//                                                       _dropDownController.forward();
//                                                       for (int i = 0; i < _dropDownItemValue.length; i++) {
//                                                         _dropDownItemColor[i] = Colors.transparent;
//                                                         if (_currentDropDownValue == _dropDownItemValue[i]) {
//                                                           _dropDownItemColor[i] = Colors.grey.shade300;
//                                                         }
//                                                         print(i);
//                                                         print(_currentDropDownValue);
//                                                         print(_dropDownItemValue[i]);
//                                                       }
//                                                     } else {
//                                                       _dropDownController.reverse();
//                                                     }
//                                                     print("dropDownController");
//                                                     print(_dropDownController.status);
//                                                   });
//                                                 },
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.end,
//                                                   children: [
//                                                     Material(
//                                                       borderRadius: BorderRadius.circular(15),
//                                                       elevation: 5,
//                                                       child: Container(
//                                                         width: 130,
//                                                         padding: EdgeInsets.all(5),
//                                                         decoration: BoxDecoration(
//                                                           border: Border.all(),
//                                                           borderRadius: BorderRadius.circular(15),
//                                                           color: Colors.white,
//                                                         ),
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                               children: [
//                                                                 Text(_currentDropDownValue),
//                                                                 Icon(Icons.arrow_drop_down)
//                                                               ],
//                                                             ),
                                                            
//                                                             Row(
//                                                               children: [
//                                                                 Expanded(
//                                                                   child: SizeTransition(
//                                                                     axis: Axis.vertical,
//                                                                     sizeFactor: _dropDownAnimation,
//                                                                     child: Container(
//                                                                       child: Column(
//                                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                                         children: [
//                                                                           Row(
//                                                                             children: [
//                                                                               Expanded(
//                                                                                 child: Padding(
//                                                                                   padding: EdgeInsets.only(top: 5, bottom: 5),
//                                                                                   child: Material(
//                                                                                     color: Colors.transparent,
//                                                                                     borderRadius: BorderRadius.circular(15),
//                                                                                     child: InkWell(
//                                                                                       splashColor: Colors.black.withOpacity(0.3),
//                                                                                       borderRadius: BorderRadius.circular(15),
//                                                                                       onTap: () {
//                                                                                         setState(() {
//                                                                                           _currentDropDownValue = _dropDownItemValue[0];
//                                                                                           _dropDownController.reverse();
//                                                                                           _isDropDownOpened = false;
//                                                                                           if (_isDeliveryOptionOpened == true) {
//                                                                                             _isDeliveryOptionOpened = false;
//                                                                                             _deliveryOptionController.reverse();
//                                                                                           }
//                                                                                         });
//                                                                                       },
//                                                                                       child: Container(
//                                                                                         padding: EdgeInsets.all(10),
//                                                                                         decoration: BoxDecoration(
//                                                                                           border: Border.all(),
//                                                                                           borderRadius: BorderRadius.circular(15),
//                                                                                           color: _dropDownItemColor[0]
//                                                                                         ),
//                                                                                         child: Text(_dropDownItemValue[0]),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                           Row(
//                                                                             children: [
//                                                                               Expanded(
//                                                                                 child: Padding(
//                                                                                   padding: EdgeInsets.only(top: 5, bottom: 5),
//                                                                                   child: Material(
//                                                                                     color: Colors.transparent,
//                                                                                     borderRadius: BorderRadius.circular(15),
//                                                                                     child: InkWell(
//                                                                                       splashColor: Colors.black.withOpacity(0.3),
//                                                                                       borderRadius: BorderRadius.circular(15),
//                                                                                       onTap: () {
//                                                                                         setState(() {
//                                                                                           _currentDropDownValue = _dropDownItemValue[1];
//                                                                                           _dropDownController.reverse();
//                                                                                           _isDropDownOpened = false;
//                                                                                           _deliveryOptionController.forward();
//                                                                                           _isDeliveryOptionOpened = true;
//                                                                                         });
//                                                                                       },
//                                                                                       child: Container(
//                                                                                         padding: EdgeInsets.all(10),
//                                                                                         decoration: BoxDecoration(
//                                                                                           border: Border.all(),
//                                                                                           borderRadius: BorderRadius.circular(15),
//                                                                                           color: _dropDownItemColor[1]
//                                                                                         ),
//                                                                                         child: Text(_dropDownItemValue[1]),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                           Row(
//                                                                             children: [
//                                                                               Expanded(
//                                                                                 child: Padding(
//                                                                                   padding: EdgeInsets.only(top: 5),
//                                                                                   child: Material(
//                                                                                     color: Colors.transparent,
//                                                                                     borderRadius: BorderRadius.circular(15),
//                                                                                     child: InkWell(
//                                                                                       splashColor: Colors.black.withOpacity(0.3),
//                                                                                       borderRadius: BorderRadius.circular(15),
//                                                                                       onTap: () {
//                                                                                         setState(() {
//                                                                                           _currentDropDownValue = _dropDownItemValue[2];
//                                                                                           _dropDownController.reverse();
//                                                                                           _isDropDownOpened = false;
//                                                                                           if (_isDeliveryOptionOpened == true) {
//                                                                                             _isDeliveryOptionOpened = false;
//                                                                                             _deliveryOptionController.reverse();
//                                                                                           }
//                                                                                         });
//                                                                                       },
//                                                                                       child: Container(
//                                                                                         padding: EdgeInsets.all(10),
//                                                                                         decoration: BoxDecoration(
//                                                                                           border: Border.all(),
//                                                                                           borderRadius: BorderRadius.circular(15),
//                                                                                           color: _dropDownItemColor[2]
//                                                                                         ),
//                                                                                         child: Text(_dropDownItemValue[2]),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ]
//                               ),

//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.all(15),
//                                           child: Material(
//                                             borderRadius: BorderRadius.all(Radius.circular(15)),
//                                             elevation: 5,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 // Navigator.pop(
//                                                 //   context, true
//                                                 // );
//                                               },
//                                               splashColor: Colors.black.withOpacity(0.1),
//                                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(15),
//                                                 child: Text("Lanjutkan Belanja")
//                                               )
//                                             )
//                                           ),
//                                         ),
//                                         //Spacer(),
//                                         Padding(
//                                           padding: EdgeInsets.all(15),
//                                           child: Material(
//                                             borderRadius: BorderRadius.all(Radius.circular(15)),
//                                             color: Colors.green[300],
//                                             elevation: 5,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 // Navigator.push(
//                                                 //   context, MaterialPageRoute(
//                                                 //     builder: (context) {
//                                                 //       return keranjangPage();
//                                                 //     }
//                                                 //   )
//                                                 // );
//                                               },
//                                               borderRadius: BorderRadius.all(Radius.circular(5)),
//                                               splashColor: Colors.white.withOpacity(0.3),
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(15),
//                                                 child: Text("Pilih Pembayaran")
//                                               )
//                                             )
//                                           )
//                                         )
//                                       ]
//                                     )
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ),
//               ) //end of SizeTransition
//             ),
//           ],
//         ),

//       ],
//     );
//   }

//   Widget _navigationBar() {
//     return BlocBuilder<CartBloc, CartInitial>(
//       builder: (context, state) {
//         return Row(
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   // setState(
//                   //   () {
//                   context.read<CartBloc>().add(NavigationBarTriggered());
//                   click = !click;
//                   if (click) {
//                     _controller.forward();
//                   } else {
//                     _controller.reverse(); 
//                     _dropDownController.reverse();
//                     _isDropDownOpened = false;
//                   }
//                   //   }
//                   // );
//                 },
//                 child: Container(
//                   height: state.navigationBarHeight,
//                   decoration: BoxDecoration(
//                     color: Colors.lightBlueAccent,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(15),
//                       topRight: Radius.circular(15),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 7,
//                         blurRadius: 5,
//                         offset: Offset(0, 3)
//                       )
//                     ]
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(15),
//                             topRight: Radius.circular(15)
//                           ),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.lightBlueAccent,
//                               Colors.lightBlueAccent.shade700
//                             ],
//                           )
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Column(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(5, 5, 5, 1),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[300],
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(25),
//                                         topRight: Radius.circular(25)
//                                       )
//                                     ),
//                                     height: 2.5,
//                                     width: 50
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(5, 1, 5, 5),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[300],
//                                       borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(25),
//                                         bottomRight: Radius.circular(25)
//                                       )
//                                     ),
//                                     height: 2.5,
//                                     width: 50
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ]
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           child: Padding(
//                             padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         // "1 item dipilih",
//                                         "${state.totalItemsSelected} item dipilih",
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         "Total:",
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         // "10.000",
//                                         state.totalPrice,
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ) 
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }