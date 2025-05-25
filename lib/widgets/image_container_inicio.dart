import 'package:flutter/material.dart';

class ImageContainerInicio extends StatelessWidget {
  const ImageContainerInicio({
    super.key,
    this.boxMargin = 5.0,
    this.boxPadding = const EdgeInsets.fromLTRB(5, 5, 5, 10),
    this.boxSpacing = 5,
    this.externalBorderWidth = 2.0,
    this.imageWidth = 130,
    this.imageHeight = 100,
    this.imageBorderWidth = 2.0,
    this.backgroundColor = Colors.white,
    required this.image,
    
  });

  final double boxMargin;
  final EdgeInsetsGeometry? boxPadding;
  final double boxSpacing;
  final double externalBorderWidth;
  final double imageWidth;
  final double imageHeight;
  final double imageBorderWidth;
  final ImageProvider<Object> image;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: boxPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          width: externalBorderWidth,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(boxMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: boxSpacing,
        children: [
          Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              border: Border.all(
                width: imageBorderWidth,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'Leyenda',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 9,
            ),
          ),
          Text(
            '~',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
