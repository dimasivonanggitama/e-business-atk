part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class ChangeOrderStatusTriggered extends OrderEvent {
  final String orderID;
  final String orderStatus;
  final String userID;
  ChangeOrderStatusTriggered(this.orderID, this.orderStatus, this.userID);

  @override
  List<Object> get props => [orderID, orderStatus];
}

class OrderDetailed extends OrderEvent {
  final String orderID;

  OrderDetailed(this.orderID);
  
  @override
  List<Object> get props => [
    orderID,
  ];
}

class OrdersRequested extends OrderEvent {
  final String userID;

  OrdersRequested(this.userID);
  
  @override
  List<Object> get props => [
    userID
  ];
}
