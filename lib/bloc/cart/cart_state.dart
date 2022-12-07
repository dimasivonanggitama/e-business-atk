part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  final IconData iconButton;
  final bool isSubmitButtonDisabled;
  final String productID;
  final int productQuantityCart;
  final int productQuantityTemporary;
  final String textButton;
  final String userID;

  CartInitial({
    required this.iconButton,
    required this.isSubmitButtonDisabled,
    required this.productID,
    required this.productQuantityCart,
    required this.productQuantityTemporary,
    required this.textButton,
    required this.userID
  });

  CartInitial currentValue({
    IconData? iconButton,
    bool? isSubmitButtonDisabled,
    String? productID,
    int? productQuantityCart,
    int? productQuantityTemporary,
    String? textButton,
    String? userID
  }) {
    return CartInitial(
      iconButton: iconButton ?? this.iconButton,
      isSubmitButtonDisabled: isSubmitButtonDisabled ?? this.isSubmitButtonDisabled,
      productID: productID ?? this.productID,
      productQuantityCart: productQuantityCart ?? this.productQuantityCart,
      productQuantityTemporary: productQuantityTemporary ?? this.productQuantityTemporary,
      textButton: textButton ?? this.textButton,
      userID: userID ?? this.userID 
    );
  }
  
  @override
  List<Object> get props => [
    iconButton,
    isSubmitButtonDisabled,
    productID,
    productQuantityCart,
    productQuantityTemporary,
    textButton,
    userID
  ];
}
