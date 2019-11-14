import 'package:flutter/material.dart';

/**
 * 流式布局
 */
class WrapDemo extends StatefulWidget {
  _WrapDemo createState() => new _WrapDemo();
}

class _WrapDemo extends State<WrapDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wrap"),
      ),
      body: Wrap(
        spacing: 8.0, // 主轴(水平)方向间距
        runSpacing: 4.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center, //沿主轴方向居中
        children: <Widget>[
          ///Chip一般也是用作商品或者一些东西的标签
          new Chip(
            avatar:
                CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
            label: Text('Hamilton'),
          ),

          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.blue, child: Text('M')),
            label: new Text('Lafayette'),
          ),
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.blue, child: Text('H')),
            label: new Text('Mulligan'),
          ),
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.blue, child: Text('J')),
            label: new Text('Laurens'),
          ),
        ],
      ),
    );
  }
}

///般很少会使用Flow,Flow主要用于一些需要自定义布局策略或性能要求较高(如动画中)的场景
class FlowDemo extends StatefulWidget {
  _FlowDemo createState() => new _FlowDemo();
}

class _FlowDemo extends State<FlowDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flow"),
      ),
      body: Flow(
        delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
        children: <Widget>[
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.red,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.green,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.blue,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.yellow,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.brown,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
///自定义 指定父容器大小或实现
class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
