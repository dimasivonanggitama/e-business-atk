part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {
  final String address;
  final String changeOrderStatusButtonText;
  final int deliveryFee;
  final List listofProducts;
  final List listofSelectedItems;
  final List listofUserOrders;
  final String orderID;
  final String paymentMethod;
  final String phoneNumber;
  final String status;
  final int totalPrice;
  final int totalPrintItems;
  final int totalProductItems;
  final Timestamp timestamp;
  final String userID;
  final String userName;

  OrderInitial({
    required this.address,
    required this.changeOrderStatusButtonText,
    required this.deliveryFee,
    required this.listofProducts,
    required this.listofSelectedItems,
    required this.listofUserOrders,
    required this.orderID,
    required this.paymentMethod,
    required this.phoneNumber,
    required this.status,
    required this.timestamp,
    required this.totalPrice,
    required this.totalPrintItems,
    required this.totalProductItems,
    required this.userID,
    required this.userName
});

  OrderInitial currentValue({
  final String? address,
  final String? changeOrderStatusButtonText,
  final int? deliveryFee,
  final List? listofProducts,
  final List? listofSelectedItems,
  final List? listofUserOrders,
  final String? orderID,
  final String? paymentMethod,
  final String? phoneNumber,
  final String? status,
  final Timestamp? timestamp,
  final int? totalPrice,
  final int? totalPrintItems,
  final int? totalProductItems,
  final String? userID,
  final String? userName
}) {
  return OrderInitial(
    address: address ?? this.address,
    changeOrderStatusButtonText: changeOrderStatusButtonText ?? this.changeOrderStatusButtonText,
    deliveryFee: deliveryFee ?? this.deliveryFee,
    listofProducts: listofProducts ?? this.listofProducts,
    listofSelectedItems: listofSelectedItems ?? this.listofSelectedItems,
    listofUserOrders: listofUserOrders ?? this.listofUserOrders,
    orderID: orderID ?? this.orderID,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    status: status ?? this.status,
    timestamp: timestamp ?? this.timestamp,
    totalPrice: totalPrice ?? this.totalPrice,
    totalPrintItems: totalPrintItems ?? this.totalPrintItems,
    totalProductItems: totalProductItems ?? this.totalProductItems,
    userID: userID ?? this.userID,
    userName: userName ?? this.userName,
  );
}
  
  @override
  List<Object> get props => [
    address,
    changeOrderStatusButtonText,
    deliveryFee,
    listofProducts,
    listofSelectedItems,
    listofUserOrders,
    orderID,
    paymentMethod,
    phoneNumber,
    status,
    timestamp,
    totalPrice,
    totalPrintItems,
    totalProductItems,
    userID,
    userName
  ];
}

class OrderFetched extends OrderState {}
