import 'package:flutter/material.dart';

class TextoNormal extends StatelessWidget {
  const TextoNormal({
    super.key,
    required this.text,
    this.fontFamily = "Montserrat",
    this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
  });

  final String text;
  final String fontFamily;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}