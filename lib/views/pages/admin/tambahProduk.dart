// import 'package:ebusiness_atk_mobile/views/components/textField.dart';
import 'dart:developer';
import 'dart:io';
import 'package:ebusiness_atk_mobile/bloc/form/form_bloc.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_dropdownButton.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_snackbar.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_textField_controller.dart';
// import 'package:ebusiness_atk_mobile/features/form-validation/bloc/form_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
// import 'package:ebusiness_atk_mobile/views/components/preset_textField.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:image_picker/image_picker.dart';

// import '../home.dart';
import '/views/components/custom_button.dart';
import '/views/components/preset_textField.dart';

// end of undo
class tambahProduk extends StatelessWidget {
  final String? status;
  tambahProduk({this.status});
  // const tambahProduk({Key? key}) : super(key: key);

  // File? image;
  // String imagePath = '';
  // XFile? imagePicked;

  // Color currentNamaProdukTextFieldOutlineColor = Colors.black;
  // Color currentMerekProdukTextFieldOutlineColor = Colors.black;
  // Color currentDropdownOutlineColor = Colors.black;
  // Color currentJumlahStokTextFieldOutlineColor = Colors.black;
  // Color currentHargaTextFieldOutlineColor = Colors.black;
  // Color currentImageBoxBorderColor = Colors.black;

  // double currentNamaProdukTextFieldOutlineWidth = 1;
  // double currentMerekProdukTextFieldOutlineWidth = 1;
  // double currentDropdownOutlineWidth = 1;
  // double currentJumlahStokTextFieldOutlineWidth = 1;
  // double currentHargaTextFieldOutlineWidth = 1;
  // double currentImageBoxBorderWidth = 1;

  // String currentDropdownValue = "0";
  // String currentDropdownValueID = "";

