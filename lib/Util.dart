import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

class Utils {
  static double calcTrueTextSize(double textSize) {
    // 测量单个数字实际长度
    var paragraph = ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: textSize))
      ..addText("0");
    var p = paragraph.build()
      ..layout(ui.ParagraphConstraints(width: double.infinity));
    return p.minIntrinsicWidth;
  }

  static String timeStampToTime(int timeStamp) {
    int hh = timeStamp % (3600 * 24) ~/ 3600;
    int mm = timeStamp % (3600) ~/ 60;
    String hhstr = hh.toString();
    String mmstr = mm.toString();
    return (hhstr.length == 2 ? hhstr : ('0' + hhstr)) + ':' + (mmstr.length ==2 ? mmstr : ('0' + mmstr));
  }

  static double durationToLength(BuildContext context, double vertexSize, int duration) {
    return duration / 500 * vertexSize * MediaQuery.of(context).size.height / 600;
  }
}
