import 'package:ebusiness_atk_mobile/views/components/custom_subHeading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/print_service/print_service_bloc.dart';
import '../../components/custom_button.dart';
import '../../components/preset_popUpAlert.dart';
import '../../components/preset_textField.dart';
import '../../components/preset_textField_controller.dart';

class PrintPricePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Control Panel", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
      body: BlocBuilder<PrintServiceBloc, PrintServiceInitial>(
        builder: (context, state) {
          PresetTextFieldController _colorfulPagePriceController = PresetTextFieldController(value: state.colorfulPagePrice.toString());
          PresetTextFieldController _greyscalePagePriceController = PresetTextFieldController(value: state.greyscalePagePrice.toString());
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSubHeading(text: "Harga Dasar Print"),
                PresetTextField(
                  controller: _colorfulPagePriceController.controller,
                  keyboardType: TextInputType.number,
                  labelText: "Harga dasar print tinta berwarna per lembar"
                ),
                PresetTextField(
                  controller: _greyscalePagePriceController.controller,
                  keyboardType: TextInputType.number,
                  labelText: "Harga dasar print tinta hitam-putih per lembar"
                ),
                CustomButton(
                  color: Colors.lightGreenAccent,
                  isLeftPaddingDisabled: true,
                  text: "Simpan",
                  onTap: () async {
                    context.read<PrintServiceBloc>().add(PrintPriceSubmitted(
                      colorfulPagePrice: int.parse(_colorfulPagePriceController.getController.text),
                      greyscalePagePrice: int.parse(_greyscalePagePriceController.getController.text)
                    ));
                    await PresetPopUpAlert(
                      context: context, 
                      description: "Harga dasar print telah diperbarui", 
                      firstActionButtonText: "OK",
                      firstActionButton: () => Navigator.pop(context, 'OK'),
                      title: "Harga Dasar Print"
                    );
                  },
                ),
              ],
            ),
          );
        },
      )
    );
  }
}