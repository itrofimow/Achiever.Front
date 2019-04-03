import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BlendPainter extends CustomPainter {
  ui.Image image, mask;

  BlendPainter(this.image, this.mask);

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null || mask == null) return;

    Rect dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect imageSrcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    Rect maskSrcRect = Rect.fromLTWH(0, 0, mask.width.toDouble(), mask.height.toDouble());

    Paint paint = Paint();
    /*Size inputSize = Size(mask.width.toDouble(), mask.height.toDouble());
    FittedSizes fs = applyBoxFit(BoxFit.contain, inputSize, size);

    Rect src = Offset.zero & fs.source;
    Rect dst = Alignment.center.inscribe(fs.destination, r);*/

    canvas.saveLayer(dstRect, Paint());

    canvas.drawImageRect(image, imageSrcRect, dstRect, paint);

    paint.blendMode = BlendMode.dstIn;
    canvas.drawImageRect(mask, maskSrcRect, dstRect, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}