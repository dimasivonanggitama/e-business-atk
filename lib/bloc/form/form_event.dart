part of 'form_bloc.dart';

enum Status { add, edit }

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class FormSubmitted extends FormEvent {
  // final Status value;
  BuildContext context;
  // const FormSubmitted({required this.value});
  FormSubmitted({required this.context});

  @override
  // List<Object> get props => [value];
  List<Object> get props => [];
}

class FormFailed extends FormEvent {

  @override
  List<Object> get props => [];
}

class HargaChanged extends FormEvent {
  final String harga;
  const HargaChanged(this.harga);

  @override
  List<Object> get props => [harga];
}

class JumlahStokChanged extends FormEvent {
  final String jumlahStok;
  const JumlahStokChanged(this.jumlahStok);

  @override
  List<Object> get props => [jumlahStok];
}

class KategoriProdukDropdownItemsFetched extends FormEvent {
  
  @override
  List<Object> get props => [];
}

class KategoriProdukChanged extends FormEvent {
  final String kategoriProduk;
  const KategoriProdukChanged(this.kategoriProduk);

  @override
  List<Object> get props => [kategoriProduk];
}

class MerekProdukChanged extends FormEvent {
  final String merekProduk;
  const MerekProdukChanged(this.merekProduk);

  @override
  List<Object> get props => [merekProduk];
}

class NamaProdukChanged extends FormEvent {
  final String namaProduk;
  const NamaProdukChanged(this.namaProduk);

  @override
  List<Object> get props => [namaProduk];
}

class SelectImagePressed extends FormEvent {

  @override
  List<Object> get props => [];
}

class ProdukDataFetched extends FormEvent {
  final String documentID;
  const ProdukDataFetched({this.documentID = ""});

  @override
  List<Object> get props => [documentID];
}

class ValueReset extends FormEvent {

  @override
  List<Object> get props => [];
}