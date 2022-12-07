// import 'package:bloc/bloc.dart';

import 'package:ebusiness_atk_mobile/models/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/database_services.dart';
import 'package:flutter/material.dart';

part 'itemTile_event.dart';
part 'itemTile_state.dart';

class itemTileBloc extends Bloc<itemTileEvent, itemTileState> {
  itemTileBloc() : super(const itemTileInitial()) {
    // DatabaseServices.getProduk();

    on<productItemNameEvent>((event, emit) {
      // emit(itemTileLoaded(snapshot.data!.docs[]['namaProduk']));
    });
  }
}