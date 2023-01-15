import 'dart:convert';
import 'dart:developer';
// import 'dart:math';

import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_popUpAlert.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_textField.dart';
import 'package:flutter/material.dart';

import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:http/http.dart' as http;

class testPage extends StatefulWidget {
  const testPage({Key? key}) : super(key: key);

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: Center(
      //   child:
        // Container(
        //   width: 150,
        //   height: 50,
        //   decoration: BoxDecoration(
        //     border: Border.all()
        //   ),
        //   child: GestureDetector(
        //     onPanUpdate: (details) {
        //       // Swiping in right direction.
        //       if (details.delta.dy > 0) log("Swipping Down");

        //       // Swiping in left direction.
        //       if (details.delta.dy < 0) log("Swipping Up");
        //     },
        //     onTap: () => log("onTap"),
        //     child: Center(
        //       child: Text("Gesture Detector")
        //     )
        //   ),
        // )

      // ),
      // body: Padding(
      //   padding: const EdgeInsets.all(15),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       GestureDetector(
      //         child: Container(
      //           width: 130,
      //           padding: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //             border: Border.all(),
      //             borderRadius: BorderRadius.circular(15),
      //             color: Colors.white,
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text("test"),
      //               Icon(Icons.arrow_drop_down)
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: CustomButton(
        text: "Midtrans API",
        onTap: () => callAPI(context),
        // onTap: () => print(randomizeNumber().toString()),
      ),
    );
  }
}

// Random randomizeNumber() {
//   var number = Random();
//   for (int i = 1000; i < 10000; i++) {
//     number.nextInt(100);
//   }
//   return number;
// }

Future<void> callAPI(BuildContext context) async {
  TransactionDetails _transactionDetails = TransactionDetails(1000.toString(), DateTime.now().toString());
  CreditCard _creditCard = CreditCard();
  CustomerDetails _customerDetails = CustomerDetails("test@mail.com", "userData.name!", "userData.phoneNumber!");
  
  RequiredInformation _requiredInformation = RequiredInformation(_transactionDetails, _creditCard, _customerDetails);
  var response = await http.post(
    Uri.parse('https://app.sandbox.midtrans.com/snap/v1/transactions'),
    // headers: {'Content-Type': 'application/json; charset=UTF-8'},  
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Basic U0ItTWlkLXNlcnZlci1TdGpyMUtJaWhUV0NVVGdxdzgtSVlweTg6',
      'Content-Type': 'application/json'
    },
    body: json.encode(_requiredInformation));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> mapBody = jsonDecode(response.body);
    String token = mapBody['token'];
    String redirect_url = mapBody['redirect_url'];

    MidtransSDK? _midtrans = await MidtransSDK.init(
    config: MidtransConfig(
      // clientKey: DotEnv.env['MIDTRANS_CLIENT_KEY'] ?? "",
      clientKey: "U0ItTWlkLXNlcnZlci1TdGpyMUtJaWhUV0NVVGdxdzgtSVlweTg6",
      // merchantBaseUrl: DotEnv.env['MIDTRANS_MERCHANT_BASE_URL'] ?? "",
      merchantBaseUrl: redirect_url+"/",
      colorTheme: ColorTheme(
        // colorPrimary: Theme.of(event.context).accentColor,
        colorPrimary: Theme.of(context).colorScheme.secondary,
        // colorPrimaryDark: Theme.of(event.context).accentColor,
        colorPrimaryDark: Theme.of(context).colorScheme.secondary,
        // colorSecondary: Theme.of(event.context).accentColor,
        colorSecondary: Theme.of(context).colorScheme.secondary,
      ),
    ),
  );
  
  _midtrans?.setUIKitCustomSetting(
    skipCustomerDetailsPages: true,
  );
  _midtrans!.setTransactionFinishedCallback((result) {
    log("result.toJson(): ${result.toJson()}");
    log("result.transactionStatus.toString(): ${result.transactionStatus.toString()}");
    // if (result.transactionStatus == TransactionResultStatus.settlement) 
  });

  _midtrans?.startPaymentUiFlow(
    // token: DotEnv.env['SNAP_TOKEN']);
    token: token
  );

  log("");
  // Menunggu Pembayaran
  // Sudah Dibayar

  // Sedang diproses
  // Sedang diantarkan
  // Selesai
}

class RequiredInformation {
  TransactionDetails _transactionDetails;
  CreditCard _creditCard;
  CustomerDetails _customerDetails;

  RequiredInformation(this._transactionDetails, this._creditCard, this._customerDetails);

  Map toJson() {
    Map _mapTransactionDetails = this._transactionDetails.toJson();
    Map _mapCreditCard = this._creditCard.toJson();
    Map _customerDetails = this._customerDetails.toJson();

    return {
      "transaction_details": _mapTransactionDetails,
      "credit_card": _mapCreditCard,
      "customer_details": _customerDetails
    };
  }
}

class TransactionDetails{
  final String bill;
  final String orderID;
  TransactionDetails(this.bill, this.orderID);

  Map toJson() => {
    // "order_id": "YOUR-ORDERID-HIMALEKOM1",
    // "gross_amount": 10000
    "order_id": orderID,
    "gross_amount": bill
  };
}

class CreditCard{
  Map toJson() => {
    "secure" : true
  };
}

class CustomerDetails{
  final String email;
  final String firstName;
  // final String lastName;
  final String phoneNumber;
  CustomerDetails(this.email, this.firstName, /*this.lastName,*/ this.phoneNumber);

  Map toJson() => {
    // "first_name": "budi",
    // "last_name": "pratama",
    // "email": "budi.pra@example.com",
    // "phone": "08111222333"
    "first_name": firstName,
    "last_name": "",
    "email": email,
    "phone": phoneNumber
  };
}