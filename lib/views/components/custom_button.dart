import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Color color;
  final IconData? icon;
  final double iconSize;
  final bool isBottomPaddingDisabled;
  final bool isButtonDisabled;
  final bool isLeftPaddingDisabled;
  final bool isRightPaddingDisabled;
  final bool isTopPaddingDisabled;
  final double minWidth = 120;
  final Function()? onTap;
  final String text;
  final bool textBold;
  final Color textColor;
  final double textSize;

  CustomButton({
    this.borderColor = Colors.grey,
    this.borderRadius = 15,
    this.borderWidth = 1,
    this.color = Colors.white, 
    this.icon = null,
    this.iconSize = 24,
    this.isBottomPaddingDisabled = false,
    this.isButtonDisabled = false,
    this.isLeftPaddingDisabled = false,
    this.isRightPaddingDisabled = false,
    this.isTopPaddingDisabled = true,
    this.onTap,
    required this.text,
    this.textBold = false,
    this.textColor = Colors.black,
    this.textSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    double bottomPadding = 15;
    double leftPadding = 15;
    double rightPadding = 15;
    double topPadding = 15;
    if (isBottomPaddingDisabled) bottomPadding = 0;
    if (isLeftPaddingDisabled) leftPadding = 0;
    if (isRightPaddingDisabled) rightPadding = 0;
    if (isTopPaddingDisabled) topPadding = 0;
    return Padding(
      padding: EdgeInsets.fromLTRB(leftPadding, topPadding, rightPadding, bottomPadding), // default = 15, 0, 15, 15
      child: Container(
        clipBehavior: Clip.antiAlias,
        // width: ,
        decoration: BoxDecoration(
          border: Border.all(
            // color: Colors.grey
            color: borderColor,
            width: borderWidth
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3, 3),
              blurRadius: 5,
              spreadRadius: 1,
            )
          ]
        ),
        child: Material(
          color: isButtonDisabled? Colors.grey.shade300 : color,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: isButtonDisabled? null : onTap,
            splashColor: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (icon != null) Icon(icon, size: iconSize),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: textSize,
                      fontWeight: (textBold)? FontWeight.bold : FontWeight.normal,
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}