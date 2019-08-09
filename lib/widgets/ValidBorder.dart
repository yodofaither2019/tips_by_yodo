import 'package:flutter/material.dart';
import '../Util.dart';
import '../style.dart';

class ValidBorder extends UnderlineInputBorder {
  
  final num, W, S;

  ValidBorder(this.num, this.W, this.S);

  @override
  void paint(Canvas canvas, Rect rect, {double gapStart, double gapExtent = 0.0, double gapPercentage = 0.0, TextDirection textDirection}) {
    var F = Utils.calcTrueTextSize(SizeConfig.validCodeFontSize);

    var paint = borderSide.toPaint();
    paint.color = ColorConfig.inputContent;
    
    for (int i = 0; i < this.num; ++i) {
      double start = S / 4 + (S + F) * i;
      double length = F + S / 2;
      canvas.drawLine(
        Offset(start, rect.bottom),
        Offset(start + length, rect.bottom),
        paint
      );
    }
  }
}