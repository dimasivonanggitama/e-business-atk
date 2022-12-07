// import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

enum produkFormFieldEvent {toTambah, toUpdate}

class produkFormFieldBloc extends Bloc<produkFormFieldEvent, String> {
  produkFormFieldBloc(String initialState) : super(initialState);
  
  Stream<String> mapEventToState(produkFormFieldBloc event) async* {
    yield (event == produkFormFieldEvent.toTambah)? "Tambah Produk" : (event == produkFormFieldEvent.toUpdate)? "Update Produk" : "(?)";
    // yield (event == produkFormFieldEvent.toTambah)? "Tambah Produk" : (event == produkFormFieldEvent.toUpdate)? "Update Produk" : "(?)";

  // String button = "Update";
  
  
  }
}