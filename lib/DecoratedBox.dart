import 'package:flutter/material.dart';

/**
 * 装饰容器
 */

class DecoratedBoxTemp extends StatefulWidget {
  _DecoratedBoxTemp createState() => new _DecoratedBoxTemp();
}

class _DecoratedBoxTemp extends State<DecoratedBoxTemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("装饰容器DecoratedBox"),
      ),

      ///通过BoxDecoration我们实现了一个渐变按钮的外观
      body: DecoratedBox(
          decoration: BoxDecoration(

              ///LinearGradient渐变类
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.orange[700]]), //背景渐变
              borderRadius: BorderRadius.circular(3.0), //3像素圆角
              boxShadow: [
                //阴影
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
