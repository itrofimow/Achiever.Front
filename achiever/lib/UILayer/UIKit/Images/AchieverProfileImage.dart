import 'package:flutter/material.dart';

class AchieverProfileImage extends StatelessWidget {
  final double size;
  final ImageProvider<dynamic> image;

  AchieverProfileImage(this.size, this.image);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(backgroundImage: image, 
        radius: size / 2,);/*new ClipRRect(
        borderRadius: new BorderRadius.circular(size / 2),
        child: image,
      )*/
  }
}