import 'dart:developer';

import 'dart:io';

import 'package:ebusiness_atk_mobile/models/produk_model.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_popUpAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '/models/kategoriProduk_model.dart';
import '/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

// import 'dart:developer';

import 'package:image_picker/image_picker.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormsValidate> {
  final DatabaseRepository _databaseRepository;
  // String imagePath = '';

  FormBloc(this._databaseRepository) : super(FormsValidate(
    email: "", 
    formStatus: Status.add,
    // gambarProdukSelected: null,
    gambarProdukSelected: File(''),
    gambarProdukUploaded: "",
    harga: 0,
    hargaDisplay: "",
    hargaErrorMessage: "",
    idProduk: "",
    jumlahStok: 0,
    jumlahStokDisplay: "",
    jumlahStokErrorMessage: "",
    kategoriProduk: "0",
    kategoriProdukDropdownItems: [],
    merekProduk: "",
    namaProduk: "",
    password: "", 
    isEmailValid: false,        // untuk sign in/up
    // isProdukFormValid: false,
    isHargaChanged: false,
    isHargaValid: true,
    isImageValid: true,
    isJumlahStokChanged: false,
    isJumlahStokValid: true,
    isKategoriProdukValid: true,
    isMerekProdukValid: true,
    isNamaProdukValid: true,
    isPasswordValid: false,       // untuk sign in/up
    isLoading: false,             // 
    isNameValid: false,           // untuk sign up
    isFormValidateFailed: false,  // 
  )) {
    // on<NamaProdukChanged>(_onNamaProdukChanged);
    // on<MerekProdukChanged>(_onMerekProdukChanged);

    log("Form Bloc is start running in the background");

    on<FormFailed>(
      (event, emit) {
        emit(state.currentValue(isFormValidateFailed: false));
      }
    );

    on<FormSubmitted>(
      (event, emit) async {
        if (state.harga == 0 || (state.formStatus == Status.add && state.gambarProdukSelected!.path.isEmpty) || (state.formStatus == Status.edit && state.gambarProdukUploaded.isEmpty) || state.jumlahStok == 0 || state.kategoriProduk == "0" || state.merekProduk == "" || state.namaProduk == "") {
          if (state.harga == 0) _getHargaErrorMessage("", emit);
          if (state.formStatus == Status.add) {
            if (state.gambarProdukSelected!.path.isEmpty) emit(state.currentValue(isImageValid: false));
          } else if (state.formStatus == Status.edit) {
            if (state.gambarProdukUploaded.isEmpty) emit(state.currentValue(isImageValid: false));
          }
          if (state.jumlahStok == 0) _getJumlahStokErrorMessage("", emit);
          if (state.kategoriProduk == "0") emit(state.currentValue(isKategoriProdukValid: false));
          if (state.merekProduk == "") emit(state.currentValue(isMerekProdukValid: false));
          if (state.namaProduk == "") emit(state.currentValue(isNamaProdukValid: false));
          emit(state.currentValue(isFormValidateFailed: true)); //call snackbar information
        } else {
          log("Persyaratan Form telah terpenuhi.");
          //then call method ...

          final pastUploadedImageURL = state.gambarProdukUploaded;

          ProdukModel produkData = ProdukModel(
            harga: state.harga,
            // gambarProduk: DateFormat('dd-MM-yyyy-kkmm-').format(DateTime.now()) + basename(state.gambarProdukSelected!.path),
            // gambarProduk: gambarProdukTelahDiupload.toString(),
            // gambarProduk: await uploadedImageURL,
            jumlahStok: state.jumlahStok,
            kategoriProduk: state.kategoriProduk,
            merekProduk: state.merekProduk,
            namaProduk: state.namaProduk
          );

          // if (state.gambarProdukSelected != null) {
          if (state.gambarProdukSelected!.path.isNotEmpty) {
            final uploadedImageURL = _databaseRepository.saveFile(state.gambarProdukSelected);

            produkData.gambarProduk = await uploadedImageURL;
          } //else if (pastUploadedImageURL.isNotEmpty) pastUploadedImageURL = state.gambarProdukUploaded;
          
          if (state.formStatus == Status.add) {
            _databaseRepository.saveProdukData = produkData;

            PresetPopUpAlert(
              context: event.context, 
              description: "Data produk berhasil ditambahkan",
              title: "Informasi",
              firstActionButtonText: "OK",
              // firstActionButton: () => _onValueReset(event, emit),
              // firstActionButton: () => log("ok button pressed"),
            );

            //hapus di form field
            _onValueReset(event, emit);
          } else if (state.formStatus == Status.edit) {
            // if (state.gambarProdukSelected != null) {
            if (state.gambarProdukSelected!.path.isNotEmpty) {
              _databaseRepository.editProdukData(pastUploadedImageURL, produkData, state.idProduk);
              emit(state.currentValue(gambarProdukUploaded: produkData.gambarProduk));
            }
            else _databaseRepository.editProdukData("", produkData, state.idProduk);
            PresetPopUpAlert(
              context: event.context, 
              description: "Data produk berhasil diubah",
              title: "Informasi",
              firstActionButtonText: "OK"
            );
          }
          //this _onValueReset(event, emit);

          // log("state.gambarProduk: ${state.gambarProduk}"); 
          // log("state.gambarProduk!.path: ${state.gambarProduk!.path}"); 
          // log("basename(state.gambarProduk!.path): ${basename(state.gambarProduk!.path)}"); 
          // log("_databaseRepository.saveFile(state.gambarProduk): ${_databaseRepository.saveFile(state.gambarProduk)}");
          // log("_databaseRepository.saveFile(state.gambarProduk).toString(): ${_databaseRepository.saveFile(state.gambarProduk).toString()}");

          // state.gambarProduk!.path = DateFormat('dd-MM-yyyy–kkmm-').format(DateTime.now()) + basename(state.gambarProduk!.path);
          // log("_databaseRepository.saveFile(DateFormat('dd-MM-yyyy–kkmm-').format(DateTime.now()) + basename(state.gambarProduk!.path)): ${_databaseRepository.saveFile(DateFormat('dd-MM-yyyy–kkmm-').format(DateTime.now()) + basename(state.gambarProduk!.path))}");


          // image get date time now + get image
          
          // produk_atk.add({
          //   'gambarProduk': basename(image!.path)
          //   'harga': state.harga,
          //   'jumlahStok': state.jumlah,
          //   'kategoriProduk': state.kategoriProduk,
          //   'merekProduk': state.merekProduk,
          //   'namaProduk': state.namaProduk,
          // });

          // // imagePath = await uploadImage(imagePicked);
          // uploadImage(context);
          // // image = null;

          // emit(
          //   state.currentValue(
          //     harga: _getIntValue(event.harga),
          //     hargaErrorMessage: _getHargaErrorMessage(event.harga),
          //     isHargaChanged: true,
          //     isHargaValid: _isFieldNotEmpty(event.harga.toString()), 
          //   )
          // );

          // print("- - Submitted");

          // showDialog<String>(
          //   context: context,
          //   builder: (BuildContext context) => AlertDialog(
          //     title: const Text('Informasi'),
          //     content: const Text('Data produk berhasil ditambahkan.'),
          //     actions: <Widget>[
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'OK'),
          //         child: const Text('OK'),
          //       ),
          //     ],
          //   ),
          // );
        }
      }
    );

    on<HargaChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            harga: _getIntValue(event.harga),
            isHargaChanged: true,
          )
        );

        _getHargaErrorMessage(event.harga, emit);
      }
    );

    on<JumlahStokChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            jumlahStok: _getIntValue(event.jumlahStok),
            isJumlahStokChanged: true,
          )
        );

        _getJumlahStokErrorMessage(event.jumlahStok, emit);
      }
    );

    on<KategoriProdukChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            kategoriProduk: event.kategoriProduk,
            isKategoriProdukValid: _isCurrentDropdownValueNotDefault(event.kategoriProduk),
          )
        );
      }
    );

    on<KategoriProdukDropdownItemsFetched>(_onKategoriProdukDropdownItemsFetched);    

    on<MerekProdukChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            merekProduk: event.merekProduk,
            isMerekProdukValid: _isFieldNotEmpty(event.merekProduk),
          )
        );
      }
    );

    on<NamaProdukChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            namaProduk: event.namaProduk,
            isNamaProdukValid: _isFieldNotEmpty(event.namaProduk),
          )
        );
      }
    );

    on<ProdukDataFetched>(
      (event, emit) async {
        // final Future<ProdukModel> ProdukData -- Error: A value of type 'ProdukModel' can't be assigned to a variable of type 'Future<ProdukModel>'.
        // final Future ProdukData -- Error: A value of type 'ProdukModel' can't be assigned to a variable of type 'Future<dynamic>'.

        if (state.kategoriProdukDropdownItems!.isEmpty) await _onKategoriProdukDropdownItemsFetched(event, emit);
        if (event.documentID.isEmpty) {
          _onValueReset(event, emit);
        } else {
          final ProdukData = await _databaseRepository.retrieveSpecificProduk(event.documentID);
          emit(
            state.currentValue(
              idProduk: event.documentID,
              formStatus: Status.edit,
              gambarProdukUploaded: ProdukData.gambarProduk,
              harga: ProdukData.harga,
              hargaDisplay: ProdukData.harga.toString(),
              jumlahStok: ProdukData.jumlahStok,
              jumlahStokDisplay: ProdukData.jumlahStok.toString(),
              kategoriProduk: ProdukData.kategoriProduk,
              merekProduk: ProdukData.merekProduk,
              namaProduk: ProdukData.namaProduk
            )
          );
        }
      },
    );

    on<SelectImagePressed>(
      (event, emit) async {
        emit(
          state.currentValue(
            gambarProdukSelected: await _getImage(emit),
            isImageValid: true
          )
        );
        log("state.image.toString() : ${state.gambarProdukSelected.toString()}");
        if (state.gambarProdukSelected!.path.isEmpty) emit(
          state.currentValue(
            isImageValid: false
          )
        );
      }
    );
    
    on<ValueReset>(_onValueReset);
  }

  _getHargaErrorMessage(String harga, Emitter<FormsValidate> emit) {
    if (harga == "") {
      emit(
        state.currentValue(
          hargaDisplay: harga,
          hargaErrorMessage: "Harga tidak boleh kosong!",
          isHargaValid: false
        )
      );
    } else if (_getIntValue(harga) == 0) {
      emit(
        state.currentValue(
          hargaDisplay: state.harga.toString(),
          hargaErrorMessage: "Harga tidak boleh bernilai 0!",
          isHargaValid: false
        )
      );
    } else if (_getIntValue(harga) > 0 && _getIntValue(harga) < 100) {
      emit(
        state.currentValue(
          hargaDisplay: state.harga.toString(),
          hargaErrorMessage: "Harga harus di atas Rp.100,- !",
          isHargaValid: false
        )
      );
    } else {
      emit(
        state.currentValue(
          hargaDisplay: state.harga.toString(),
          isHargaValid: true
        )
      );
    }
  }

  Future _getImage(Emitter<FormsValidate> emit) async {
    // await ImagePicker().pickImage(source: ImageSource.gallery);
    final picker = ImagePicker();
    final imagePicked = await picker.pickImage(source: ImageSource.gallery);
    File? image = null;
    // XFile? imagePicked;

    // setState(() {
      if (imagePicked != null) {  // if file manager opened and picked any image (not canceled)
        // image = File(imagePicked!.path);
        image = File(imagePicked.path);
        print("- - image path: " + imagePicked.path);
      }
    // });
    return image;
  }

  // Future _getImageFileName() async {
  //   return basename(image!.path);
  // }

  // String _getHargaErrorMessage(String harga) {
  //   if (harga == "") {log("first"); return "Harga tidak boleh kosong!";}
  //   else if (_getIntValue(harga) == 0) {log("second"); return "Harga tidak boleh bernilai 0!";}
  //   else if (_getIntValue(harga) > 0 && _getIntValue(harga) < 100) {log("third"); return "Harga harus di atas Rp.100,- !";}
  //   else {log("fourth"); return "";}
  // }

  int _getIntValue(String stringValue) {
    if (stringValue == "") return 0;
    else return int.parse(stringValue);
  }

  _getJumlahStokErrorMessage(String jumlahStok, Emitter<FormsValidate> emit) {
    if (jumlahStok == "") {
      emit(
        state.currentValue(
          jumlahStokDisplay: jumlahStok,
          jumlahStokErrorMessage: "Jumlah stok tidak boleh kosong!",
          isJumlahStokValid: false
        )
      );
    } else if (_getIntValue(jumlahStok) == 0) {
      emit(
        state.currentValue(
          jumlahStokDisplay: state.jumlahStok.toString(),
          jumlahStokErrorMessage: "Jumlah stok tidak boleh bernilai 0!",
          isJumlahStokValid: false
        )
      );
    } else {
      emit(
        state.currentValue(
          jumlahStokDisplay: state.jumlahStok.toString(),
          isJumlahStokValid: true
        )
      );
    }
  }

  bool _isCurrentDropdownValueNotDefault(String id) {
    String defaultValue = "0";
    return (id == defaultValue)? false : true;
  }

  bool _isFieldNotEmpty(String? fieldValue) {
    return fieldValue!.isNotEmpty;
  }

  // Future _uploadImage(File? image) async {
  //   String fileName = basename(image!.path);

  //   Reference ref = FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask task = ref.putFile(image!);
  //   TaskSnapshot snapshot = await task;

  //   return await snapshot.ref.getDownloadURL();
  // }

  // _onKategoriProdukDropdownItemsFetched(KategoriProdukDropdownItemsFetched event, Emitter<FormsValidate> emit) async {
  _onKategoriProdukDropdownItemsFetched(event, Emitter<FormsValidate> emit) async {
    List<KategoriProdukModel> listofKategoriProduk = await _databaseRepository.retrieveKategoriProduk();
    emit(
      state.currentValue(
        kategoriProdukDropdownItems: listofKategoriProduk
      )
    );
  }

  _onValueReset(event, emit) { // back to default value
    log("[form_bloc] [before] state.gambarProdukSelected.toString(): ${state.gambarProdukSelected.toString()}");
    log("[form_bloc] [before] state.gambarProdukSelected!.path.isEmpty: ${state.gambarProdukSelected!.path.isEmpty}");
    emit(
      state.currentValue(
        email: "", 
        formStatus: Status.add,
        // gambarProdukSelected: null,
        gambarProdukSelected: File(''),
        gambarProdukUploaded: "",
        harga: 0,
        hargaDisplay: "",
        hargaErrorMessage: "",
        idProduk: "",
        jumlahStok: 0,
        jumlahStokDisplay: "",
        jumlahStokErrorMessage: "",
        kategoriProduk: "0",
        // kategoriProdukDropdownItems: [],
        merekProduk: "",
        namaProduk: "",
        isHargaChanged: false,
        isHargaValid: true,
        isImageValid: true,
        isJumlahStokChanged: false,
        isJumlahStokValid: true,
        isKategoriProdukValid: true,
        isMerekProdukValid: true,
        isNamaProdukValid: true,
        isLoading: false,             // 
        isFormValidateFailed: false,  // 
      )
    );
    log("[form_bloc] [after] state.gambarProdukSelected.toString(): ${state.gambarProdukSelected.toString()}");
    log("[form_bloc] [after] state.gambarProdukSelected!.path.isEmpty: ${state.gambarProdukSelected!.path.isEmpty}");
  }

  // Future<String> test() {
  //   return null as Future<String>;
  // }
}
