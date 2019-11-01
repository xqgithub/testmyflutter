import 'package:flutter/material.dart';

/**
 * 按钮分类
 */

class ButtonType extends StatefulWidget {
  @override
  _ButtonTypeState createState() => new _ButtonTypeState();
}

class _ButtonTypeState extends State<ButtonType> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("按钮分类"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///RaisedButton 按钮
            new Container(
              width: 200.0,
              height: 50.0,
              child: new RaisedButton(
                child: new Text(
                  "RaisedButton",
                  style: new TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  print("漂浮按钮，它默认带有阴影和灰色背景。按下后，阴影会变大");
                },
                color: Colors.red,
              ),
            ),

            ///FlatButton 按钮
            new Container(
              width: 200.0,
              height: 50.0,
              margin: EdgeInsets.only(top: 10.0),
              child: new FlatButton(
                child: new Text(
                  "FlatButton",
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  print("扁平按钮，默认背景透明并不带阴影。按下后，会有背景色");
                },
                color: Colors.blue,
              ),
            ),

            ///OutlineButton 按钮
            new Container(
              width: 200.0,
              height: 50.0,
              margin: EdgeInsets.only(top: 10.0),
              child: new OutlineButton(
                child: new Text(
                  "OutlineButton",
                  style: new TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  print("默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)");
                },
                color: Colors.amber,
              ),
            ),

            ///RaisedButton.icon 带有图标按钮
            new Container(
              width: 200.0,
              height: 50.0,
              margin: EdgeInsets.only(top: 10.0),
              child: new RaisedButton.icon(
                onPressed: () {
                  print("带图标的按钮");
                },
                icon: new Icon(Icons.send),
                label: new Text(
                  "RaisedButton发送",
                  style: new TextStyle(fontSize: 16.0),
                ),
              ),
            ),

            ///自定义按钮
            new Container(
              width: 200.0,
              height: 50.0,
              margin: EdgeInsets.only(top: 15.0),
              child: new FlatButton(
                onPressed: () {
                  print("这是一个自定义样式的按钮");
                },
                child: new Text(
                  "自定义样式",
                  style: new TextStyle(fontSize: 20.0),
                ),
                color: Colors.amber,
                highlightColor: Colors.red[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: new BorderSide(
                    color: Colors.indigoAccent,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
