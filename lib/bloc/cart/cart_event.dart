part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class QuantityDecreased extends CartEvent {

  @override
  List<Object> get props => [];
}

class QuantityIncreased extends CartEvent {

  @override
  List<Object> get props => [];
}

class ProductDetailed extends CartEvent {
  final String productID;
  final String userID;

  ProductDetailed(this.productID, this.userID);

  @override
  List<Object> get props => [
    productID,
    userID
  ];
}

class ProductSubmitted extends CartEvent {
  final String productID;
  final int productQuantityTemporary;
  final String userID;

  ProductSubmitted(this.productID, this.productQuantityTemporary, this.userID);

  @override
  List<Object> get props => [
    productID,
    productQuantityTemporary,
    userID
  ];
}