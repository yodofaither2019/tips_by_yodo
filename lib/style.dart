import 'package:flutter/material.dart';

class ColorConfig {
  static const loginBackground = Color(0xff25272b);  // 登录/注册界面背景颜色
  static const bottomBackground = Color(0xff313339);
  static const loginTitle = Color(0xffcccccc);  // 登录/注册界面的 L O G I N / L O G U P 标题的颜色
  static const enabledBorder = Color(0xffcccccc);  // 输入框的颜色
  static const inputContent = Color(0xffcccccc);  // 输入内容的颜色
  static const placeholder = Color(0xffaaaaaa);
  static const proceedButton = Color(0xffcccccc);  // 下一步按钮颜色
  static const finishedEvent = Color(0xff888822);  // 已完成事件边框颜色
  static const todoEvent = Color(0xff666666);  // 未完成事件边框颜色
  static const edges = Color(0xff737373);  // DAG中边的颜色
  static const eventTitle = Color(0xffaaaaaa);  // 事件标题/起始时间的颜色
  static const currentTime = Color(0xff888822);
}

class SizeConfig {
  static const proceedButton = 1 / 3;  // 下一步按钮; 宽 = 高 = SizeConfig.proceedButton * 屏宽
  static const validCodeFontSize = 40.0;
  static const validCodePadding = 20.0;
}

class StyleConfig {
  static InputDecoration getInputStyle({String placeholder: "", contentColor: ColorConfig.inputContent, wrong: false}) {
    return InputDecoration(
      hintText: placeholder,
      hintStyle: TextStyle(
        color: wrong ? Colors.red : ColorConfig.placeholder,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: wrong ? Colors.red : ColorConfig.enabledBorder,
        )
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: wrong ? Colors.red : ColorConfig.enabledBorder,
        )
      ),
    );
  }

  static InputDecoration getTextAreaStyle({String placeholder: "", contentColor: ColorConfig.inputContent, wrong: false}) {
    return InputDecoration(
      hintText: placeholder,
      hintStyle: TextStyle(
        color: wrong ? Colors.red : ColorConfig.placeholder,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: wrong ? Colors.red : ColorConfig.enabledBorder,
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: wrong ? Colors.red : ColorConfig.enabledBorder,
        )
      ),
    );
  }

  static getBottom(BuildContext context, List<Widget> otherChildren) {
    var children = <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            color: ColorConfig.bottomBackground,
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * SizeConfig.proceedButton / 2,
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            color: ColorConfig.loginBackground
          ),
        ),
      )
    ];

    children.addAll(otherChildren);

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: children,
    );
  }

  static getCircleSurface(width, height, color) {
    return ClipOval(
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
