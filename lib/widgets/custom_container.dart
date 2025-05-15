import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.boxPadding = const EdgeInsets.fromLTRB(10, 5, 3, 5),
    this.boxMargin,
    this.alignContent,
    this.boxBgColor = const Color(0xFFbf6370),
    this.boxHeight,
    this.boxWidth = double.infinity,
  });

  final Widget child;
  final double? boxWidth;
  final double? boxHeight;
  final EdgeInsetsGeometry? boxPadding;
  final EdgeInsetsGeometry? boxMargin;
  final AlignmentGeometry? alignContent;
  final Color boxBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxWidth,
      height: boxHeight,
      alignment: alignContent,
      padding: boxPadding,
      margin: boxMargin,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: boxBgColor,
      ),
      child: child,
    );
  }
}