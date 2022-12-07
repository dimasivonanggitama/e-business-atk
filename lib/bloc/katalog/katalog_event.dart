part of 'katalog_bloc.dart';

abstract class KatalogEvent extends Equatable {
  const KatalogEvent();

  @override
  List<Object> get props => [];
}

class ProdukFetched extends KatalogEvent {
  
  @override
  List<Object> get props => [];
}

class RowRequested extends KatalogEvent {
  final BuildContext context;
  RowRequested(this.context);

  @override
  List<Object> get props => [context];
}