part of 'itemTile_bloc.dart';

// @immutable
abstract class itemTileState {
  final int number;

  const itemTileState(this.number);
}

class itemTileInitial extends itemTileState {
  const itemTileInitial() : super (0);
}

class itemTileLoaded extends itemTileState {
  const itemTileLoaded(int number) : super(number);
}