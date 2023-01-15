import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/preset_textField.dart';

class DeliveryFeePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Control Panel"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Text("Biaya Pengantaran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            PresetTextField(
              labelText: "Biaya Pengantaran"
            ),
            CustomButton(text: "Simpan"),
            Padding(padding: EdgeInsets.only(bottom: 15))
          ],
        ),
      )
    );
  }
}