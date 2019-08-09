import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_tips/Util.dart';
import 'package:my_tips/general/Event.dart';
import 'package:my_tips/style.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  double vertexSize;
  double edgeLength;
  DateTime now = DateTime.now();
  int baseBegin;
  double height;
  double width;

  Widget getDAG(List<List<dynamic>> eventData) {
    vertexSize = MediaQuery.of(context).size.width / 19;
    List<bool> flags = [];
    for (var i = 0; i < eventData.length; ++i) {
      flags.add(false);
    }
    List<List<Event>> events = [];
    baseBegin = eventData[0][0];
    int epoch = 0;
    while (flags.contains(false)) {
      int k = 0;
      for (var i = 0; i < eventData.length; ++i) {
        if (flags[i]) continue;
        if (k == 0) {
          if (events.length == epoch) {
            events.add(<Event>[]);
          }
          Event event = new Event(context, vertexSize, now, eventData[i][0], eventData[i][1], eventData[i][2], epoch);
          event.center = new Offset(epoch * 200 / 1, Utils.durationToLength(context, vertexSize, event.begin - baseBegin));
          events[epoch].add(event);
          flags[i] = true;
        } else {
          Event event = new Event(context, vertexSize, now, eventData[i][0], eventData[i][1], eventData[i][2], epoch);
          event.center = new Offset(epoch * 200 / 1, Utils.durationToLength(context, vertexSize, event.begin - baseBegin));
          int beginDiff = event.begin - events[epoch].last.begin;
          int prevDura = events[epoch].last.duration;
          int prevEnd = events[epoch].last.begin + prevDura;
          int prevFork = events[epoch].last.fork;
          if (beginDiff > prevDura) {
            Event vacant = new Event(context, vertexSize, now, prevEnd, beginDiff - prevDura, "[空闲]", prevFork);
            vacant.center = new Offset(epoch * 200 / 1, Utils.durationToLength(context, vertexSize, vacant.begin - baseBegin));
            events[epoch].addAll([vacant, event]);
            flags[i] = true;
          } else if (event.begin - events[epoch].last.begin == events[epoch].last.duration) {
            events[epoch].add(event);
            flags[i] = true;
          }
        }
        ++k;
      }
      ++epoch;
    }

    width = 200.0;
    height = 0.0;
    List<Widget> stackChildren = [];
    for (var fork = 0; fork < events.length; ++fork) {
      width += 200.0;
      int totalDuration = 0;
      for (var i = 0; i < events[fork].length; ++i) {
        totalDuration += events[fork][i].duration;
        if (stackChildren.length == 0) {
          stackChildren.add(events[fork][i].widget);
        } else {
          stackChildren.add(
            Positioned(
              child: events[fork][i].widget,
              left: events[fork][i].center.dx,
              top: events[fork][i].center.dy,
            )
          );
        }
      }
      totalDuration += (events[fork][0].begin - baseBegin);
      double branchHeight = Utils.durationToLength(context, vertexSize, totalDuration) + vertexSize * events[fork].length;
      if (branchHeight > height) height = branchHeight;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: stackChildren,
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var fakeData = [
      [3600 * 1 + 1565073447 + 8 * 3600, 10800, "开会"],
      [3600 * 2 + 1565073447 + 8 * 3600, 10800, "听讲座"],
      [3600 * 3 + 1565073447 + 8 * 3600, 3600, "复习自动机"],
      [3600 * 4 + 1565073447 + 8 * 3600, 3600, "游泳健身"],
      [3600 * 5 + 1565073447 + 8 * 3600, 7200, "买奶茶"],
      [3600 * 6 + 1565073447 + 8 * 3600, 7200, "约会"],
    ];
    
    return Scaffold(
      body: Listener(
        child: Center(
          child: getDAG(fakeData),
        ),
        onPointerMove: (e) {
          setState(() {
            now = DateTime.now();
          });
        },
      )
    );
  }
}
