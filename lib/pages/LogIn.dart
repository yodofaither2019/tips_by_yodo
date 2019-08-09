import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_tips/pages/ContactUs.dart';
import 'package:my_tips/widgets/ProceedButton.dart';
import '../widgets/Title.dart';
import '../widgets/ValidBorder.dart';
import '../style.dart';
import '../Util.dart';

class LogUpPage extends StatefulWidget {
  LogUpPage({Key key}): super();

  @override
  _LogUpPageState createState() => _LogUpPageState();
}

class _LogUpPageState extends State<LogUpPage> {
  // states
  var emailSent = false;
  var emailIllegal = false;
  var emailExist = false;

  var validated = false;
  var validIllegal = false;

  var passwordSet = false;
  var passwordInvalid = false;
  var passwordDiff = false;

  var emailController = TextEditingController();
  var validController = TextEditingController();
  var passwordController = TextEditingController();
  var againController = TextEditingController();

  void reset() {
    emailSent = false;
    emailIllegal = false;
    emailExist = false;

    validated = false;
    validIllegal = false;

    passwordSet = false;
    passwordInvalid = false;
    passwordDiff = false;

    emailController.clear();
    validController.clear();
    passwordController.clear();
    againController.clear();
  }

  // 发送邮件
  sendEmail() {
    var legalEmail = RegExp("\\w{0,}\\@\\w{0,}\\.{1}\\w{0,}");
    if (!legalEmail.hasMatch(this.emailController.text))
      emailIllegal = true;
    else {
      emailIllegal = false;
      // 未接入服务的前端开发阶段, 用随机数确定是注册还是登录
      if (Random().nextInt(10) < 5)
        emailSent = true;
      else
        emailExist = true;
    }
  }

  // 发送验证码
  sendValidCode() {
    if (this.validController.text.length == 4) {
      // 未接入服务的前端开发阶段, 为了演示效果, 验证码随机正确和错误的概率均为0.5
      if (Random().nextInt(10) < 5) {
        validIllegal = false;
        validated = true;
      } else {
        validIllegal = true;
      }
    } else {
      validIllegal = true;
    }
  }

  // 登录
  logIn() {
    if (Random().nextInt(10) < 5) {
      passwordInvalid = false;
      validated = true;
      passwordSet = true;
    } else {
      passwordInvalid = true;
    }
  }

  // 设置密码
  setPassword() {
    var letter = RegExp(".*[a-zA-Z]+.*");
    var num = RegExp(".*[0-9]+.*");
    if (passwordController.text.length < 6 || !letter.hasMatch(passwordController.text) || !num.hasMatch(passwordController.text)) {
      passwordInvalid = true;
    } else if (passwordController.text != againController.text) {
      passwordDiff = true;
    } else {
      passwordInvalid = false;
      passwordDiff = false;
      passwordSet = true;
    }
  }

  proceed() {
    setState(() {
      if (!emailSent && !emailExist) {
        this.sendEmail();
      } else if (!validated) {
        if (!emailExist) {
          this.sendValidCode();
        } else {
          this.logIn();
        }
      } else if (!passwordSet) {
        this.setPassword();
      }
      else {
        // 此处应跳转到主页, 主页未开发, 所以重新来一遍注册 2333
        this.reset();
      }
    });
  }

