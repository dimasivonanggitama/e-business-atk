import 'dart:developer';

import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_subHeading.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_textField.dart';
import 'package:ebusiness_atk_mobile/views/pages/admin/produk_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/form/product_form/product_form_bloc.dart';
import '../../components/preset_popUpAlert.dart';
import '../../components/preset_popUpWidgets.dart';
import '../../components/preset_textField_controller.dart';

class ProductCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFormBloc, FormInitial>(
      builder: (context, state) {
        PresetTextFieldController addProductCategoryController = PresetTextFieldController(value: "");
        return Scaffold(
          appBar: AppBar(
            title: Text("Control Panel", style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.brown,
          ),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomSubHeading(text: "Tambah Kategori Produk"),
                    PresetTextField(
                      controller: addProductCategoryController.getController,
                      labelText: "Nama Kategori Produk"
                    ),
                    CustomButton(
                      color: Colors.lightGreen.shade100,
                      onTap: () async {
                        context.read<ProductFormBloc>().add(ProductCategoryAdded(addProductCategoryController.getController.text));
                        await PresetPopUpAlert(
                          context: context, 
                          description: "Kategori produk telah ditambahkan", 
                          firstActionButtonText: "OK",
                          firstActionButton: () => Navigator.pop(context, 'OK'),
                          title: "Tambah Kategori Produk"
                        );
                      },
                      text: "Tambah"
                    ),
                    CustomSubHeading(text: "Kategori Produk"),
                    ListView.separated(                    
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 15,
                          thickness: 1,
                        );
                      },
                      itemCount: state.categoryDropdownItems.length,
                      itemBuilder: (context, index) {
                        PresetTextFieldController editProductCategoryController = PresetTextFieldController(value: state.categoryDropdownItems[index].category!);
                        return Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text(state.categoryDropdownItems[index].category!)
                              ),
                              if (state.categoryDropdownItems[index].id != "0") Flexible(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      // onTap: () => context.read<ProductFormBloc>().add(EditCategoryTriggered(state.categoryDropdownItems[index].id!, listofproductCategoryController[index].getController.text)),
                                      onTap: () async => await PresetPopUpWidgets(
                                        context: context,
                                        title: "Ubah Kategori Produk",
                                        listofWidgetsHeightApprox: 120,
                                        listofWidgets: [
                                          PresetTextField(
                                            controller: editProductCategoryController.getController,
                                            keyboardType: TextInputType.multiline,
                                            labelText: "Nama kategori produk",
                                            maxLines: null,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: CustomButton(
                                                  text: "Kembali",
                                                  onTap: () => Navigator.pop(context, 'Cancel'),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: CustomButton(
                                                  color: Colors.lightGreenAccent,
                                                  isLeftPaddingDisabled: true,
                                                  text: "Simpan",
                                                  onTap: () async {
                                                    context.read<ProductFormBloc>().add(EditProductCategorySubmitted(state.categoryDropdownItems[index].id!, editProductCategoryController.getController.text));
                                                    await PresetPopUpAlert(
                                                      context: context, 
                                                      description: "Kategori produk telah diubah", 
                                                      firstActionButtonText: "OK",
                                                      firstActionButton: () => Navigator.pop(context, 'OK'),
                                                      title: "Ubah Kategori Produk"
                                                    );
                                                    Navigator.pop(context, 'OK');
                                                  },
                                                ),
                                              )
                                            ],
                                          )
                                        ]
                                      ),
                                      child: Icon(Icons.edit, color: Colors.green)
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 15)),
                                    GestureDetector(
                                      onTap: () => PresetPopUpAlert(
                                        context: context,
                                        title: "Hapus Kategori Produk",
                                        description: "Apakah anda ingin menghapus kategori produk ini?", 
                                        firstActionButton: () async {
                                          context.read<ProductFormBloc>().add(DeleteProductCategoryTriggered(state.categoryDropdownItems[index].documentID!));
                                          await PresetPopUpAlert(
                                            context: context,
                                            description: "Kategori produk telah dihapus",
                                            firstActionButtonText: "OK",
                                            firstActionButton: () => Navigator.pop(context, 'OK'),
                                            title: "Hapus item"
                                          );
                                          Navigator.pop(context, 'OK');
                                        },
                                        firstActionButtonText: "Ya",
                                        secondActionButton: () => Navigator.pop(context, 'Cancel'),
                                        secondActionButtonText: "Tidak"
                                      ),
                                      child: Icon(Icons.delete, color: Colors.red)
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
