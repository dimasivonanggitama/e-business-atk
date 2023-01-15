import 'package:flutter/material.dart';

class CustomSubHeading extends StatelessWidget {
  final text;
  CustomSubHeading({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Text(
                text, 
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              ),
              Padding(padding: EdgeInsets.only(bottom: 15))
            ],
          ),
        )
      ],
    );
  }
}