import 'package:flutter/material.dart';

class CustomButtonIncreaseDecrease extends StatelessWidget {
  final Function()? decreaseOnTap;
  final Function()? increaseOnTap;
  final bool isBigSize;
  final bool isDisableBottomPadding;
  final int productQuantityCart;

  CustomButtonIncreaseDecrease({
    this.decreaseOnTap,
    this.increaseOnTap,
    this.isBigSize = false,
    this.isDisableBottomPadding = false,
    required this.productQuantityCart
  });

  @override
  Widget build(BuildContext context) {
    double buttonFontSize = 18;
    double innerRadius = 10;
    double bottomPadding = 15;
    double outerRadius = 15;
    double quantityFontSize = 14;
    if (isBigSize) {
      buttonFontSize += 5;
      innerRadius += 5;
      outerRadius += 5;
      quantityFontSize += 5;
    }
    if (isDisableBottomPadding) bottomPadding = 0;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        children: [
          Material(
            borderRadius: BorderRadius.all(Radius.circular(outerRadius)), // default = 15
            color: Colors.green,
            elevation: 5,
            child: InkWell(
              onTap: decreaseOnTap,
              borderRadius: BorderRadius.all(Radius.circular(outerRadius)), // default = 15
              splashColor: Colors.white.withOpacity(0.8),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: innerRadius, // default = 10
                  child: Text(
                    "-",
                    style: TextStyle(
                      fontSize: buttonFontSize, // default = 18
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              )
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 15,
            child: Text(
              productQuantityCart.toString(),
              style: TextStyle(
                fontSize: quantityFontSize, // default = 14
                color: Colors.black
              ) 
            ),
          ),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(outerRadius)), // default = 15
            color: Colors.green,
            elevation: 5,
            child: InkWell(
              onTap: increaseOnTap,
              borderRadius: BorderRadius.all(Radius.circular(outerRadius)), // default = 15
              splashColor: Colors.white.withOpacity(0.8),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: innerRadius, // default = 10
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontSize: buttonFontSize, // default = 18
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              )
            ),
          ),
          // Expanded(child: _button(addIcon: true, text: "Keranjang", textSize: 16)),
        ],
      ),
    );
  }
}