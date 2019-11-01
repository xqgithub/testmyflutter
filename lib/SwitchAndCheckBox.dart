import 'package:flutter/material.dart';

/**
 * 单选开关和复选框
 */

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  _SwitchAndCheckBoxTestRouteState createState() =>
      new _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("单选开关和复选框"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///单选开关
            new Container(
              child: Switch(
                value: _switchSelected,
                onChanged: (value1) {
                  setState(() {
                    _switchSelected = value1;
                  });
                },
              ),
            ),

            ///复选框
            new Container(
              child: new Checkbox(
                value: _checkboxSelected,
                activeColor: Colors.red,
                onChanged: (value1) {
                  setState(() {
                    _checkboxSelected = value1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
