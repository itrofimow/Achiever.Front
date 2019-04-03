import 'package:flutter/material.dart';

class AchieverImage extends StatelessWidget {
  final double width, height;
  final ImageProvider<dynamic> image;
  AchieverImage(this.width, this.height, this.image);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
        //border: Border.all(color: Colors.red, width: 1.0),
        image: DecorationImage(image: image),
        borderRadius: BorderRadius.circular(8),
        /*boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.22),
            offset: Offset(0.0, 12.0),
            blurRadius: 14.0
          )
        ]*/  
      ),
    );
  }
}