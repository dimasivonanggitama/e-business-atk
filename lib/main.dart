// import 'package:e_business_atk/views/pages/home.dart';

import 'package:ebusiness_atk_mobile/bloc/form/auth_form/auth_form_bloc.dart';
import 'package:ebusiness_atk_mobile/bloc/order/order_bloc.dart';
import 'package:ebusiness_atk_mobile/repository/cart_repository.dart';
import 'package:ebusiness_atk_mobile/repository/order_repository.dart';
import 'package:ebusiness_atk_mobile/repository/printPrice_repository.dart';
import 'package:ebusiness_atk_mobile/repository/product_repository.dart';
import 'package:ebusiness_atk_mobile/repository/user_repository.dart';

import 'bloc/auth_condition/auth_condition_bloc.dart';
import 'bloc/cart/cart_bloc.dart';
import 'bloc/catalogue/catalogue_bloc.dart';
import 'bloc/dbms_firestore/dbms_firestore_bloc.dart';
import 'bloc/form/product_form/product_form_bloc.dart';
import 'bloc/print_service/print_service_bloc.dart';
import 'features/authentication/authentication_repository_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/database/bloc/database_bloc.dart';
// import 'features/database/database_repository_impl.dart';
// import 'features/form-validation/bloc/form_bloc.dart';

import 'repository/dbms_firebase_repository.dart';
import 'views/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Main());

  // BlocOverrides.runZoned(
  //   () => runApp(
  //     MultiBlocProvider(
  //       providers: [
  //         BlocProvider(
  //           create: (context) => AuthenticationBloc(AuthenticationRepositoryImpl())..add(AuthenticationStarted())
  //         ),
  //         BlocProvider(
  //           create: (context) => FormBloc(
  //             AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()
  //           )
  //         ),
  //         BlocProvider(
  //           create: (context) => DatabaseBloc(DatabaseRepositoryImpl())
  //         )
  //       ], 
  //       // child: MyApp()
  //       child: const App()
  //     )
  //   ),
  //   blocObserver: AppBlocObserver()
  // );
  
}

class Main extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthConditionBloc>(
          create: (context) => AuthConditionBloc(UserRepository())
        ),
        BlocProvider<AuthFormBloc>(
          create: (context) => AuthFormBloc(UserRepository())
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(CartRepository(), OrderRepository(), ProductRepository())
        ),
        BlocProvider<CatalogueBloc>(
          create: (context) => CatalogueBloc(ProductRepository())
        ),
        BlocProvider<DBMSFirestoreBloc>(
          create: (context) => DBMSFirestoreBloc(DBMSFirestoreRepository())
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(CartRepository(), OrderRepository(), ProductRepository(), UserRepository())
        ),
        BlocProvider<PrintServiceBloc>(
          create: (context) => PrintServiceBloc(PrintPriceRepository())
        ),
        BlocProvider<ProductFormBloc>(
          create: (context) => ProductFormBloc(ProductRepository())
        ),
      ],
      child: MaterialApp(
        home: HomePage()
      ),
    );
  }
}

// if screen > 600

// class MyApp extends StatelessWidget {
//   @override
  
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Aplikasi Hello World")
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             color: Colors.orange,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
//             children: [ 
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center, children: [
//                   Card(
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           'assets/images/home_Print.jpg',
//                           //height: 10,
//                           //width: 10
//                         ),
//                         Text("this is a card")
//                       ]
//                     )
//                   ),
//                   Text("Column 1")
//                 ]
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center, children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 10, color: Colors.red),
//                     )
//                   ),
//                   Text("Column 2")
//                 ]
//               ),
//             ]
//           ),
//         ),
//       )
//     );
//   }
// }
