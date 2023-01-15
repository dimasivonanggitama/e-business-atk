import '/views/components/preset_dropdownButton.dart';
import '/views/components/preset_snackbar.dart';
import '/views/components/preset_textField_controller.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../bloc/form/product_form/product_form_bloc.dart';
import '/views/components/custom_button.dart';
import '/views/components/preset_textField.dart';

class tambahProduk extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    context.read<ProductFormBloc>().add(ProductDataFetched());
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductFormBloc, FormInitial>(
          listener: (context, state) {
            if (state.isFormValidateFailed) {
              PresetSnackbar(context: context, message: "Kesalahan! Ada kolom formulir yang belum valid.");
              context.read<ProductFormBloc>().add(FormFailed());
            }
          }
        ), 
      ],
      child: BlocBuilder<ProductFormBloc, FormInitial>(
        builder: (context, state) {
          PresetTextFieldController hargaController = PresetTextFieldController(value: state.priceDisplay);
          PresetTextFieldController jumlahStokController = PresetTextFieldController(value: state.stockQuantityDisplay);
          PresetTextFieldController merekProdukController = PresetTextFieldController(value: state.brand);
          PresetTextFieldController namaProdukController = PresetTextFieldController(value: state.name);

                // if (state.gambarProdukSelected != null && state.gambarProdukUploaded == "") {
                //   log("(state.gambarProdukSelected != null && state.gambarProdukUploaded == ""): ${(state.gambarProdukSelected != null && state.gambarProdukUploaded == '')}");
                //   log("(state.gambarProdukSelected != null): ${(state.gambarProdukSelected != null)}");
                //   log("(state.gambarProdukSelected == null): ${(state.gambarProdukSelected == null)}");
                //   log("state.gambarProdukUploaded == '': ${(state.gambarProdukUploaded == '')}");
                //   log("(state.gambarProdukSelected.toString(): ${(state.gambarProdukSelected.toString())}");
                // }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text((state.formStatus == Status.add)? "Tambahkan Produk" : "Ubah produk"),
            ),
            body: ListView(
              children: [                
                Column(
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
                            ),
                            borderRadius: BorderRadius.circular(5),
                            // image: image supposed to be here
                            // image: DecorationImage(image: AssetImage('assetName.jpg'))
                          ),
                          child: Column(
                            children: [
                              // if (state.imageSelected!.path.isNotEmpty && state.imageUploaded == "") Image.file(state.imageSelected!, fit: BoxFit.cover) 
                              if (state.imageSelected!.path.isNotEmpty) Image.file(state.imageSelected!, fit: BoxFit.cover) 
                              else if (state.imageUploaded.isNotEmpty) Image.network(state.imageUploaded, fit: BoxFit.cover)
                              else Text(""), // for add product
                            ]
                          )
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
                              onTap: () => context.read<ProductFormBloc>().add(SelectImagePressed()),
                              text: "Pilih Gambar Produk",
                            ),
                          ],
                        ),
                      ],
                    ),
                    PresetTextField(
                      labelText: "Nama Produk",
                      controller: namaProdukController.getController,  // tadinya digunakan untuk input data ke firestore, namun nanti tidak akan pakai ini kecuali untuk clear data setelah submit.
                      fieldOnChanged: (value) => context.read<ProductFormBloc>().add(NameChanged(value)),
                      errorText: (state.isNameValid == false)
                      ? 'Nama produk tidak boleh kosong!'
                      : null,
                    ),
                    PresetTextField(
                      labelText: "Merek Produk",
                      controller: merekProdukController.getController,
                      fieldOnChanged: (value) => context.read<ProductFormBloc>().add(BrandChanged(value)),
                      errorText: (state.isBrandValid == false)
                      ? 'Merek produk tidak boleh kosong!'
                      : null,
                    ),
                    PresetDropdownButton(
                      currentDropdownValue: state.category,
                      labelText: "Kategori Produk", 
                      onChanged: (value) => context.read<ProductFormBloc>().add(CategoryChanged(value.toString())),
                      errorText: (state.isCategoryValid == false)
                      ? 'Kategori produk belum dipilih!'
                      : null,
                      items: state.categoryDropdownItems,
                      itemText: "kategori"
                    ),
                    PresetTextField(
                      keyboardType: TextInputType.number,
                      labelText: "Jumlah Stok",
                      controller: jumlahStokController.getController,
                      fieldOnChanged: (value) => context.read<ProductFormBloc>().add(StockQuantityChanged(value)),
                      errorText: (state.isStockQuantityValid == false)
                      ? state.stockQuantityErrorMessage
                      : null,
                    ),
                    PresetTextField(
                      keyboardType: TextInputType.number,
                      labelText: "Harga",
                      controller: hargaController.getController,
                      fieldOnChanged: (value) => context.read<ProductFormBloc>().add(PriceFieldChanged(value)),
                      errorText: (state.isPriceValid == false)
                      ? state.priceErrorMessage
                      : null,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      color: Colors.greenAccent.shade400,
                      text: "Simpan",
                      onTap: () => context.read<ProductFormBloc>().add(FormSubmitted(context: context)),
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
      )
    );
  }
}





