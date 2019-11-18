import 'package:flutter/material.dart';

/**
 * 层叠布局
 */

class StackPositioned extends StatefulWidget {
  _StackPositioned createState() => new _StackPositioned();
}

class _StackPositioned extends State<StackPositioned> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("层叠布局"),
      ),

      ///通过ConstrainedBox来确保Stack占满屏幕
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          children: <Widget>[
            Container(
              child: Text(
                "Hello world",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              color: Colors.red,
            ),
            Positioned(
              left: 18.0,
              child: Text(
                "I am Jack",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Positioned(
              top: 18.0,
              child: Text(
                "Your friend",
                style: TextStyle(fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