  // 邮箱地址输入框
  Widget getEmailBox() {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 7,
        right: MediaQuery.of(context).size.width / 7,
      ),
      child: TextField(
        controller: emailController,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: emailIllegal ? Colors.red : ColorConfig.inputContent,
          fontSize: 20,
        ),
        cursorColor: ColorConfig.enabledBorder,
        decoration: StyleConfig.getInputStyle(placeholder: "邮  箱  地  址", wrong: emailIllegal),
        onTap: () {
          emailIllegal = false;
        },
        onChanged: (s) {
          emailIllegal = false;
        },
        onSubmitted: (s) {
          proceed();
        },
      ),
    );
  }
  
  // 提示信息
  Widget getPrompt(String prompt, {smallerFont: 21, color: ColorConfig.loginTitle}) {
    return Text(
      prompt,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: MediaQuery.of(context).size.width / smallerFont, fontWeight: FontWeight.w200, color: color),
    );
  }

  // 验证码输入框
  Widget getValidCodeBox({num: 4}) {
    /**
     * W-N(Fw+S)=2P
     * 
     */
    var W = MediaQuery.of(context).size.width;
    var F = SizeConfig.validCodeFontSize;
    var P = SizeConfig.validCodePadding;
    var S = (W - 2 * P) / num - Utils.calcTrueTextSize(F);
    return Container(
      child: TextField(
        controller: validController,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: ValidBorder(num, W, S),
          focusedBorder: ValidBorder(num, W, S),
        ),
        cursorWidth: 0,
        style: TextStyle(
          letterSpacing: S,
          fontSize: F,
          color: validIllegal ? Colors.red : ColorConfig.inputContent,
        ),
        onTap: () {
          validIllegal = false;
          validController.selection = TextSelection.fromPosition(
            TextPosition(
              affinity: TextAffinity.downstream,
              offset: validController.text.length,
            )
          );
        },
        onChanged: (s) {
          validIllegal = false;
          if (validController.text.length == 0) return;
          if (validController.text.length > num) validController.text = validController.text.substring(0, num);
          // 只允许输入数字
          if (!RegExp("[0-9]").hasMatch(validController.text.substring(validController.text.length - 1))) {
            print(validController.text.substring(0, validController.text.length - 1));
            validController.text = validController.text.substring(0, validController.text.length - 1);
            validController.selection = TextSelection.fromPosition(
              TextPosition(
                affinity: TextAffinity.downstream,
                offset: validController.text.length,
              )
            );
          }
          if (validController.text.length == num) {
            // 填满自动提交
            proceed();
          }
        }
      ),
      margin: EdgeInsets.only(
        left: P - 1,
        right: P - 1
      ),
    );
  }

  Widget getPasswordBox() {
    var children = <Widget>[
      Container(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 7,
          right: MediaQuery.of(context).size.width / 7,
        ),
        child: TextField(
          controller: passwordController,
          autofocus: true,
          obscureText: true,
          style: TextStyle(
            color: ColorConfig.inputContent,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
          cursorColor: ColorConfig.enabledBorder,
          decoration: StyleConfig.getInputStyle(placeholder: "密    码", wrong: passwordInvalid),
          onTap: () {
            passwordInvalid = false;
          },
          onChanged: (s) {
            passwordInvalid = false;
          },
          onSubmitted: (s) {
            proceed();
          }
        ),
      )
    ];
    if (!emailExist) {
      children.add(
        Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 7,
            right: MediaQuery.of(context).size.width / 7,
          ),
          child: TextField(
            controller: againController,
            autofocus: true,
            obscureText: true,
            style: TextStyle(
              color: ColorConfig.inputContent,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
            cursorColor: ColorConfig.enabledBorder,
            decoration: StyleConfig.getInputStyle(placeholder: "重复密码", wrong: passwordDiff),
            onSubmitted: (s) {
              proceed();
            }
          ),
        )
      );
    }
    return Column(children: children);
  }

  // 下一步按钮
  Widget getButton() {
    return ProceedButton(
      onPressed: this.proceed
    );
  }

  // 底部 (按钮与背景重叠)
  Widget getBottom() {
    var flatButtonFontSize = 16.0;
    var regretButton = Container(
      margin: EdgeInsets.only(bottom: flatButtonFontSize * 2),
      child: FlatButton(
        child: Text("更改邮箱", style: TextStyle(color: ColorConfig.inputContent, fontSize: flatButtonFontSize)),
        onPressed: () {
          setState(() {
            emailSent = false; 
            emailExist = false;
            passwordController.clear();
            againController.clear();
            validController.clear();
          });
        },
      ),
    );
    var forgetButton = Container(
      child: FlatButton(
        child: Text("忘记密码", style: TextStyle(color: ColorConfig.inputContent, fontSize: flatButtonFontSize)),
        onPressed: () {
          setState(() {
            emailSent = false; 
            emailExist = false;
            passwordController.clear();
            againController.clear();
            validController.clear();
          });
        },
      ),
    );
    var feedbackButton = Container(
      child: FlatButton(
        child: Text("问题反馈", style: TextStyle(color: ColorConfig.inputContent, fontSize: flatButtonFontSize)),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new ContactUs())
          );
        },
      ),
    );
    var children = <Widget>[
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
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
          ),
          getButton(),
        ],
      ),
    ];
    if ((emailSent || emailExist) && !validated) {
      children.add(regretButton);
      if (emailExist) {
        children.add(forgetButton);
      }
    }
    children.add(feedbackButton);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: children
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    if (!emailSent && !emailExist) {
      children.addAll([
        Expanded(child: LogPageTitle("注册/登录"), flex: 2),
        Expanded(child: getEmailBox(), flex: 1),
        Expanded(child: getBottom(), flex: 2),
      ]);
    }
    else if (!validated && !emailExist) {
      children.addAll([
        Expanded(child: LogPageTitle(""), flex: 2),
        Expanded(child: getValidCodeBox(num: 4), flex: 3),
        Expanded(child: getPrompt("请输入您收到的验证码"), flex: 1),
        Expanded(child: getBottom(), flex: 4),
      ]);
    } else if (!passwordSet) {
      if (emailExist) {
        children.addAll([
          Expanded(child: LogPageTitle("登录"), flex: 2),
          Expanded(child: getPasswordBox(), flex: 1),
          Expanded(child: getBottom(), flex: 2),
        ]);
      } else {
        children.addAll([
          Expanded(child: LogPageTitle("设置密码"), flex: 3),
          Expanded(child: getPasswordBox(), flex: 2),
          Expanded(child: getPrompt("至少六位, 包含字母和数字", color: passwordInvalid ? Colors.red : ColorConfig.loginTitle), flex: 1),
          Expanded(child: getBottom(), flex: 4),
        ]);
      }
    } else {
      if (!emailExist) {
        children.addAll([
          Expanded(child: LogPageTitle(""), flex: 2),
          Expanded(child: getPrompt("注册成功", smallerFont: 10), flex: 1,),
          Expanded(child: getBottom(), flex: 2),
        ]);
      } else {
        // 此处跳转主页
        children.addAll([
          Expanded(child: LogPageTitle(""), flex: 2),
          Expanded(child: getPrompt("登录成功", smallerFont: 10), flex: 1,),
          Expanded(child: getBottom(), flex: 2),
        ]);
      }
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        )
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}