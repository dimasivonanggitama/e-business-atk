import 'package:flutter/material.dart';
class CustomTwoTextOneRow extends StatelessWidget {
  final int flexLeftText;
  final int flexRightText;
  final String leftText;
  final FontWeight leftTextFontWeight;
  final String rightText;
  final TextAlign rightTextAlign;
  final FontWeight rightTextFontWeight;

  CustomTwoTextOneRow({
    this.flexLeftText = 1,
    this.flexRightText = 1,
    required this.leftText,
    this.leftTextFontWeight = FontWeight.normal,
    this.rightText = "",
    this.rightTextAlign = TextAlign.left,
    this.rightTextFontWeight = FontWeight.normal
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flexLeftText,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leftText,
                  style: TextStyle(
                    fontWeight: leftTextFontWeight
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: flexRightText,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rightText,
                  textAlign: rightTextAlign,
                  style: TextStyle(
                    fontWeight: rightTextFontWeight
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
