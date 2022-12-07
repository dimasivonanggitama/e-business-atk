part of 'itemTile_bloc.dart';

// @immutable
abstract class itemTileEvent {}

class productItemNameEvent extends itemTileEvent {
  final String namaProduk;

  productItemNameEvent(this.namaProduk);
}