  @override
  Widget build(BuildContext context) {
    context.read<FormBloc>().add(ProdukDataFetched()); 
    log("this message at second line below builder widget");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tambahkan Produk"),
      ),
      body: ListView(
        children: [
          // ListView(
          //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          //   children: [
          //   ],
          // )
          MultiBlocListener(
            listeners: [
              BlocListener<FormBloc, FormsValidate>(
                // listenWhen: (_, current) { if (current == 1) return true; print("current: $current");return false;},
                // listenWhen: (previous, current) => true,
                listener: (context, state) {
                  // if (status == "add") context.read<FormBloc>().add(ValueReset());
                  if (state.isFormValidateFailed) {
                    PresetSnackbar(context: context, message: "Kesalahan! Ada kolom formulir yang belum valid.");
                    context.read<FormBloc>().add(FormFailed());
                  }
                  log("this is bloc listener");
                }
              ), 
            ],
            child: BlocBuilder<FormBloc, FormsValidate>(
              builder: (context, state) {
                //gambarProduk
                PresetTextFieldController hargaController = PresetTextFieldController(value: state.hargaDisplay);
                PresetTextFieldController jumlahStokController = PresetTextFieldController(value: state.jumlahStokDisplay);
                // if (state.kategoriProdukDropdownItems!.isEmpty) {log("this a work"); context.read<FormBloc>().add(KategoriProdukDropdownItemsFetched()); }
                PresetTextFieldController merekProdukController = PresetTextFieldController(value: state.merekProduk);
                PresetTextFieldController namaProdukController = PresetTextFieldController(value: state.namaProduk);
                log("this is bloc builder");

                // if (state.gambarProdukSelected != null && state.gambarProdukUploaded == "") {
                //   log("(state.gambarProdukSelected != null && state.gambarProdukUploaded == ""): ${(state.gambarProdukSelected != null && state.gambarProdukUploaded == '')}");
                //   log("(state.gambarProdukSelected != null): ${(state.gambarProdukSelected != null)}");
                //   log("(state.gambarProdukSelected == null): ${(state.gambarProdukSelected == null)}");
                //   log("state.gambarProdukUploaded == '': ${(state.gambarProdukUploaded == '')}");
                //   log("(state.gambarProdukSelected.toString(): ${(state.gambarProdukSelected.toString())}");
                // }

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: (state.isImageValid) ? Colors.black : Colors.red.shade700,
                              // width: (state.isImageValid)? 1 : 2
                            ),
                            borderRadius: BorderRadius.circular(5),
                            // image: image supposed to be here
                            // image: DecorationImage(image: AssetImage('assetName.jpg'))
                          ),
                          // child: (image != null) ? Image.file(image!, fit: BoxFit.cover) : Text(""),
                          child: Column(
                            children: [
                              // if (state.gambarProdukSelected != null && state.gambarProdukUploaded == "") Image.file(state.gambarProdukSelected!, fit: BoxFit.cover) 
                              if (state.gambarProdukSelected!.path.isNotEmpty && state.gambarProdukUploaded == "") Image.file(state.gambarProdukSelected!, fit: BoxFit.cover) 
                              else if (state.gambarProdukUploaded != "") Image.network(state.gambarProdukUploaded, fit: BoxFit.cover)
                              else Text(""),
                            ]
                          )
                          // child: Image.network(src)
                          // child: test()
                        )
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            if (state.isImageValid == false) Column(
                              children: [
                                Text(
                                  "Gambar harus dipilih!",
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 12
                                  )
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 15)),
                              ],
                            ),
                            CustomButton(
                              color: Colors.grey.shade300,
                              // onTap: () async {
                              onTap: () {
                                // await getImage();
                                context.read<FormBloc>().add(SelectImagePressed());
                              },
                              text: "Pilih Gambar Produk",
                            ),
                          ],
                        ),
                      ],
                    ),
                    PresetTextField(
                      labelText: "Nama Produk",
                      controller: namaProdukController.getController,  // tadinya digunakan untuk input data ke firestore, namun nanti tidak akan pakai ini kecuali untuk clear data setelah submit.
                      fieldOnChanged: (value) => context.read<FormBloc>().add(NamaProdukChanged(value)),
                      errorText: (state.isNamaProdukValid == false)
                      ? 'Nama produk tidak boleh kosong!'
                      : null,
                    ),
                    PresetTextField(
                      labelText: "Merek Produk",
                      controller: merekProdukController.getController,
                      fieldOnChanged: (value) => context.read<FormBloc>().add(MerekProdukChanged(value)),
                      errorText: (state.isMerekProdukValid == false)
                      ? 'Merek produk tidak boleh kosong!'
                      : null,
                    ),
                    PresetDropdownButton(
                      // currentDropdownValue: (state.kategoriProdukDropdownItems!.isEmpty)? null : state.kategoriProdukDropdownItems![0].id,
                      currentDropdownValue: state.kategoriProduk,
                      labelText: "Kategori Produk", 
                      onChanged: (value) => context.read<FormBloc>().add(KategoriProdukChanged(value.toString())),
                      errorText: (state.isKategoriProdukValid == false)
                      ? 'Kategori produk belum dipilih!'
                      : null,
                      items: state.kategoriProdukDropdownItems!,
                      itemValue: "id",
                      itemText: "kategori"
                    ),
                    PresetTextField(
                      keyboardType: TextInputType.number,
                      labelText: "Jumlah Stok",
                      controller: jumlahStokController.getController,
                      fieldOnChanged: (value) => context.read<FormBloc>().add(JumlahStokChanged(value)),
                      errorText: (state.isJumlahStokValid == false)
                      ? state.jumlahStokErrorMessage
                      : null,
                    ),
                    PresetTextField(
                      keyboardType: TextInputType.number,
                      labelText: "Harga",
                      controller: hargaController.getController,
                      fieldOnChanged: (value) => context.read<FormBloc>().add(HargaChanged(value)),
                      errorText: (state.isHargaValid == false)
                      ? state.hargaErrorMessage
                      : null,
                    ),
                  ],
                );
              },
            )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                color: Colors.greenAccent.shade400,
                text: "Tambah",
                onTap: () => context.read<FormBloc>().add(FormSubmitted(context: context)),
                // onTap: () async {
                //   if (currentDropdownValue == '0' || namaProdukController.text == '' || merekProdukController.text == '' || jumlahStokController.text == '' || hargaController.text == '' || image == null) {
                //     setState(() {
                //       if (currentDropdownValue == '0') {
                //         unselectedDropdownState();
                //       }
                //       if (namaProdukController.text == '') {
                //         currentNamaProdukTextFieldOutlineColor = Colors.redAccent;
                //         currentNamaProdukTextFieldOutlineWidth = 2;
                //       } else {
                //         currentNamaProdukTextFieldOutlineColor = Colors.black;
                //         currentNamaProdukTextFieldOutlineWidth = 1;
                //       }
                //       if (merekProdukController.text == '') {
                //         currentMerekProdukTextFieldOutlineColor = Colors.red;
                //         currentMerekProdukTextFieldOutlineWidth = 2;
                //       } else {
                //         currentMerekProdukTextFieldOutlineColor = Colors.black;
                //         currentMerekProdukTextFieldOutlineWidth = 1;
                //       }
                //       if (jumlahStokController.text == '') {
                //         currentJumlahStokTextFieldOutlineColor = Colors.red;
                //         currentJumlahStokTextFieldOutlineWidth = 2;
                //       } else {
                //         currentJumlahStokTextFieldOutlineColor = Colors.black;
                //         currentJumlahStokTextFieldOutlineWidth = 1;
                //       }
                //       if (hargaController.text == '') {
                //         currentHargaTextFieldOutlineColor = Colors.red;
                //         currentHargaTextFieldOutlineWidth = 2;
                //       } else {
                //         currentHargaTextFieldOutlineColor = Colors.black;
                //         currentHargaTextFieldOutlineWidth = 1;
                //       }
                //       if (image == null) {
                //         currentImageBoxBorderColor = Colors.red;
                //         currentImageBoxBorderWidth = 2;
                //       } else {
                //         currentImageBoxBorderColor = Colors.black;
                //         currentImageBoxBorderWidth = 1;
                //       }
                //     });
                //     print("- - fail to submit");
                //   } else {
                //     produk_atk.add({
                //       'namaProduk': namaProdukController.text,
                //       'merekProduk': merekProdukController.text,
                //       // 'kategoriProduk': kategoriProdukController.text,
                //       'kategoriProduk': currentDropdownValue,
                //       'jumlahStok': int.parse(jumlahStokController.text),
                //       'harga': int.parse(hargaController.text),
                //       'gambarProduk': basename(image!.path)
                //     });

                //     print('namaProduk:' + namaProdukController.text);
                //     print('merekProduk:' + merekProdukController.text);
                //     // print('kategoriProduk:'+ kategoriProdukController.text);
                //     print('kategoriProduk:' + currentDropdownValue);
                //     print('jumlahStok:' + jumlahStokController.text);
                //     print('harga:' + hargaController.text);
                //     print('gambarProduk:' + basename(image!.path));

                //     namaProdukController.text = '';
                //     merekProdukController.text = '';
                //     kategoriProdukController.text = '';
                //     jumlahStokController.text = '';
                //     hargaController.text = '';

                //     // imagePath = await uploadImage(imagePicked);
                //     uploadImage(context);
                //     // image = null;

                //     print("- - Submitted");

                //     showDialog<String>(
                //       context: context,
                //       builder: (BuildContext context) => AlertDialog(
                //         title: const Text('Informasi'),
                //         content: const Text('Data produk berhasil ditambahkan.'),
                //         actions: <Widget>[
                //           TextButton(
                //             onPressed: () => Navigator.pop(context, 'OK'),
                //             child: const Text('OK'),
                //           ),
                //         ],
                //       ),
                //     );
                //   }
                // },
              ),
            ],
          )
        ],
      )
    );
  }

  // test() {

  // }

  // Future getImage() async {
  //   // await ImagePicker().pickImage(source: ImageSource.gallery);
  //   final picker = ImagePicker();
  //   final imagePicked = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (imagePicked != null) {  // if file manager opened and picked any image (not canceled)
  //       // image = File(imagePicked!.path);
  //       image = File(imagePicked.path);
  //       print("- - image path: " + imagePicked.path);
  //     }
  //   });
  //   return imagePicked;
  // }

  // Future<XFile?> getImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   image = File(imagePicked!.path);
  //   setState(() {});
  //   return await _picker.pickImage(source: ImageSource.gallery);
  // }

  // Future uploadImage(File imageFile) async {
  //   String fileName = basename(imageFile.path);

  //   Reference ref = FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask task = ref.putFile(imageFile);
  //   TaskSnapshot snapshot = await task;

  //   return await snapshot.ref.getDownloadURL();
  // }

  // Future getImageFileName(BuildContext context) async {
  //   return basename(image!.path);
  // }

  // Future uploadImage(BuildContext context) async {
  //   String fileName = basename(image!.path);

  //   Reference ref = FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask task = ref.putFile(image!);
  //   TaskSnapshot snapshot = await task;

  //   return await snapshot.ref.getDownloadURL();
  // }
}





