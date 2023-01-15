part of 'catalogue_bloc.dart';

abstract class CatalogueEvent extends Equatable {
  const CatalogueEvent();

  @override
  List<Object> get props => [];
}

class CatalogueRequested extends CatalogueEvent {
  final BuildContext context;
  CatalogueRequested(this.context);

  @override
  List<Object> get props => [context];
}

class DeleteProductTriggered extends CatalogueEvent {
  final BuildContext context;
  final String productID;
  DeleteProductTriggered({required this.context, required this.productID});

  @override
  List<Object> get props => [context, productID];
}

class ProductDetailed extends CatalogueEvent {
  final String productID;
  final String userID;

  ProductDetailed(this.productID, this.userID);

  @override
  List<Object> get props => [
    productID,
    userID
  ];
}

class ProductSubmitted extends CatalogueEvent {
  final String productID;
  final String userID;

  ProductSubmitted(this.productID, this.userID);

  @override
  List<Object> get props => [
    productID,
    userID
  ];
}

class QuantityDecreased extends CatalogueEvent {

  @override
  List<Object> get props => [];
}

class QuantityIncreased extends CatalogueEvent {

  @override
  List<Object> get props => [];
}