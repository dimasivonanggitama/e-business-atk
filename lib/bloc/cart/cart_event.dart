part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartRequested extends CartEvent {
  final String userID;

  CartRequested(this.userID);

  @override
  List<Object> get props => [
    userID
  ];
}

class CartSubmitted extends CartEvent {
  final BuildContext context;
  final String userID;

  CartSubmitted(this.context, this.userID);

  @override
  List<Object> get props => [
    context,
    userID
  ];
}

class DeleteItemTriggered extends CartEvent {
  final String cartID;
  final String userID;
  DeleteItemTriggered(this.cartID, this.userID);

  @override
  List<Object> get props => [cartID, userID];
}

class DeliveryAddressSubmitted extends CartEvent {
  final String addressTextFieldValue;
  final String userID;
  DeliveryAddressSubmitted(this.addressTextFieldValue, this.userID);

  @override
  List<Object> get props => [addressTextFieldValue, userID];
}

class DeliveryOptionSelected extends CartEvent {
  final String deliveryOptionSelectedMenu;
  final bool deliveryOptionStatus;
  final String userID;
  DeliveryOptionSelected(this.deliveryOptionSelectedMenu, this.deliveryOptionStatus, this.userID);

  @override
  List<Object> get props => [
    deliveryOptionSelectedMenu,
    deliveryOptionStatus,
    userID
  ];
}

class ItemChecked extends CartEvent {
  final String cartID;
  final bool currentValue;
  final String userID;

  ItemChecked(
    this.cartID,
    this.currentValue,
    this.userID
  );

  @override
  List<Object> get props => [
    cartID,
    currentValue,
    userID
  ];
}

class NavigationBarTriggered extends CartEvent {
  final String userID;
  NavigationBarTriggered(this.userID);

  @override
  List<Object> get props => [userID];
}

class PhoneNumberSubmitted extends CartEvent {
  final String phoneNumberTextFieldValue;
  final String userID;
  PhoneNumberSubmitted(this.phoneNumberTextFieldValue, this.userID);

  @override
  List<Object> get props => [phoneNumberTextFieldValue, userID];
}

class QuantityDecreased extends CartEvent {
  final String cartID;
  final String productID;
  final int productQuantity;
  final String userID;

  QuantityDecreased(
    this.cartID, 
    this.productID,
    this.productQuantity,
    this.userID
  );

  @override
  List<Object> get props => [
    cartID,
    productID,
    productQuantity,
    userID
  ];
}

class QuantityIncreased extends CartEvent {
  final String cartID;
  final String productID;
  final int productQuantity;
  final String userID;

  QuantityIncreased(
    this.cartID, 
    this.productID,
    this.productQuantity,
    this.userID
  );

  @override
  List<Object> get props => [
    cartID,
    productID,
    productQuantity,
    userID
  ];
}