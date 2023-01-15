part of 'product_form_bloc.dart';

enum Status { add, edit }

abstract class ProductFormEvent extends Equatable {
  const ProductFormEvent();

  @override
  List<Object> get props => [];
}

class BrandChanged extends ProductFormEvent {
  final String brand;
  const BrandChanged(this.brand);

  @override
  List<Object> get props => [brand];
}

class CategoryChanged extends ProductFormEvent {
  final String category;
  const CategoryChanged(this.category);

  @override
  List<Object> get props => [category];
}

class CategoryDropdownItemsFetched extends ProductFormEvent {
  
  @override
  List<Object> get props => [];
}

class DeleteProductCategoryTriggered extends ProductFormEvent {
  final String categoryID;
  DeleteProductCategoryTriggered(this.categoryID);

  @override
  List<Object> get props => [categoryID];
}

class EditProductCategorySubmitted extends ProductFormEvent {
  final String categoryID;
  final String categoryName;
  EditProductCategorySubmitted(this.categoryID, this.categoryName);

  @override
  List<Object> get props => [
    categoryID,
    categoryName
  ];
}

class FormFailed extends ProductFormEvent {

  @override
  List<Object> get props => [];
}

class FormSubmitted extends ProductFormEvent {
  final BuildContext context;
  FormSubmitted({required this.context});

  @override
  List<Object> get props => [context];
}

class NameChanged extends ProductFormEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class PriceFieldChanged extends ProductFormEvent {
  final String price;
  const PriceFieldChanged(this.price);

  @override
  List<Object> get props => [price];
}

class ProductCatalogueAdminRequested extends ProductFormEvent {
  const ProductCatalogueAdminRequested();

  @override
  List<Object> get props => [];
}

class ProductCategoryAdded extends ProductFormEvent {
  final String categoryName;
  ProductCategoryAdded(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}

class ProductDataFetched extends ProductFormEvent {
  final String documentID;
  const ProductDataFetched({this.documentID = ""});

  @override
  List<Object> get props => [documentID];
}

class SelectImagePressed extends ProductFormEvent {

  @override
  List<Object> get props => [];
}

class StockQuantityChanged extends ProductFormEvent {
  final String stockQuantity;
  const StockQuantityChanged(this.stockQuantity);

  @override
  List<Object> get props => [stockQuantity];
}

class ValueReset extends ProductFormEvent {

  @override
  List<Object> get props => [];
}