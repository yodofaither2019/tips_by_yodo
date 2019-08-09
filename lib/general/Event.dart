import 'package:flutter/material.dart';
import 'package:my_tips/Util.dart';
import 'package:my_tips/style.dart';

class Event {

  bool enabled;
  int begin;
  int duration;
  double edge;
  double progress;
  String title;
  int fork;
  Widget widget;
  Offset center;
  bool started;
  bool finished;
  Event source;
  Event merge;

  Event(BuildContext context, double vertexSize, DateTime nowUTC, this.begin, this.duration, this.title, this.fork) {
    bool nowTimeRepeat = false;
    Duration diff = Duration(hours: 1);
    finished = false;
    if (this.begin != -1){
      diff = nowUTC.add(Duration(hours: 8)).difference(DateTime.fromMillisecondsSinceEpoch(this.begin * 1000));
      finished = diff.inSeconds > 0;
    }
    started = nowUTC.add(Duration(hours: 8)).millisecondsSinceEpoch ~/ 1000 > this.begin;
    this.edge = Utils.durationToLength(context, vertexSize, duration);
    Widget vertex = Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        StyleConfig.getCircleSurface(vertexSize, vertexSize, finished ? ColorConfig.finishedEvent : ColorConfig.todoEvent),
        StyleConfig.getCircleSurface(vertexSize - 5, vertexSize - 5, finished ? ColorConfig.todoEvent : ColorConfig.edges),
      ],
    );

    Widget edge = Container(
      width: 0.0,
      height: this.edge,
      margin: EdgeInsets.only(top: vertexSize),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConfig.edges
        )
      ),
    );
    this.progress = diff.inSeconds / duration;
    if (diff.inSeconds > 0 && diff.inSeconds < 60) {
      nowTimeRepeat = true;
    } else if (this.progress > 1) {
      this.progress = 1;
    } else if (this.progress < 0) {
      this.progress = 0;
    } else if (this.edge * this.progress < vertexSize) {
      this.progress = vertexSize / this.edge;
    }
    double doneHeight = this.edge * this.progress;
    doneHeight = doneHeight > 0 ? doneHeight : 0;
    Widget doneEdge = Container(
      width: 0.0,
      height: doneHeight,
      margin: EdgeInsets.only(top: vertexSize),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConfig.finishedEvent
        )
      ),
    );

    Widget nowTime;
    if (!nowTimeRepeat && this.progress > 0 && this.progress < 1) {
      nowTime = Container(
        margin: EdgeInsets.only(left: vertexSize * 2, bottom: this.edge - vertexSize / 4, top: vertexSize / 2 + doneHeight),
        child: Row(
          children: <Widget>[
            Text(
              Utils.timeStampToTime(nowUTC.add(Duration(hours: 8)).millisecondsSinceEpoch ~/ 1000),
              style: TextStyle(
                color: ColorConfig.currentTime,
                fontSize: vertexSize,
              ),
            ),
            Icon(
              Icons.arrow_right,
              color: ColorConfig.currentTime,
            )
          ],
        )
      );
    }

    Widget event;

    if (fork == 0) {
      event = Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [edge, doneEdge, vertex],
      );
    } else {
      event = Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [edge, doneEdge, vertex],
      );
    }

    List<Widget> children = [
        Container(
          child: event,
          margin: EdgeInsets.only(left: vertexSize * 6, top: vertexSize / 4),
        ),
        Container(
          margin: EdgeInsets.only(left: vertexSize * 8, bottom: this.edge - vertexSize / 2),
          child: Container(
            child: Text(
              title,
              style: TextStyle(
                color: ColorConfig.eventTitle,
                fontSize: vertexSize,
              ),
            ),
          )
        ),
        Container(
          margin: EdgeInsets.only(left: vertexSize * 2, bottom: this.edge - vertexSize / 4, top: vertexSize / 6),
          child: Text(
            this.begin == -1 ? "" : Utils.timeStampToTime(this.begin),
            style: TextStyle(
              color: nowTimeRepeat ? ColorConfig.currentTime : ColorConfig.eventTitle,
              fontSize: vertexSize,
            ),
          ),
        ),
    ];
    if (nowTime != null)
      children.add(nowTime);
    Widget titledEvent = Container(
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: children,
      ),
    );
    this.widget = titledEvent;
  }
}