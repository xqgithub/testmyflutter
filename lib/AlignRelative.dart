import 'package:flutter/material.dart';

/**
 * 对齐相对定位
 */

class AlignRelative extends StatefulWidget {
  _AlignRelative createState() => new _AlignRelative();
}

class _AlignRelative extends State<AlignRelative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("对齐相对定位"),
        ),
        body: Container(
//          height: 120.0,
//          width: 120.0,
          color: Colors.blue[50],
          child: Align(
            ///不显式指定宽高，而通过同时指定widthFactor和heightFactor 为2 等同于 Container height和width 赋值
            widthFactor: 2,
            heightFactor: 2,
            alignment: Alignment.topRight,

            ///Alignment 偏移公式：(Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight+childHeight/2)
            ///FractionalOffset 偏移公式：(FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)

            child: FlutterLogo(
              size: 60,
            ),
          ),
        ));
  }
}
