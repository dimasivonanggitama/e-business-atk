import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_subHeading.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_textField.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_textField_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_condition/auth_condition_bloc.dart';
import '../../bloc/print_service/print_service_bloc.dart';
import '../components/convert_decimalSeparator.dart';
import '../components/preset_popUpAlert.dart';
import '../components/preset_snackbar.dart';
import 'print_preview.dart';


class PrintServicePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Layanan Print")
      ),
      body: BlocListener<PrintServiceBloc, PrintServiceInitial>(
        listener: (context, state) {
          if (state.isSnackBarShowedUp) {
            PresetSnackbar(
              action: false,
              color: Colors.red, 
              context: context, 
              message: state.errorMessage
            );
            context.read<PrintServiceBloc>().add(SnackBarDismissed());
          }
        },
        child: BlocBuilder<PrintServiceBloc, PrintServiceInitial>(
          builder: (context, printServiceState) {
            PresetTextFieldController _totalColorfulPagesController = PresetTextFieldController(value: printServiceState.totalColorfulPages.toString());
            PresetTextFieldController _totalGreyscalePagesController = PresetTextFieldController(value: printServiceState.totalGreyscalePages.toString());
            return Container(
              color: Colors.grey.shade200,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        CustomSubHeading(text: "Pilih File"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(15, 15, 3, 15),
                                margin: EdgeInsets.only(right: 3, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                                  //border: Border.all(color: Colors.grey.withOpacity(0.3))
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                                  elevation: 3,
                                  child: InkWell(
                                    onTap: () {},
                                    splashColor: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(printServiceState.filename, overflow: TextOverflow.ellipsis),
                                    ),
                                  )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
                                margin: EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                                  // border: Border.all(color: Colors.grey.withOpacity(0.3))
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                                  elevation: 5,
                                  color: Colors.green[200],
                                  child: InkWell(
                                    // onTap: () {
                                    //   Navigator.push(
                                    //     context, MaterialPageRoute(
                                    //       builder: (context) {
                                    //         return print_previewPage();
                                    //       }
                                    //     )
                                    //   );
                                    // },
                                    onTap: () => context.read<PrintServiceBloc>().add(SelectFilePressed()),
                                    splashColor: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text("Pilih File"),
                                    ),
                                  ),
                                )
                              )
                            )
                          ]
                        ),
                    
                        CustomSubHeading(text: "Jumlah halaman"),
                        PresetTextField(
                          controller: _totalColorfulPagesController.controller,
                          fieldOnChanged: (value) => context.read<PrintServiceBloc>().add(TotalColorfulPagesChanged(int.parse((value.isEmpty)? "0" : value))),
                          fillColor: Colors.white,
                          keyboardType: TextInputType.number,
                          labelText: "Jumlah halaman berwarna"
                        ),
                        PresetTextField(
                          controller: _totalGreyscalePagesController.controller,
                          fieldOnChanged: (value) => context.read<PrintServiceBloc>().add(TotalGreyscalePagesChanged(int.parse((value.isEmpty)? "0" : value))),
                          fillColor: Colors.white,
                          keyboardType: TextInputType.number,
                          labelText: "Jumlah halaman hanya hitam-putih"
                        ),
                        CustomSubHeading(text: "Preview"),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text("Nama File:")
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(printServiceState.filename, style: TextStyle(fontWeight: FontWeight.bold))
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text("Jumlah halaman berwarna:")
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        Text("${printServiceState.totalColorfulPages} x ${printServiceState.colorfulPagePrice} = "),
                                        Text(decimalSeparator(printServiceState.totalPriceofColorfulPages), style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(" Rupiah"),
                                      ],
                                    )
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text("Jumlah halaman hanya hitam-putih:")
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        Text("${printServiceState.totalGreyscalePages} x ${printServiceState.greyscalePagePrice} = "),
                                        Text(decimalSeparator(printServiceState.totalPriceofGreyscalePages), style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(" Rupiah"),
                                      ],
                                    )
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text("Total Harga:")
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        Text(decimalSeparator(printServiceState.grandTotalPrice), style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(" Rupiah"),
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        // CustomButton(
                        //   color: Colors.green[200]!,
                        //   text: "Tambahkan ke keranjang",
                        //   // onTap: () => context.read<PrintServiceBloc>().add(FormSubmitted()),
                        //   onTap: () async => await PresetPopUpAlert(
                        //     context: context, 
                        //     description: "Harga dasar print telah diperbarui", 
                        //     firstActionButtonText: "OK",
                        //     firstActionButton: () => Navigator.pop(context, 'OK'),
                        //     title: "Harga Dasar Print"
                        //   )
                        // ),
                        BlocBuilder<AuthConditionBloc, AuthConditionState>(
                          builder: (context, authState) {
                            return CustomButton(
                              color: Colors.lightGreenAccent.shade200,
                              icon: (authState is AuthSuccess)? printServiceState.iconSubmitButton : Icons.warning,
                              iconSize: 18,
                              isButtonDisabled: (authState is AuthSuccess)? printServiceState.isSubmitButtonDisabled : true,
                              onTap: () => context.read<PrintServiceBloc>().add(FormSubmitted((authState as AuthSuccess).uid)),
                              // onTap: () {
                              //   if (authState is AuthSuccess) {
                              //     // log("Auth is Success. Ready to Go!");
                              //     context.read<CatalogueBloc>().add(ProductSubmitted(idProduk, authState.uid));
                              //   }
                              //   else Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //     return CustomAuthForm(isInstructionTextShowed: true);
                              //   }));
                              // },
                              text: (authState is AuthSuccess)? printServiceState.textSubmitButton : "Anda harus login terlebih dahulu"
                              // text: printServiceState.textSubmitButton
                            );
                          },
                        )
                      ]
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}