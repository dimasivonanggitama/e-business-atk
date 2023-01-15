import 'package:ebusiness_atk_mobile/bloc/dbms_firestore/dbms_firestore_bloc.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_textField.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DBMSFirestorePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Database Management"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            CustomButton(
              onTap: () => context.read<DBMSFirestoreBloc>().add(CollectionRequested()),
              text: "Retrieve Collection (look at debug)"
            ),
            _deleteCollection(),
            _duplicateCollection(context),
          ],
        ),
      ),
    );
  }

  Widget _deleteCollection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.black,
          thickness: 1,
        ),
        Text("Delete Collection", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.only(bottom: 15)),
        PresetTextField(labelText: "Target collection name"),
        CustomButton(text: "Delete"),
        Padding(padding: EdgeInsets.only(bottom: 15))
      ],
    );
  }

  Widget _duplicateCollection(BuildContext context) {
    return BlocBuilder<DBMSFirestoreBloc, DBMSFirestoreInitial>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Text("Duplicate Collection", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            PresetTextField(
              errorText: (state.isFirstFieldEmpty && state.isFirstFieldEverTyped)? state.firstFieldErrorMessage: null,
              fieldOnChanged: (value) => context.read<DBMSFirestoreBloc>().add(FirstFieldOnChanged(value)),
              labelText: "Collection name target"
            ),
            PresetTextField(
              errorText: (state.isSecondFieldEmpty && state.isSecondFieldEverTyped)? state.secondFieldErrorMessage: null,
              fieldOnChanged: (value) => context.read<DBMSFirestoreBloc>().add(SecondFieldOnChanged(value)),
              labelText: "New collection name"
            ),
            CustomButton(
              text: "Duplicate",
              onTap: () => context.read<DBMSFirestoreBloc>().add(DuplicateCollectionTriggered()),
            ),
            Padding(padding: EdgeInsets.only(bottom: 15))
          ],
        );
      },
    );
  }
}
