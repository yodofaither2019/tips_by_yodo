import 'package:flutter/material.dart';
import '../style.dart';

class ProceedButton extends StatefulWidget {
  final Function onPressed;

  ProceedButton({this.onPressed});

  @override
  _ProceedButtonState createState() => _ProceedButtonState(this.onPressed);
}

class _ProceedButtonState extends State<ProceedButton> {
  final Function onPressed;
  
  _ProceedButtonState(this.onPressed);

  @override
  Widget build(BuildContext context) {
    ClipOval buttonBody = StyleConfig.getCircleSurface(
      MediaQuery.of(context).size.width * SizeConfig.proceedButton,
      MediaQuery.of(context).size.width * SizeConfig.proceedButton,
      ColorConfig.bottomBackground
    );
    var proceedButton = IconButton(
      icon: Icon(
        Icons.arrow_forward,
        color: ColorConfig.proceedButton,
      ),
      iconSize: 60,
      onPressed: this.onPressed,
    );
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        StyleConfig.getCircleSurface(
          MediaQuery.of(context).size.width * SizeConfig.proceedButton + 18,
          MediaQuery.of(context).size.width * SizeConfig.proceedButton + 18,
          ColorConfig.bottomBackground
        ),
        StyleConfig.getCircleSurface(
          MediaQuery.of(context).size.width * SizeConfig.proceedButton + 15,
          MediaQuery.of(context).size.width * SizeConfig.proceedButton + 15,
          ColorConfig.loginBackground
        ),
        buttonBody,
        proceedButton
      ],
    );
  }
}
