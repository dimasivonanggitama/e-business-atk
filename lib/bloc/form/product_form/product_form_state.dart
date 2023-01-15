part of 'product_form_bloc.dart';

abstract class ProductFormState extends Equatable {
  const ProductFormState();
}

class FormInitial extends ProductFormState {
  const FormInitial({
    required this.brand,
    required this.category,
    required this.categoryDropdownItems,
    required this.formStatus,
    required this.imageSelected,
    required this.imageUploaded,
    required this.isBrandValid,
    required this.isCategoryValid,
    required this.isFormValidateFailed,
    required this.isImageValid,
    required this.isNameValid,
    required this.isPriceChanged,
    required this.isPriceValid,
    required this.isStockQuantityChanged,
    required this.isStockQuantityValid,
    // required this.listofProducts,
    required this.name,
    required this.price,
    required this.priceDisplay,
    required this.priceErrorMessage,
    required this.productID,
    required this.stockQuantity,
    required this.stockQuantityDisplay,
    required this.stockQuantityErrorMessage,
  });

  final String brand;
  final String category;
  final List<ProductCategoryModel> categoryDropdownItems;
  final Status formStatus;
  final File? imageSelected;
  final String imageUploaded;
  final bool isBrandValid;
  final bool isCategoryValid;
  final bool isFormValidateFailed;
  final bool isImageValid;
  final bool isNameValid;
  final bool isPriceChanged;
  final bool isPriceValid;
  final bool isStockQuantityChanged;
  final bool isStockQuantityValid;
  // final List listofProducts;
  final String name;
  final int price;
  final String priceDisplay;
  final String priceErrorMessage;
  final String productID;
  final int stockQuantity;
  final String stockQuantityDisplay;
  final String stockQuantityErrorMessage;

  FormInitial currentValue({    
    // String? email,
    String? brand,
    String? category,
    List<ProductCategoryModel>? categoryDropdownItems,
    IconData? categoryProductEditButton,
    Status? formStatus,
    File? imageSelected,
    String? imageUploaded,
    bool? isBrandValid,
    bool? isCategoryValid,
    bool? isEditProductCategoryOn,
    bool? isFormValidateFailed,
    bool? isImageValid,
    bool? isNameValid,
    bool? isPriceChanged,
    bool? isPriceValid,
    bool? isStockQuantityChanged,
    bool? isStockQuantityValid,
    // List? listofProducts,
    String? name,
    int? price,
    String? priceDisplay,
    String? priceErrorMessage,
    String? productID,
    int? stockQuantity,
    String? stockQuantityDisplay,
    String? stockQuantityErrorMessage
  }) {
    return FormInitial(
      brand: brand ?? this.brand,
      category: category ?? this.category,
      categoryDropdownItems: categoryDropdownItems ?? this.categoryDropdownItems,
      formStatus: formStatus ?? this.formStatus,
      imageSelected: imageSelected ?? this.imageSelected,
      imageUploaded: imageUploaded ?? this.imageUploaded,
      isBrandValid: isBrandValid ?? this.isBrandValid,
      isCategoryValid: isCategoryValid ?? this.isCategoryValid,
      isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
      isImageValid: isImageValid ?? this.isImageValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isPriceChanged: isPriceChanged ?? this.isPriceChanged,
      isPriceValid: isPriceValid ?? this.isPriceValid,
      isStockQuantityChanged: isStockQuantityChanged ?? this.isStockQuantityChanged,
      isStockQuantityValid: isStockQuantityValid ?? this.isStockQuantityValid,
      // listofProducts: listofProducts ?? this.listofProducts,
      name: name ?? this.name,
      price: price ?? this.price,
      priceDisplay: priceDisplay ?? this.priceDisplay,
      priceErrorMessage: priceErrorMessage ?? this.priceErrorMessage,
      productID: productID ?? this.productID,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      stockQuantityDisplay: stockQuantityDisplay ?? this.stockQuantityDisplay,
      stockQuantityErrorMessage: stockQuantityErrorMessage ?? this.stockQuantityErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    brand,
    category,
    categoryDropdownItems,
    formStatus,
    imageSelected,
    imageUploaded,
    isBrandValid,
    isCategoryValid,
    isFormValidateFailed,
    isImageValid,
    isNameValid,
    isPriceChanged,
    isPriceValid,
    isStockQuantityChanged,
    isStockQuantityValid,
    // listofProducts,
    name,
    price,
    priceDisplay,
    priceErrorMessage,
    productID,
    stockQuantity,
    stockQuantityDisplay,
    stockQuantityErrorMessage,
  ];
}