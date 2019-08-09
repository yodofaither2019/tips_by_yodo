// Widget getEvent(int beginTime, int duration, String title, {bool fork: false}) {
//     Duration diff = Duration(hours: 1);
//     bool finished = false;
//     if (beginTime != -1){
//       diff = now.add(Duration(hours: 8)).difference(DateTime.fromMillisecondsSinceEpoch(beginTime * 1000));
//       finished = diff.inSeconds > 0;
//     }
//     vertexSize = MediaQuery.of(context).size.width / 19;
//     edgeLength = Utils.durationToLength(context, vertexSize, duration);
//     Widget vertex = Stack(
//       alignment: AlignmentDirectional.center,
//       children: <Widget>[
//         StyleConfig.getCircleSurface(vertexSize, vertexSize, finished ? ColorConfig.finishedEvent : ColorConfig.todoEvent),
//         StyleConfig.getCircleSurface(vertexSize - 5, vertexSize - 5, finished ? ColorConfig.todoEvent : ColorConfig.edges),
//       ],
//     );

//     Widget edge = Container(
//       width: 0.0,
//       height: edgeLength,
//       margin: EdgeInsets.only(top: vertexSize),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorConfig.edges
//         )
//       ),
//     );
//     var ratio = diff.inSeconds / duration;
//     if (diff.inSeconds > 0 && diff.inSeconds < 60) {
//       setState(() {
//         nowTimeRepeat = 1;
//       });
//     } else if (ratio > 1) {
//       ratio = 1;
//       setState(() {
//         nowTimeRepeat = -1;
//       });
//     } else if (ratio < 0) {
//       ratio = 0;
//       setState(() {
//         nowTimeRepeat = -1;
//       });
//     } else if (edgeLength * ratio < vertexSize) {
//       ratio = vertexSize / edgeLength;
//     }
//     Widget doneEdge = Container(
//       width: 0.0,
//       height: edgeLength * ratio,
//       margin: EdgeInsets.only(top: vertexSize),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorConfig.finishedEvent
//         )
//       ),
//     );

//     Widget nowTime;
//     if (nowTimeRepeat != 1 && ratio > 0 && ratio < 1) {
//       setState(() {
//         nowTimeRepeat = 0;
//       });
//       nowTime = Container(
//         margin: EdgeInsets.only(left: vertexSize * 2, bottom: edgeLength - vertexSize / 4, top: vertexSize / 2 + edgeLength * ratio),
//         child: Row(
//           children: <Widget>[
//             Text(
//               Utils.timeStampToTime(now.add(Duration(hours: 8)).millisecondsSinceEpoch ~/ 1000),
//               style: TextStyle(
//                 color: ColorConfig.currentTime,
//                 fontSize: vertexSize,
//               ),
//             ),
//             Icon(
//               Icons.arrow_right,
//               color: ColorConfig.currentTime,
//             )
//           ],
//         )
//       );
//     }

//     Widget event;

//     if (!fork) {
//       event = Stack(
//         alignment: AlignmentDirectional.topCenter,
//         children: [edge, doneEdge, vertex],
//       );
//     } else {
//       event = Stack(
//         alignment: AlignmentDirectional.topCenter,
//         children: [vertex],
//       );
//     }

//     List<Widget> children = [
//         Container(
//           child: event,
//           margin: EdgeInsets.only(left: vertexSize * 6, top: vertexSize / 4),
//         ),
//         Container(
//           margin: EdgeInsets.only(left: vertexSize * 8, bottom: edgeLength - vertexSize / 2),
//           child: Container(
//             child: Text(
//               title,
//               style: TextStyle(
//                 color: ColorConfig.eventTitle,
//                 fontSize: vertexSize,
//               ),
//             ),
//           )
//         ),
//         Container(
//           margin: EdgeInsets.only(left: vertexSize * 2, bottom: edgeLength - vertexSize / 4, top: vertexSize / 6),
//           child: Text(
//             beginTime == -1 ? "" : Utils.timeStampToTime(beginTime),
//             style: TextStyle(
//               color: nowTimeRepeat == 1 ? ColorConfig.currentTime : ColorConfig.eventTitle,
//               fontSize: vertexSize,
//             ),
//           ),
//         ),
//     ];
//     if (nowTimeRepeat == 0)
//       children.add(nowTime);
//     Widget titledEvent = Stack(
//       alignment: AlignmentDirectional.topStart,
//       children: children,
//     );
//     return titledEvent;
//   }
