part of 'katalog_bloc.dart';

abstract class KatalogState extends Equatable {
  const KatalogState();
  
  @override
  List<Object> get props => [];
}

class KatalogInitial extends KatalogState {}

class ProdukSuccessfullyFetched extends KatalogState {
  final List<ProdukModel> listofProdukData;

  ProdukSuccessfullyFetched(this.listofProdukData);

  @override
  List<Object> get props => [listofProdukData];
}

class GenerateRow extends KatalogState {
  final List mappedData;

  GenerateRow(this.mappedData);

  @override
  List<Object> get props => [mappedData];
}


