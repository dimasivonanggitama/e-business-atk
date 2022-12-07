import 'package:flutter/material.dart';

class PresetListViewSeparatedBuilder extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;

  PresetListViewSeparatedBuilder({required this.itemBuilder, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          height: 5,
          thickness: 5,
        );
      },
      itemCount: itemCount,
      itemBuilder: itemBuilder
    );
  }  
}