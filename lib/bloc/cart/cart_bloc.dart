import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:ebusiness_atk_mobile/models/deliveryFee_model.dart';
import 'package:ebusiness_atk_mobile/models/printPrice_model.dart';
import 'package:ebusiness_atk_mobile/models/user_model.dart';
import 'package:ebusiness_atk_mobile/repository/order_repository.dart';
import 'package:ebusiness_atk_mobile/repository/printPrice_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

import '../../models/cart_model.dart';
import '../../models/order_model.dart';
import '../../models/product_model.dart';
import '../../models/productCategory_model.dart';
import '../../repository/cart_repository.dart';
import '../../repository/product_repository.dart';

import 'package:http/http.dart' as http;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartInitial> {
  CartRepository _cartRepository = CartRepository();
  ProductRepository _productRepository = ProductRepository();
  OrderRepository _orderRepository = OrderRepository();
  CartBloc(this._cartRepository, this._orderRepository, this._productRepository) : super(CartInitial(
    deliveryAddress: "",
    deliveryFeeDecimal: "",
    deliveryFeeInteger: 0,
    deliveryOptionSelectedMenu: "Belum dipilih",
    grandTotalPrice: 0,
    isDeliveryOptionSelected: false,
    isNavigationBarClicked: false,
    isStateInitialized: true,
    isSubmitButtonDisabled: true,
    listofCheckedItems: [],
    listofPrices: [],
    listofProducts: [],
    listofSelectedItems: [],
    listofSelectedItemsPriceWithQuantity: [],
    listofSelectedItemsProduct: [],
    listofSelectedItemsQuantity: [],
    listofUserCart: [],
    navigationBarHeight: 77,
    phoneNumber: "",
    productID: "",
    totalItemsSelected: 0,
    totalPriceDecimal: "",
    totalPriceInteger: 0,
    totalPriceofSelectedItems: 0,
    userID: ""
  )) {
    on<CartRequested>(
      (event, emit) async {
        await cartRequested(event, emit);
      }
    );

    on<CartSubmitted>(
      (event, emit) async {
        String customDocumentID = md5.convert(utf8.encode(DateTime.now().toString())).toString();
        int totalPriceItems = 0;
        int totalPrintItems = 0;
        int totalProductItems = 0;

        for (int i = 0; i < state.listofSelectedItems.length; i++) {
          if (state.listofSelectedItems[i].isItemChecked == true) {
            if (state.listofSelectedItems[i].productID.isEmpty) totalPrintItems++;
            else totalProductItems++;

            totalPriceItems += (state.listofSelectedItems[i].cartItemPrice) as int;
          };
        }

        OrderModel submittedOrder = OrderModel( // add data to orders collection
          deliveryFee: state.deliveryFeeInteger,
          status: "Menunggu Pembayaran",
          paymentMethod: "",
          totalPrice: totalPriceItems,
          totalPrintItems: totalPrintItems,
          totalProductItems: totalProductItems,
          userID: event.userID
        );
        await _cartRepository.createOrder(customDocumentID, submittedOrder);

        for (int i = 0; i < state.listofSelectedItems.length; i++) {  // update selected cart -> add order ID
          CartModel selectedItem = CartModel(
            colorfulPage:    state.listofSelectedItems[i].colorfulPage,
            filename:        state.listofSelectedItems[i].filename,
            filePath:        state.listofSelectedItems[i].filePath,
            greyscalePage:   state.listofSelectedItems[i].greyscalePage,
            isItemChecked:   state.listofSelectedItems[i].isItemChecked,
            orderID:         customDocumentID,
            productID:       state.listofSelectedItems[i].productID,
            productQuantity: state.listofSelectedItems[i].productQuantity,
            userID:          state.listofSelectedItems[i].userID,
          );
          await _cartRepository.updateCart(state.listofSelectedItems[i].documentID, selectedItem);
        }

        UserModel userData = await _cartRepository.retrieveUserInformation(event.userID);

        // Midtrans payment gateway
        TransactionDetails _transactionDetails = TransactionDetails((totalPriceItems + state.deliveryFeeInteger).toString(), customDocumentID);
        CreditCard _creditCard = CreditCard();
        CustomerDetails _customerDetails = CustomerDetails(userData.email!, userData.name!, userData.phoneNumber!);
        
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

          log('Response status: ${response.statusCode}');
          log('Response body: ${response.body}');

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
              colorPrimary: Theme.of(event.context).colorScheme.secondary,
              // colorPrimaryDark: Theme.of(event.context).accentColor,
              colorPrimaryDark: Theme.of(event.context).colorScheme.secondary,
              // colorSecondary: Theme.of(event.context).accentColor,
              colorSecondary: Theme.of(event.context).colorScheme.secondary,
            ),
          ),
        );
        
        _midtrans?.setUIKitCustomSetting(
          skipCustomerDetailsPages: true,
        );
        _midtrans!.setTransactionFinishedCallback((result) async {
          print(result.toJson());

          if (result.transactionStatus == TransactionResultStatus.settlement) {
            submittedOrder.paymentMethod = result.paymentType;
            submittedOrder.status = "Sudah dibayar";
            await _orderRepository.updateOrderStatus(customDocumentID, submittedOrder);
          }
        });

        _midtrans?.startPaymentUiFlow(
          // token: DotEnv.env['SNAP_TOKEN']);
          token: token
        );
      }
    );

    on<DeleteItemTriggered>(
      (event, emit) async {
        // for(int i = 0; i < state.listofUserCart.length; i++) {
        //   if (state.listofUserCart[i].documentID == event.cartID && state.listofUserCart[i].filePath.isNotEmpty) await _cartRepository.deleteItem(cartID: event.cartID, filePath: state.listofUserCart[i].filePath);
        //   else await _cartRepository.deleteItem(cartID: event.cartID);
        // }
        await _cartRepository.deleteItem(cartID: event.cartID);
        await cartRequested(event, emit);
      }
    );

    on<DeliveryAddressSubmitted>(
      (event, emit) async {
        if (state.deliveryAddress.isNotEmpty) {
          emit(state.currentValue(deliveryAddress: event.addressTextFieldValue));
          await _cartRepository.updateUserAddress(documentID: event.userID, submittedAddress: event.addressTextFieldValue);
          await navigationBarTriggered(event, emit);
        }
      }
    );

    on<DeliveryOptionSelected>(
      (event, emit) async {
        emit(state.currentValue(deliveryOptionSelectedMenu: event.deliveryOptionSelectedMenu));

        if (event.deliveryOptionStatus != state.isDeliveryOptionSelected) {
          emit(
            state.currentValue(
              isDeliveryOptionSelected: !state.isDeliveryOptionSelected,
            )
          );
          await cartRequested(event, emit);
        }
      }
    );

    on<ItemChecked>(
      (event, emit) async {
        for(int i = 0; i < state.listofUserCart.length; i++) {
          if (state.listofUserCart[i].documentID == event.cartID) {
            CartModel submittedItem = CartModel(
              colorfulPage:    state.listofUserCart[i].colorfulPage,
              filename:        state.listofUserCart[i].filename,
              filePath:        state.listofUserCart[i].filePath,
              greyscalePage:   state.listofUserCart[i].greyscalePage,
              isItemChecked:   event.currentValue,
              orderID:         state.listofUserCart[i].orderID,
              productID:       state.listofUserCart[i].productID,
              productQuantity: state.listofUserCart[i].productQuantity,
              userID:          state.listofUserCart[i].userID,
            );

            await _cartRepository.updateCart(event.cartID, submittedItem);
          }
        }
        await cartRequested(event, emit);
      }
    );

    on<NavigationBarTriggered>(
      (event, emit) async {
        await navigationBarTriggered(event, emit);
      }
    );

    on<PhoneNumberSubmitted>(
      (event, emit) async {
        if (state.deliveryAddress.isNotEmpty) {
          emit(state.currentValue(deliveryAddress: event.phoneNumberTextFieldValue));
          await _cartRepository.updateUserAddress(documentID: event.userID, submittedPhoneNumber: event.phoneNumberTextFieldValue);
          await navigationBarTriggered(event, emit);
        }
      }
    );

    on<QuantityDecreased>(
      (event, emit) async {
        if (event.productQuantity != 1) {
          for(int i = 0; i < state.listofUserCart.length; i++) {
            if (state.listofUserCart[i].documentID == event.cartID) {
              CartModel submittedItem = CartModel(
                colorfulPage:    state.listofUserCart[i].colorfulPage,
                filename:        state.listofUserCart[i].filename,
                filePath:        state.listofUserCart[i].filePath,
                greyscalePage:   state.listofUserCart[i].greyscalePage,
                isItemChecked:   state.listofUserCart[i].isItemChecked,
                orderID:         state.listofUserCart[i].orderID,
                productID:       state.listofUserCart[i].productID,
                productQuantity: event.productQuantity - 1,
                userID:          state.listofUserCart[i].userID,
              );

              await _cartRepository.updateCart(event.cartID, submittedItem); 
              await cartRequested(event, emit);
            }
          }
        }
      }
    );

    on<QuantityIncreased>(
      (event, emit) async {
        for(int i = 0; i < state.listofUserCart.length; i++) {
          if (state.listofUserCart[i].documentID == event.cartID) {
            CartModel submittedItem = CartModel(
              colorfulPage:    state.listofUserCart[i].colorfulPage,
              filename:        state.listofUserCart[i].filename,
              filePath:        state.listofUserCart[i].filePath,
              greyscalePage:   state.listofUserCart[i].greyscalePage,
              isItemChecked:   state.listofUserCart[i].isItemChecked,
              orderID:         state.listofUserCart[i].orderID,
              productID:       state.listofUserCart[i].productID,
              productQuantity: event.productQuantity + 1,
              userID:          state.listofUserCart[i].userID,
            );

            await _cartRepository.updateCart(event.cartID, submittedItem); 
            await cartRequested(event, emit);
          }
        }
      }
    );
  }

  Future cartRequested(dynamic event, Emitter<CartInitial> emit) async {
    List<CartModel> listofUserCart      = [];
    List<CartModel> listofUserCartRaw   = await _cartRepository.retrieveUserCart(event.userID);
    List<CartModel> listofSelectedItems = [];
    List<DeliveryFeeModel> _deliveryFee = await _cartRepository.retrieveDeliveryFee();
    List<PrintPriceModel> _printPrice   = await _cartRepository.retrievePrintPrice();

    int colorfulPagePrice = 0;
    int grandTotalPrice = 0;
    int greyscalePagePrice = 0;
    int totalPriceofSelectedItems = 0;

    ProductModel _product;

    for (int i = 0; i < listofUserCartRaw.length; i++) {  // if user cart "order id" is not empty, then collect data
      if (listofUserCartRaw[i].orderID!.isEmpty) listofUserCart.add(listofUserCartRaw[i]);
    }

    for (int i = 0; i < _printPrice.length; i++) {
      colorfulPagePrice  = _printPrice[i].colorfulPagePrice!;
      greyscalePagePrice = _printPrice[i].greyscalePagePrice!;
    }

    for (int i = 0; i < listofUserCart.length; i++) {
      if (listofUserCart[i].productID!.isEmpty) {
        listofUserCart[i].cartItemPrice   = (listofUserCart[i].colorfulPage! * colorfulPagePrice) + (listofUserCart[i].greyscalePage! * greyscalePagePrice);
      } else {
        _product = await _productRepository.retrieveSpecificProduct(listofUserCart[i].productID!);
        listofUserCart[i].productBrand    = _product.brand;
        listofUserCart[i].productCategory = _product.category;
        listofUserCart[i].productImage    = _product.image;
        listofUserCart[i].productName     = _product.name;
        listofUserCart[i].productPrice    = _product.price;
        listofUserCart[i].cartItemPrice   = listofUserCart[i].productPrice! * listofUserCart[i].productQuantity!;
      }
    }
    
    for (int i = 0; i < listofUserCart.length; i++) {
      if (listofUserCart[i].isItemChecked == true) listofSelectedItems.add(listofUserCart[i]);
    }
    
    if (listofSelectedItems.length != 0 && state.deliveryOptionSelectedMenu != "Belum dipilih") emit(state.currentValue(isSubmitButtonDisabled: false));
    else emit(state.currentValue(isSubmitButtonDisabled: true));

    for (int i = 0; i < listofSelectedItems.length; i++) {
      totalPriceofSelectedItems += listofSelectedItems[i].cartItemPrice!;
    }

    if (grandTotalPrice == 0 && listofSelectedItems.length > 0) grandTotalPrice = totalPriceofSelectedItems;

    if (state.isDeliveryOptionSelected) grandTotalPrice += _deliveryFee[0].price!;

    await convertCategoryIDtoName(listofUserCart);
    emit(
      state.currentValue(
        deliveryFeeInteger: _deliveryFee[0].price,
        deliveryFeeDecimal: decimalSeparator(_deliveryFee[0].price!),
        grandTotalPrice: grandTotalPrice,
        listofSelectedItems: listofSelectedItems,
        listofUserCart: listofUserCart,
        totalPriceofSelectedItems: totalPriceofSelectedItems
      )
    );
  }
  
  Future convertCategoryIDtoName(List listofUsertCart) async {
    final ProductRepository _databaseRepository = ProductRepository();
    List<ProductCategoryModel> listofProductCategory = await _databaseRepository.retrieveCategories();
    for(int i = 0; i < listofUsertCart.length; i++) {
      for(int j = 0; j < listofProductCategory.length; j++) {
        if (listofUsertCart[i].productCategory == listofProductCategory[j].id) listofUsertCart[i].productCategory = listofProductCategory[j].category;
      }
    }
    return listofUsertCart;
  }

  String decimalSeparator(int price) {
    List<String> splittedCharacter = price.toString().split('');
    String priceWithSeparator = "";
    int j = 0;

    for (int i = splittedCharacter.length - 1; i >= 0; i--, j++) {
      if (j % 3 == 0 && j != 0) priceWithSeparator = splittedCharacter[i] + "." + priceWithSeparator;
      else priceWithSeparator = splittedCharacter[i] + priceWithSeparator;
    }
    
    return priceWithSeparator;
  }
  
  Future navigationBarTriggered(dynamic event, Emitter<CartInitial> emit) async {
    String _deliveryAddress = "";
    String _phoneNumber = "";

    // List _printPrice = await _cartRepository.retrievePrintPrice();
    // for (int i = 0; i < _printPrice.length; i++) {
    //   colorfulPagePrice = _printPrice[i].colorfulPagePrice;
    //   greyscalePagePrice = _printPrice[i].greyscalePagePrice;
    // }

    UserModel _userModel = await _cartRepository.retrieveUserInformation(event.userID);
    _deliveryAddress = _userModel.address!;
    _phoneNumber = _userModel.phoneNumber!;
    
    emit(
      state.currentValue(
        deliveryAddress: _deliveryAddress,
        isNavigationBarClicked: !state.isNavigationBarClicked,
        phoneNumber: _phoneNumber,
      )
    );
  }
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

          