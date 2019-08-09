import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_tips/style.dart';
import 'package:my_tips/widgets/ProceedButton.dart';
import 'package:my_tips/widgets/Title.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController controller = TextEditingController();
  bool committed = false;

  void commitFeedback() {
    // 此处将反馈传到后端
    print(controller.text);
    setState(() {
      committed = true;
    });
  }

  Widget getFeedbackBody() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
      child: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: TextField(
                style: TextStyle(
                  fontSize: 20
                ),
                decoration: StyleConfig.getTextAreaStyle(placeholder: "请留言您的问题..."),
                controller: controller,
                minLines: 6,
                maxLines: 6,
                maxLength: 500,
              ),
              flex: 6,
            ),
            Expanded(
              child: OutlineButton(
                child: Text(
                  "提交反馈",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  commitFeedback();
                },
              ),
              flex: 1,
            ),
            Expanded(child: Text(""), flex: 5)
          ],
        ),
      ),
    );
  }

  Widget getFeedbackSuccess() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: Text(""), flex: 1),
          Expanded(
            child: LogPageTitle("感谢您的反馈"),
            flex: 2,
          ),
          Expanded(child: StyleConfig.getBottom(context, [
            ProceedButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            )
          ]), flex: 2),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: committed ? null : AppBar(title: Text("问题反馈")),
      resizeToAvoidBottomInset: false,
      body: committed ? getFeedbackSuccess() : getFeedbackBody()
    );
  }
}
