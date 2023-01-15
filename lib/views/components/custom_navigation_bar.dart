// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../bloc/cart/cart_bloc.dart';

// class CustomNavigationBar extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
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