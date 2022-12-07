// Widget build(BuildContext context) {
    
//   // }
//   // Widget _itemTile({bool horizontalPadding = true}) {
//     double value;
//     horizontalPadding ? value = 15: value = 0;
//     return InkWell(
//       onTap: (){},
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(value, 6, value, 6),
//         child: Row(
//           children: [
//             // Checkbox(value: true),
//             Padding(
//               padding: EdgeInsets.only(right: 15),
//               child: Container(
//                 height: 60,
//                 width: 60,
//                 child: Material(
//                   borderRadius: BorderRadius.circular(15),
//                   elevation: 5,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image(
//                       image: AssetImage('assets/images/home_Beli ATK.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 ),
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Text("iTem 1")
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Text(
//                     "Deskripsi ...", 
//                     style: TextStyle(
//                       color: Colors.grey
//                     )
//                   )
//                 )
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "10.000",
//                       style: TextStyle(
//                         fontSize: 15
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Material(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: (){},
//                           borderRadius: BorderRadius.all(Radius.circular(15)),
//                           splashColor: Colors.black.withOpacity(0.1),
//                           child: Padding(
//                           padding: EdgeInsets.all(5),
//                             child: Icon(
//                               Icons.delete_outline,
//                               color: Colors.red,
//                             ),
//                           )
//                         ),
//                       ),
//                       Material(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         color: Colors.green,
//                         elevation: 5,
//                         child: InkWell(
//                           onTap: (){},
//                           borderRadius: BorderRadius.all(Radius.circular(15)),
//                           splashColor: Colors.white.withOpacity(0.8),
//                           child: Padding(
//                             padding: EdgeInsets.all(5),
//                             child: CircleAvatar(
//                               backgroundColor: Colors.green,
//                               radius: 10,
//                               child: Text(
//                                 "-",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold
//                                 )
//                               ),
//                             ),
//                           )
//                         ),
//                       ),
//                       CircleAvatar(
//                         backgroundColor: Colors.transparent,
//                         radius: 15,
//                         child: Text(
//                           "1",
//                           style: TextStyle(
//                             color: Colors.black
//                           ) 
//                         ),
//                       ),
//                       Material(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         color: Colors.green,
//                         elevation: 5,
//                         child: InkWell(
//                           onTap: (){},
//                           borderRadius: BorderRadius.all(Radius.circular(15)),
//                           splashColor: Colors.white.withOpacity(0.8),
//                           child: Padding(
//                             padding: EdgeInsets.all(5),
//                             child: CircleAvatar(
//                               backgroundColor: Colors.green,
//                               radius: 10,
//                               child: Text(
//                                 "+",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold
//                                 )
//                               ),
//                             ),
//                           )
//                         ),
//                       ),
//                     ],
//                   )
//                 ]
//               )
//             )
//           ]
//         ),
//       ),
//     );
//   }
// }