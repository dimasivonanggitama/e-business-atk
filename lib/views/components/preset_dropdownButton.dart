import 'package:ebusiness_atk_mobile/models/productCategory_model.dart';
import 'package:flutter/material.dart';

class PresetDropdownButton extends StatelessWidget {
  final Function(dynamic)? onChanged;
  final List? items;
  final currentDropdownValue;
  final String? errorText;
  final String labelText;
  final String? itemText;

  PresetDropdownButton({
    required this.currentDropdownValue,
    required this.labelText, 
    this.errorText = "",
    this.items,
    required this.itemText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: DropdownButtonFormField<dynamic>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          errorText: errorText,
          labelText: labelText,
        ),
        value: currentDropdownValue,
        items: items!.map((value) {
          return DropdownMenuItem(
            value: value.id,
            child: _showItemText(itemText, value)
          );
        }).toList(),
        onChanged: onChanged,
      )
    );
  }

  _showItemText(itemText, value){
    if (itemText == "kategori") return Text('${value.category}');
    else return Text('[Field name not found!]');
  }

}

/*
final Stream<QuerySnapshot> _kategoriStream = FirebaseFirestore.instance.collection('kategori').snapshots();

Padding(
  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
  child: StreamBuilder<QuerySnapshot>(
    stream: _kategoriStream,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        print("Data ada yang salah");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: currentDropdownOutlineColor, width: currentDropdownOutlineWidth)),
          labelText: 'Kategori',
        ),
        value: currentDropdownValue,
        items: snapshot.data!.docs.map((value) {
          return DropdownMenuItem<String>(
            value: value.get('id'),
            child: Text(
              '${value.get('kategori')}',
              // style: TextStyle(fontSize: 30),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            currentDropdownValue = newValue!;
            normalDropdownState();
          });
        },
      );
    }
  ),
),
*/