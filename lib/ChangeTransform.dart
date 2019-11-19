import 'package:flutter/material.dart';
import 'dart:math' as math;

/**
 * 1.变化 Transform可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效
 * 2.Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子组件应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的
 */

class ChangeTransform extends StatefulWidget {
  _ChangeTransform createState() => new _ChangeTransform();
}

class _ChangeTransform extends State<ChangeTransform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("变化Transform"),
      ),
//      body: _Matrix4(),
//      body: _Translation(),
//      body: _rotate(),
//      body: _scale(),
      body: _RotatedBox(),
//      body: _rotate2(),
    );
  }
}

///Matrix4是一个4D矩阵，通过它我们可以实现各种矩阵操作
_Matrix4() {
  return Center(
    child: Container(
      color: Colors.black,
      child: new Transform(
        alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
        transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
        child: new Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.deepOrange,
          child: const Text('Apartment for rent!'),
        ),
      ),
    ),
  );
}

///平移
_Translation() {
  return Center(
    child: DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
      //默认原点为左上角，左移20像素，向上平移5像素
      child: Transform.translate(
        offset: Offset(20.0, 5.0),
        child: Text("Hello world"),
      ),
    ),
  );
}

///旋转
_rotate() {
  return Center(
    child: DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
      child: Transform.rotate(
        //旋转90度
        angle: math.pi / 2,
        child: Text("Hello world"),
      ),
    ),
  );
}

///缩放
_scale() {
  return Center(
    child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Transform.scale(
            scale: 1.5, //放大到1.5倍
            child: Text("Hello world"))),
  );
}

///RotatedBox:RotatedBox和Transform.rotate功能相似，它们都可以对子组件进行旋转变换，但是有一点不同：RotatedBox的变换是在layout阶段，会影响在子组件的位置和大小
_RotatedBox() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: RotatedBox(
          quarterTurns: 1, //旋转90度(1/4圈)
          child: Text("Hello world"),
        ),
      ),
      Text(
        "你好",
        style: TextStyle(color: Colors.green, fontSize: 18.0),
      )
    ],
  );
}

_rotate2() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Transform.rotate(
          angle: math.pi / 2,
          child: Text("Hello world"),
        ),
      ),
      Text(
        "你好",
        style: TextStyle(color: Colors.green, fontSize: 18.0),
      )
    ],
  );
}
