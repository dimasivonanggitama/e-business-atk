import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
// import 'package:ebusiness_atk_mobile/views/components/convert_categoryIDtoName.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../models/productCategory_model.dart';
import '../../../models/product_model.dart';
import '../../../repository/product_repository.dart';
import '../../../views/components/preset_popUpAlert.dart';

// import 'dart:developer';

import 'package:image_picker/image_picker.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, FormInitial> {
  final ProductRepository _productRepository;

  ProductFormBloc(this._productRepository) : super(FormInitial(
    formStatus: Status.add,
    imageSelected: File(''),
    imageUploaded: "",
    isBrandValid: true,
    isCategoryValid: true,
    isFormValidateFailed: false,
    isImageValid: true,
    isNameValid: true,
    isPriceChanged: false,
    isPriceValid: true,
    isStockQuantityChanged: false,
    isStockQuantityValid: true,
    // listofProducts: [],
    price: 0,
    priceDisplay: "",
    priceErrorMessage: "",
    productID: "",
    stockQuantity: 0,
    stockQuantityDisplay: "",
    stockQuantityErrorMessage: "",
    category: "0",
    categoryDropdownItems: [],
    brand: "",
    name: "",
  )) {
    on<ProductCategoryAdded>(
      (event, emit) async {
        ProductCategoryModel productCategoryData = ProductCategoryModel(
          category: event.categoryName
        );
        await _productRepository.addProductCategory(productCategoryData);
        await _onCategoryDropdownItemsFetched(event, emit);
      }
    );

    on<BrandChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            brand: event.brand,
            isBrandValid: _isFieldNotEmpty(event.brand),
          )
        );
      }
    );

    on<CategoryChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            category: event.category,
            isCategoryValid: _isCurrentDropdownValueNotDefault(event.category),
          )
        );
      }
    );

    on<CategoryDropdownItemsFetched>(_onCategoryDropdownItemsFetched);

    on<DeleteProductCategoryTriggered>(
      (event, emit) async {
        await _productRepository.deleteProductCategory(event.categoryID);
        await _onCategoryDropdownItemsFetched(event, emit);
      }
    );

    on<EditProductCategorySubmitted>(
      (event, emit) async {
        ProductCategoryModel productCategoryData = ProductCategoryModel(
          id:       event.categoryID,
          category: event.categoryName
        );
        await _productRepository.updateProductCategory(event.categoryID, productCategoryData);
        await _onCategoryDropdownItemsFetched(event, emit);
      }
    );

    on<FormFailed>(
      (event, emit) {
        emit(state.currentValue(isFormValidateFailed: false));
      }
    );

    on<FormSubmitted>(
      (event, emit) async {
        if (state.price == 0 || (state.formStatus == Status.add && state.imageSelected!.path.isEmpty) || (state.formStatus == Status.edit && state.imageUploaded.isEmpty) || state.stockQuantity == 0 || state.category == "0" || state.brand == "" || state.name == "") {
          if (state.brand == "") emit(state.currentValue(isBrandValid: false));
          if (state.category == "0") emit(state.currentValue(isCategoryValid: false));
          if (state.formStatus == Status.add) {
            if (state.imageSelected!.path.isEmpty) emit(state.currentValue(isImageValid: false));
          } else if (state.formStatus == Status.edit) {
            if (state.imageUploaded.isEmpty) emit(state.currentValue(isImageValid: false));
          }
          if (state.name == "") emit(state.currentValue(isNameValid: false));
          if (state.price == 0) _getPriceErrorMessage("", emit);
          if (state.stockQuantity == 0) _getStockQuantityErrorMessage("", emit);
          emit(state.currentValue(isFormValidateFailed: true)); //call snackbar information
        } else {
          log("Persyaratan Form telah terpenuhi."); // then call method ...

          final pastUploadedImageURL = state.imageUploaded;

          ProductModel productData = ProductModel(
            brand: state.brand,
            category: state.category,
            // gambarProduk: DateFormat('dd-MM-yyyy-kkmm-').format(DateTime.now()) + basename(state.gambarProdukSelected!.path),
            // gambarProduk: gambarProdukTelahDiupload.toString(),
            // gambarProduk: await uploadedImageURL,
            name: state.name,
            price: state.price,
            stockQuantity: state.stockQuantity,
          );

          if (state.imageSelected!.path.isNotEmpty) productData.image = await _productRepository.saveFile(state.imageSelected);
          log("state.imageSelected!.path.isNotEmpty: ${state.imageSelected!.path.isNotEmpty}");
          log("state.imageSelected!.path: ${state.imageSelected!.path}");
          
          if (state.formStatus == Status.add) {
            await _productRepository.saveProductData(productData);

            await PresetPopUpAlert(
              context: event.context, 
              description: "Data produk berhasil ditambahkan",
              title: "Informasi",
              firstActionButton: () => Navigator.pop(event.context, 'OK'),
              firstActionButtonText: "OK",
            );

            _onValueReset(event, emit); // reset form field
          } else if (state.formStatus == Status.edit) {
            if (state.imageSelected!.path.isEmpty) _productRepository.updateProduct(documentID: state.productID, submittedProduct: productData); // updated information with image no change
            else {
              _productRepository.updateProduct(documentID: state.productID, pastUploadedImageURL: pastUploadedImageURL, submittedProduct: productData);
              emit(state.currentValue(imageUploaded: productData.image));
            }
            PresetPopUpAlert(
              context: event.context,
              description: "Data produk berhasil diubah",
              title: "Informasi",
              firstActionButton: () => Navigator.pop(event.context, 'OK'),
              firstActionButtonText: "OK",
            );
          }
          await productCatalogueAdminRequested(event, emit);
          //this _onValueReset(event, emit);

          // log("state.gambarProduk: ${state.gambarProduk}"); 
          // log("state.gambarProduk!.path: ${state.gambarProduk!.path}"); 
          // log("basename(state.gambarProduk!.path): ${basename(state.gambarProduk!.path)}"); 
          // log("_productRepository.saveFile(state.gambarProduk): ${_productRepository.saveFile(state.gambarProduk)}");
          // log("_productRepository.saveFile(state.gambarProduk).toString(): ${_productRepository.saveFile(state.gambarProduk).toString()}");

          // state.gambarProduk!.path = DateFormat('dd-MM-yyyy–kkmm-').format(DateTime.now()) + basename(state.gambarProduk!.path);
          // log("_productRepository.saveFile(DateFormat('dd-MM-yyyy–kkmm-').format(DateTime.now()) + basename(state.gambarProduk!.path)): ${_productRepository.saveFile(DateFormat('dd-MM-yyyy–kkmm-').format(DateTime.now()) + basename(state.gambarProduk!.path))}");


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

    on<NameChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            name: event.name,
            isNameValid: _isFieldNotEmpty(event.name),
          )
        );
      }
    );

    on<PriceFieldChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            price: _getIntValue(event.price),
            isPriceChanged: true,
          )
        );

        _getPriceErrorMessage(event.price, emit);
      }
    );

    on<ProductCatalogueAdminRequested>(
      (event, emit) async {
        await productCatalogueAdminRequested(event, emit);
      }
    );

    on<ProductDataFetched>(
      (event, emit) async {
        if (state.categoryDropdownItems.isEmpty) await _onCategoryDropdownItemsFetched(event, emit);
        if (event.documentID.isEmpty) {
          _onValueReset(event, emit);
        } else {
          final ProdukData = await _productRepository.retrieveSpecificProduct(event.documentID);
          emit(
            state.currentValue(
              brand: ProdukData.brand,
              category: ProdukData.category,
              formStatus: Status.edit,
              imageUploaded: ProdukData.image,
              name: ProdukData.name,
              price: ProdukData.price,
              priceDisplay: ProdukData.price.toString(),
              productID: event.documentID,
              stockQuantity: ProdukData.stockQuantity,
              stockQuantityDisplay: ProdukData.stockQuantity.toString()
            )
          );
        }
      },
    );

    on<SelectImagePressed>(
      (event, emit) async {
        emit(
          state.currentValue(
            imageSelected: await _getImage(),
            isImageValid: true
          )
        );
        // log("state.imageSelected.toString() : ${state.imageSelected.toString()}");
        if (state.imageSelected!.path.isEmpty) emit(
          state.currentValue(
            isImageValid: false
          )
        );
      }
    );

    on<StockQuantityChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            stockQuantity: _getIntValue(event.stockQuantity),
            isStockQuantityChanged: true,
          )
        );

        _getStockQuantityErrorMessage(event.stockQuantity, emit);
      }
    );
    
    on<ValueReset>(_onValueReset);
  }

  Future productCatalogueAdminRequested(dynamic event, Emitter<FormInitial> emit) async {
    List listofProducts = await _productRepository.retrieveAllProducts();
    // emit(state.currentValue(listofProducts: await convertCategoryIDtoName(listofProducts)));
    // emit(state.currentValue(listofProducts: listofProducts));
  }

  Future _getImage() async {
    // final picker = ImagePicker();
    final imagePicked = await ImagePicker().pickImage(source: ImageSource.gallery);
    File? image = null;
    // XFile? imagePicked;

    if (imagePicked != null) {  // if file manager opened and picked any image (not canceled)
      image = File(imagePicked.path);
      // log("- - image path: " + imagePicked.path);
    }
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

  _getPriceErrorMessage(String price, Emitter<FormInitial> emit) {
    if (price == "") {
      emit(
        state.currentValue(
          priceDisplay: price,
          priceErrorMessage: "Harga tidak boleh kosong!",
          isPriceValid: false
        )
      );
    } else if (_getIntValue(price) == 0) {
      emit(
        state.currentValue(
          priceDisplay: state.price.toString(),
          priceErrorMessage: "Harga tidak boleh bernilai 0!",
          isPriceValid: false
        )
      );
    } else if (_getIntValue(price) > 0 && _getIntValue(price) < 100) {
      emit(
        state.currentValue(
          priceDisplay: state.price.toString(),
          priceErrorMessage: "Harga harus di atas Rp.100,- !",
          isPriceValid: false
        )
      );
    } else {
      emit(
        state.currentValue(
          priceDisplay: state.price.toString(),
          isPriceValid: true
        )
      );
    }
  }

  _getStockQuantityErrorMessage(String stockQuantity, Emitter<FormInitial> emit) {
    if (stockQuantity == "") {
      emit(
        state.currentValue(
          stockQuantityDisplay: stockQuantity,
          stockQuantityErrorMessage: "Jumlah stok tidak boleh kosong!",
          isStockQuantityValid: false
        )
      );
    } else if (_getIntValue(stockQuantity) == 0) {
      emit(
        state.currentValue(
          stockQuantityDisplay: state.stockQuantity.toString(),
          stockQuantityErrorMessage: "Jumlah stok tidak boleh bernilai 0!",
          isStockQuantityValid: false
        )
      );
    } else {
      emit(
        state.currentValue(
          stockQuantityDisplay: state.stockQuantity.toString(),
          isStockQuantityValid: true
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

  _onCategoryDropdownItemsFetched(event, Emitter<FormInitial> emit) async {
    List<ProductCategoryModel> listofCategories = await _productRepository.retrieveCategories();

    for(int i = 0; i < listofCategories.length; i++) {
      log("listofCategories[i].category: ${listofCategories[i].category}");
    }
    emit(
      state.currentValue(
        categoryDropdownItems: listofCategories
      )
    );
        
        log("[_onCategoryDropdownItemsFetched] state.categoryDropdownItems.isEmpty: ${state.categoryDropdownItems.isEmpty}");
        log("[_onCategoryDropdownItemsFetched] state.categoryDropdownItems.length: ${state.categoryDropdownItems.length}");
        log("[_onCategoryDropdownItemsFetched] listofCategories.length: ${listofCategories.length}");
  }

  _onValueReset(event, emit) { // back to default value
    emit(
      state.currentValue(
        // email: "",
        brand: "",
        category: "0",
        formStatus: Status.add,
        imageSelected: File(''),
        imageUploaded: "",
        isBrandValid: true,
        isCategoryValid: true,
        isFormValidateFailed: false,
        isImageValid: true,
        isNameValid: true,
        isPriceChanged: false,
        isPriceValid: true,
        isStockQuantityChanged: false,
        isStockQuantityValid: true,
        name: "",
        price: 0,
        priceDisplay: "",
        priceErrorMessage: "",
        productID: "",
        stockQuantity: 0,
        stockQuantityDisplay: "",
        stockQuantityErrorMessage: "",
      )
    );
  }
}
