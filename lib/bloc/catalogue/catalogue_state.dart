part of 'catalogue_bloc.dart';

abstract class CatalogueState extends Equatable {
  const CatalogueState();
  
  @override
  List<Object> get props => [];
}

class CatalogueInitial extends CatalogueState {
  final String documentID;
  final IconData iconButton;
  final bool isSubmitButtonDisabled;
  final List listofProductData;
  final int maxColumn;
  final int maxRow;
  final int productQuantityCart;
  final int productQuantityTemporary;
  final String textButton;

  CatalogueInitial({
    required this.documentID,
    required this.iconButton,
    required this.isSubmitButtonDisabled,
    required this.listofProductData,
    required this.maxColumn,
    required this.maxRow,
    required this.productQuantityCart,
    required this.productQuantityTemporary,
    required this.textButton,
  });

  CatalogueInitial currentValue({
    String? documentID,
    IconData? iconButton,
    bool? isSubmitButtonDisabled,
    List? listofProductData,
    int? maxColumn,
    int? maxRow,
    int? productQuantityCart,
    int? productQuantityTemporary,
    String? textButton,
  }) {
    return CatalogueInitial(
      documentID: documentID ?? this.documentID,
      iconButton: iconButton ?? this.iconButton,
      isSubmitButtonDisabled: isSubmitButtonDisabled ?? this.isSubmitButtonDisabled,
      listofProductData: listofProductData ?? this.listofProductData,
      maxColumn: maxColumn ?? this.maxColumn,
      maxRow: maxRow ?? this.maxRow,
      productQuantityCart: productQuantityCart ?? this.productQuantityCart,
      productQuantityTemporary: productQuantityTemporary ?? this.productQuantityTemporary,
      textButton: textButton ?? this.textButton
    );
  }
  
  @override
  List<Object> get props => [
    documentID,
    iconButton,
    isSubmitButtonDisabled,
    listofProductData,
    maxColumn,
    maxRow,
    productQuantityCart,
    productQuantityTemporary,
    textButton
  ];
}


