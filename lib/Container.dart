import 'package:flutter/material.dart';

/**
 * Container 容器
 * Container是一个组合类容器，它本身不对应具体的RenderObject，它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器
 * 所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景
 */

class TestContainer extends StatefulWidget {
  _TestContainer createState() => new _TestContainer();
}

class _TestContainer extends State<TestContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container 容器"),
      ),
//      body: _test1(),
      body: _test2(),
    );
  }
}

///5.20卡片
_test1() {
  return Container(
    margin: EdgeInsets.only(top: 50.0, left: 120.0),
    //容器外填充
    constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
    //卡片大小
    decoration: BoxDecoration(
      //背景装饰
      gradient: RadialGradient(
        //背景径向渐变
        colors: [Colors.red, Colors.orange],
        center: Alignment.topLeft,
        radius: 0.98,
      ),
      boxShadow: [
        //卡片阴影
        BoxShadow(
          color: Colors.black54,
          offset: Offset(2.0, 2.0),
          blurRadius: 4.0,
        ),
      ],
    ),
    //卡片倾斜变换
    transform: Matrix4.rotationZ(.2),
    alignment: Alignment.center,
    //卡片内文字居中
    child: Text(
      //卡片文字
      "5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),
    ),
  );
}

///margin和padding属性的区别
_test2() {
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(20.0), //容器外补白
        color: Colors.orange,
        child: Text("Hello world!"),
      ),
      Container(
        padding: EdgeInsets.all(20.0), //容器内补白
        color: Colors.orange,
        child: Text("Hello world!"),
      ),
    ],
  );
}
