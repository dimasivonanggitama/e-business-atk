part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  final String deliveryAddress;
  final String deliveryFeeDecimal;
  final int deliveryFeeInteger;
  final String deliveryOptionSelectedMenu;
  final int grandTotalPrice;
  final bool isDeliveryOptionSelected;
  final bool isNavigationBarClicked;
  final bool isStateInitialized;
  final bool isSubmitButtonDisabled;
  final List listofCheckedItems;
  final List listofPrices;
  final List listofProducts;
  final List listofSelectedItems;
  final List listofSelectedItemsPriceWithQuantity;
  final List listofSelectedItemsProduct;
  final List listofSelectedItemsQuantity;
  final List listofUserCart;
  final double navigationBarHeight;
  final String phoneNumber;
  final String productID;
  final int totalItemsSelected;
  final String totalPriceDecimal;
  final int totalPriceInteger;
  final int totalPriceofSelectedItems;
  final String userID;

  CartInitial({
    required this.deliveryAddress,
    required this.deliveryFeeDecimal,
    required this.deliveryFeeInteger,
    required this.deliveryOptionSelectedMenu,
    required this.grandTotalPrice,
    required this.isDeliveryOptionSelected,
    required this.isNavigationBarClicked,
    required this.isStateInitialized,
    required this.isSubmitButtonDisabled,
    required this.listofCheckedItems,
    required this.listofPrices,
    required this.listofProducts,
    required this.listofSelectedItems,
    required this.listofSelectedItemsPriceWithQuantity,
    required this.listofSelectedItemsProduct,
    required this.listofSelectedItemsQuantity,
    required this.listofUserCart,
    required this.navigationBarHeight,
    required this.phoneNumber,
    required this.productID,
    required this.totalItemsSelected,
    required this.totalPriceDecimal,
    required this.totalPriceInteger,
    required this.totalPriceofSelectedItems,
    required this.userID
  });

  CartInitial currentValue({
    String? deliveryAddress,
    String? deliveryFeeDecimal,
    int? deliveryFeeInteger,
    String? deliveryOptionSelectedMenu,
    int? grandTotalPrice,
    bool? isDeliveryOptionSelected,
    bool? isNavigationBarClicked,
    bool? isStateInitialized,
    bool? isSubmitButtonDisabled,
    List? listofCheckedItem,
    double? navigationBarHeight,
    List? listofPrices,
    List? listofProducts,
    List? listofSelectedItems,
    List? listofSelectedItemsPriceWithQuantity,
    List? listofSelectedItemsProduct,
    List? listofSelectedItemsQuantity,
    List? listofUserCart,
    String? phoneNumber,
    String? productID,
    int? totalItemsSelected,
    String? totalPriceDecimal,
    int? totalPriceInteger,
    int? totalPriceofSelectedItems,
    String? userID
  }) {
    return CartInitial(
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryFeeDecimal: deliveryFeeDecimal ?? this.deliveryFeeDecimal,
      deliveryFeeInteger: deliveryFeeInteger ?? this.deliveryFeeInteger,
      deliveryOptionSelectedMenu: deliveryOptionSelectedMenu ?? this.deliveryOptionSelectedMenu,
      grandTotalPrice: grandTotalPrice ?? this.grandTotalPrice,
      isDeliveryOptionSelected: isDeliveryOptionSelected ?? this.isDeliveryOptionSelected,
      isNavigationBarClicked: isNavigationBarClicked ?? this.isNavigationBarClicked,
      isStateInitialized: isStateInitialized ?? this.isStateInitialized,
      isSubmitButtonDisabled: isSubmitButtonDisabled ?? this.isSubmitButtonDisabled,
      listofCheckedItems: listofCheckedItem ?? this.listofCheckedItems,
      listofPrices: listofPrices ?? this.listofPrices,
      listofProducts: listofProducts ?? this.listofProducts,
      listofSelectedItems: listofSelectedItems ?? this.listofSelectedItems,
      listofSelectedItemsPriceWithQuantity: listofSelectedItemsPriceWithQuantity ?? this.listofSelectedItemsPriceWithQuantity,
      listofSelectedItemsProduct: listofSelectedItemsProduct ?? this.listofSelectedItemsProduct,
      listofSelectedItemsQuantity: listofSelectedItemsQuantity ?? this.listofSelectedItemsQuantity,
      listofUserCart: listofUserCart ?? this.listofUserCart,
      navigationBarHeight: navigationBarHeight ?? this.navigationBarHeight,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      productID: productID ?? this.productID,
      totalItemsSelected: totalItemsSelected ?? this.totalItemsSelected,
      totalPriceDecimal: totalPriceDecimal ?? this.totalPriceDecimal,
      totalPriceInteger: totalPriceInteger ?? this.totalPriceInteger,
      totalPriceofSelectedItems: totalPriceofSelectedItems ?? this.totalPriceofSelectedItems,
      userID: userID ?? this.userID 
    );
  }
  
  @override
  List<Object> get props => [
    deliveryAddress,
    deliveryFeeDecimal,
    deliveryFeeInteger,
    deliveryOptionSelectedMenu,
    grandTotalPrice,
    isDeliveryOptionSelected,
    isNavigationBarClicked,
    isStateInitialized,
    isSubmitButtonDisabled,
    listofCheckedItems,
    listofPrices,
    listofProducts,
    listofSelectedItems,
    listofSelectedItemsPriceWithQuantity,
    listofSelectedItemsProduct,
    listofSelectedItemsQuantity,
    listofUserCart,
    navigationBarHeight,
    phoneNumber,
    productID,
    totalItemsSelected,
    totalPriceDecimal,
    totalPriceInteger,
    totalPriceofSelectedItems,
    userID
  ];
}
