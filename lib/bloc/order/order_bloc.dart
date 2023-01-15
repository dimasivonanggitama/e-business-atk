import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebusiness_atk_mobile/models/printPrice_model.dart';
import 'package:ebusiness_atk_mobile/repository/user_repository.dart';
import 'package:ebusiness_atk_mobile/views/components/convert_categoryIDtoName.dart';
import 'package:equatable/equatable.dart';

import '../../models/cart_model.dart';
import '../../models/order_model.dart';
import '../../models/productCategory_model.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../repository/cart_repository.dart';
import '../../repository/order_repository.dart';
import '../../repository/product_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderInitial> {
  CartRepository _cartRepository = CartRepository();
  OrderRepository _orderRepository = OrderRepository();
  ProductRepository _productRepository = ProductRepository();
  UserRepository _userRepository = UserRepository();

  OrderBloc(this._cartRepository, this._orderRepository, this._productRepository, this._userRepository) : super(OrderInitial(
    address: "",
    changeOrderStatusButtonText: "",
    deliveryFee: 0,
    listofProducts: [],
    listofSelectedItems: [],
    listofUserOrders: [],
    orderID:  "",
    paymentMethod: "",
    phoneNumber: "",
    status: "",
    timestamp: Timestamp(0, 0),
    totalPrice: 0,
    totalPrintItems: 0,
    totalProductItems: 0,
    userID: "",
    userName: ""
  )) {
    on<ChangeOrderStatusTriggered>(
      (event, emit) async {
        String orderStatus = "";

        if (event.orderStatus == "Sudah dibayar") orderStatus = "Sedang diproses";
          // "Sedang diproses"
          // ubah tulisan tombol
          // ubah parameter ketika tombol ditekan
        else if (event.orderStatus == "Sedang diproses" && state.deliveryFee != 0) orderStatus = "Sedang diantarkan";
          // "Sedang diantarkan"
          // ubah tulisan tombol
          // ubah parameter ketika tombol ditekan
        else if (event.orderStatus == "Sedang diproses" && state.deliveryFee == 0) orderStatus = "Selesai";
          // "Selesai"
          // ubah tulisan tombol
          // ubah parameter ketika tombol ditekan
        else if (event.orderStatus == "Sedang diantarkan") orderStatus = "Selesai";
          // "Selesai"
          // ubah tulisan tombol
          // ubah parameter ketika tombol ditekan
        
        // status: sedang diantarkan, tombol: antar sekarang
        // OrderDetailed(orderID)

        for (int i = 0; i < state.listofUserOrders.length; i++) {
          if (state.listofUserOrders[i].documentID == event.orderID) {
            OrderModel orderData = OrderModel(
              deliveryFee:       state.listofUserOrders[i].deliveryFee,
              paymentMethod:     state.listofUserOrders[i].paymentMethod,
              status:            orderStatus,
              totalPrice:        state.listofUserOrders[i].totalPrice,
              totalPrintItems:   state.listofUserOrders[i].totalPrintItems,
              totalProductItems: state.listofUserOrders[i].totalProductItems,
              userID:            state.listofUserOrders[i].userID
            );
            await _orderRepository.updateOrderStatus(event.orderID, orderData);
          }
        }
        await orderRequested(event, emit);
        await orderDetailed(event, emit);
      }
    );

    on<OrderDetailed>(
      (event, emit) async {
        await orderDetailed(event, emit);
      }
    );

    on<OrdersRequested>(
      (event, emit) async {
       await orderRequested(event, emit);
      }
    );
  }

  Future orderDetailed(dynamic event, Emitter<OrderInitial> emit) async {
    int colorfulPagePrice                            = 0;
    String currentAddress                            = "";
    int currentDeliveryFee                           = 0;
    String currentPaymentMethod                      = "";
    String currentPhoneNumber                        = "";
    String currentStatus                             = "";
    dynamic currentTimestamp                         = "";
    String currentUserName                           = "";
    String currentUserID                             = "";
    int currentTotalPrice                            = 0;
    int currentTotalPrintItems                       = 0;
    int currentTotalProductItems                     = 0;
    int greyscalePagePrice                           = 0;
    List<ProductCategoryModel> listofProductCategory = await _productRepository.retrieveCategories();
    List<CartModel> listofSelectedItems              = await _orderRepository.retrieveSelectedItems(event.orderID);
    List<PrintPriceModel> _printPrice                = await _cartRepository.retrievePrintPrice();
    ProductModel _product;

    for (int i = 0; i < _printPrice.length; i++) {
      colorfulPagePrice  = _printPrice[i].colorfulPagePrice!;
      greyscalePagePrice = _printPrice[i].greyscalePagePrice!;
    }

    for (int i = 0; i < listofSelectedItems.length; i++) {
      if (listofSelectedItems[i].productID!.isEmpty) {
        listofSelectedItems[i].cartItemPrice   = (listofSelectedItems[i].colorfulPage! * colorfulPagePrice) + (listofSelectedItems[i].greyscalePage! * greyscalePagePrice);
      } else {
        _product = await _productRepository.retrieveSpecificProduct(listofSelectedItems[i].productID!);
        listofSelectedItems[i].productBrand    = _product.brand;
        listofSelectedItems[i].productCategory = _product.category;
        listofSelectedItems[i].productImage    = _product.image;
        listofSelectedItems[i].productName     = _product.name;
        listofSelectedItems[i].productPrice    = _product.price;
        listofSelectedItems[i].cartItemPrice   = listofSelectedItems[i].productPrice! * listofSelectedItems[i].productQuantity!;
      }
      currentUserID                            = listofSelectedItems[i].userID!;
    }

    for(int i = 0; i < listofSelectedItems.length; i++) { // convert category ID to category name
      for(int j = 0; j < listofProductCategory.length; j++) {
        if (listofSelectedItems[i].productCategory == listofProductCategory[j].id) listofSelectedItems[i].productCategory = listofProductCategory[j].category;
      }
    }
    
    for (int i = 0; i < listofSelectedItems.length; i++) {  // get current Total Price order
      currentTotalPrice += listofSelectedItems[i].cartItemPrice!;
    }

    UserModel _user = await _userRepository.retrieveUserData(currentUserID);
    currentAddress     = _user.address!;
    currentUserName    = _user.name!;
    currentPhoneNumber = _user.phoneNumber!;

    for (int i = 0; i < state.listofUserOrders.length; i++) {  // get specific deliveryFee, timedate, userName, 
      if (state.listofUserOrders[i].documentID == event.orderID) {
        // currentAddress           = state.listofUserOrders[i].address;
        currentDeliveryFee       = state.listofUserOrders[i].deliveryFee;
        currentPaymentMethod     = state.listofUserOrders[i].paymentMethod;
        // currentPhoneNumber       = state.listofUserOrders[i].phoneNumber;
        currentStatus            = state.listofUserOrders[i].status;
        currentTimestamp         = state.listofUserOrders[i].dateCreated;
        currentTotalPrintItems   = state.listofUserOrders[i].totalPrintItems;
        currentTotalProductItems = state.listofUserOrders[i].totalProductItems;
        // currentUserName          = state.listofUserOrders[i].userName;
      }
    }

    // order status button text
    if (currentStatus == "Sudah dibayar") emit(state.currentValue(changeOrderStatusButtonText: "Proses Pesanan"));
    else if (currentStatus == "Sedang diproses" && state.deliveryFee != 0) emit(state.currentValue(changeOrderStatusButtonText: "Antar sekarang"));
    else if (currentStatus == "Sedang diproses" && state.deliveryFee == 0) emit(state.currentValue(changeOrderStatusButtonText: "Selesai"));
    else if (currentStatus == "Sedang diantarkan") emit(state.currentValue(changeOrderStatusButtonText: "Selesai"));

    emit(
      state.currentValue(
        address: currentAddress,
        deliveryFee: currentDeliveryFee,
        listofSelectedItems: listofSelectedItems,
        orderID: event.orderID,
        paymentMethod: currentPaymentMethod,
        phoneNumber: currentPhoneNumber,
        status: currentStatus,
        timestamp: currentTimestamp,
        totalPrice: currentTotalPrice,
        totalPrintItems: currentTotalPrintItems,
        totalProductItems: currentTotalProductItems,
        userName: currentUserName
      )
    );
  }

  Future orderRequested(dynamic event, Emitter<OrderInitial> emit) async {
    List<OrderModel> listofUserOrders = [];
    UserModel userData = await _userRepository.retrieveUserData(event.userID);

    if (userData.status == "reguler") {
      listofUserOrders = await _orderRepository.retrieveUserOrders(event.userID);
    } else {
      listofUserOrders = await _orderRepository.retrieveAllOrders();
    }

    emit(
      state.currentValue(
        listofUserOrders: listofUserOrders,
        userID: event.userID
      )
    );
  }
}
