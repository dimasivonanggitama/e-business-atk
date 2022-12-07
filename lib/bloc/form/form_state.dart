part of 'form_bloc.dart';

abstract class FormState extends Equatable {
  const FormState();
}

class FormInitial extends FormState {
  @override
  List<Object?> get props => [];
}

class FormsValidate extends FormState {
  const FormsValidate({
    required this.email,
    required this.formStatus,
    required this.gambarProdukSelected,
    required this.gambarProdukUploaded,
    required this.harga,
    required this.hargaDisplay,
    required this.hargaErrorMessage,
    required this.idProduk,
    required this.jumlahStok,
    required this.jumlahStokDisplay,
    required this.jumlahStokErrorMessage,
    required this.kategoriProduk,
    required this.kategoriProdukDropdownItems,
    required this.merekProduk,
    required this.namaProduk,
    required this.password,
    required this.isEmailValid,
    required this.isHargaChanged,
    required this.isHargaValid,
    required this.isImageValid,
    required this.isJumlahStokChanged,
    required this.isJumlahStokValid,
    required this.isKategoriProdukValid,
    required this.isMerekProdukValid,
    required this.isNamaProdukValid,
    required this.isPasswordValid,
    // required this.isFormValid, // cuma untuk trigger vefikasi email dengan cara link yang dikirim ke email tsb.
    required this.isLoading,
    this.errorMessage = "",
    required this.isNameValid,
    // required this.isAgeValid,
    required this.isFormValidateFailed,
    this.displayName,
    // required this.age,
    this.isFormSuccessful = false,
  });

  final String email;
  final int harga;
  final File? gambarProdukSelected;
  final String gambarProdukUploaded;
  final String hargaDisplay;
  final String hargaErrorMessage;
  final String idProduk;
  final int jumlahStok;
  final String jumlahStokDisplay;
  final String jumlahStokErrorMessage;
  final String kategoriProduk;
  final List<KategoriProdukModel>? kategoriProdukDropdownItems;
  final String merekProduk;
  final String namaProduk;
  final Status formStatus;
  final String? displayName;
  // final int age;
  final String password;
  final bool isEmailValid;
  final bool isHargaChanged;
  final bool isHargaValid;
  final bool isImageValid;
  final bool isJumlahStokChanged;
  final bool isJumlahStokValid;
  final bool isKategoriProdukValid;
  final bool isMerekProdukValid;
  final bool isNamaProdukValid;
  final bool isPasswordValid;
  // final bool isFormValid;
  final bool isNameValid;
  // final bool isAgeValid;
  final bool isFormValidateFailed;
  final bool isLoading;
  final String errorMessage;
  final bool isFormSuccessful;

  FormsValidate currentValue({    
    String? email,
    Status? formStatus,
    File? gambarProdukSelected,
    String? gambarProdukUploaded,
    int? harga,
    String? hargaDisplay,
    String? hargaErrorMessage,
    String? idProduk,
    int? jumlahStok,
    String? jumlahStokDisplay,
    String? jumlahStokErrorMessage,
    String? kategoriProduk,
    List<KategoriProdukModel>? kategoriProdukDropdownItems,
    String? merekProduk,
    String? namaProduk,
    String? password,
    String? displayName,
    bool? isEmailValid,
    bool? isHargaChanged,
    bool? isHargaValid,
    bool? isImageValid,
    bool? isJumlahStokChanged,
    bool? isJumlahStokValid,
    bool? isKategoriProdukValid,
    bool? isMerekProdukValid,
    bool? isPasswordValid,
    // bool? isFormValid,
    bool? isLoading,
    // int? age,
    String? errorMessage,
    bool? isNameValid,
    // bool? isAgeValid,
    bool? isFormValidateFailed,
    bool? isFormSuccessful,
    bool? isNamaProdukValid
  }) {
    return FormsValidate(
      email: email ?? this.email,
      formStatus: formStatus ?? this.formStatus,
      gambarProdukSelected: gambarProdukSelected ?? this.gambarProdukSelected,
      gambarProdukUploaded: gambarProdukUploaded ?? this.gambarProdukUploaded,
      harga: harga ?? this.harga,
      hargaDisplay: hargaDisplay ?? this.hargaDisplay,
      hargaErrorMessage: hargaErrorMessage ?? this.hargaErrorMessage,
      idProduk: idProduk ?? this.idProduk,
      jumlahStok: jumlahStok ?? this.jumlahStok,
      jumlahStokDisplay: jumlahStokDisplay ?? this.jumlahStokDisplay,
      jumlahStokErrorMessage: jumlahStokErrorMessage ?? this.jumlahStokErrorMessage,
      kategoriProduk: kategoriProduk ?? this.kategoriProduk,
      kategoriProdukDropdownItems: kategoriProdukDropdownItems ?? this.kategoriProdukDropdownItems,
      merekProduk: merekProduk ?? this.merekProduk,
      namaProduk: namaProduk ?? this.namaProduk,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isHargaChanged: isHargaChanged ?? this.isHargaChanged,
      isHargaValid: isHargaValid ?? this.isHargaValid,
      isImageValid: isImageValid ?? this.isImageValid,
      isJumlahStokChanged: isJumlahStokChanged ?? this.isJumlahStokChanged,
      isJumlahStokValid: isJumlahStokValid ?? this.isJumlahStokValid,
      isKategoriProdukValid: isKategoriProdukValid ?? this.isKategoriProdukValid,
      isMerekProdukValid: isMerekProdukValid ?? this.isMerekProdukValid,
      isNamaProdukValid: isNamaProdukValid ?? this.isNamaProdukValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      // isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isNameValid: isNameValid ?? this.isNameValid,
      // age: age ?? this.age,
      // isAgeValid: isAgeValid ?? this.isAgeValid,
      displayName: displayName ?? this.displayName,
      isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
      isFormSuccessful: isFormSuccessful ?? this.isFormSuccessful,
    );
  }

  @override
  List<Object?> get props => [
    email,
    formStatus,
    gambarProdukSelected,
    gambarProdukUploaded,
    harga,
    hargaDisplay,
    hargaErrorMessage,
    idProduk,
    jumlahStok,
    jumlahStokDisplay,
    jumlahStokErrorMessage,
    kategoriProduk,
    merekProduk,
    namaProduk,
    password,

    isEmailValid,
    isPasswordValid,
    // isFormValid,
    isLoading,
    errorMessage,
    isNameValid,
    displayName,
    // age,
    isFormValidateFailed,
    isFormSuccessful,

    isHargaChanged,
    isHargaValid,
    isImageValid,
    isJumlahStokChanged,
    isJumlahStokValid,
    isKategoriProdukValid,
    isMerekProdukValid,
    isNamaProdukValid
  ];
}