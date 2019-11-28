import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/**
 * 事件处理与通知
 */

/************* 原始指针事件处理 start *************/

class TestPointerEvent extends StatefulWidget {
  _TestPointerEvent createState() => new _TestPointerEvent();
}

class _TestPointerEvent extends State<TestPointerEvent> {
  //定义一个状态，保存当前指针位置
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("原始指针事件PointerEvent"),
        backgroundColor: Colors.red,
      ),

      ///使用Listener来监听原始触摸事件
//      body: Listener(
//        child: Container(
//          alignment: Alignment.center,
//          color: Colors.blue,
//          width: 300.0,
//          height: 150.0,
//          child: Text(_event?.toString() ?? "",
//              style: TextStyle(color: Colors.white)),
//        ),
//        onPointerDown: (PointerDownEvent event) =>
//            setState(() => _event = event),
//        onPointerMove: (PointerMoveEvent event) =>
//            setState(() => _event = event),
//        onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
//      ),
//      body: _TestTestPointerEvent2(),
      body: _TestTestPointerEvent3(),
    );
  }
}

///behavior属性，它决定子组件如何响应命中测试
_TestTestPointerEvent2() {
  return Stack(
    children: <Widget>[
      Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(300.0, 200.0)),
          child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
        ),
        onPointerDown: (event) => print("down0"),
      ),
      Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(200.0, 100.0)),
          child: Center(
            child: Text("左上角200*100范围内非文本区域点击"),
          ),
        ),
        onPointerDown: (event) => print("down1"),
        behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
//        behavior: HitTestBehavior.opaque, //将当前组件当成不透明处理(即使本身是透明的)
      )
    ],
  );
}

///忽略PointerEvent
_TestTestPointerEvent3() {
  return Listener(
    child: AbsorbPointer(
      child: Listener(
        child: Container(
          color: Colors.red,
          width: 200.0,
          height: 100.0,
        ),
        onPointerDown: (event) => print("in"),
      ),
    ),
    onPointerDown: (event) => print("up"),
  );
}

/************* 原始指针事件处理 end *************/

/************* 手势识别 start *************/

class TestGestureDetector extends StatefulWidget {
  _TestGestureDetector createState() => new _TestGestureDetector();
}

class _TestGestureDetector extends State<TestGestureDetector> {
  String _operation = "No Gesture detected!"; //保存事件名

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }

  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手势识别"),
      ),

      ///点击、双击、长按
//      body: Center(
//        child: GestureDetector(
//          child: Container(
//            alignment: Alignment.center,
//            color: Colors.blue,
//            width: 200.0,
//            height: 100.0,
//            child: Text(
//              _operation,
//              style: TextStyle(color: Colors.white),
//            ),
//          ),
//          onTap: () => updateText("Tap"), //点击
//          onDoubleTap: () => updateText("DoubleTap"), //双击
//          onLongPress: () => updateText("LongPress"), //长按
//        ),
//      ),

      /// 拖动、滑动
//      body: Stack(
//        children: <Widget>[
//          Positioned(
//            top: _top,
//            left: _left,
//            child: GestureDetector(
//              child: CircleAvatar(child: Text("A")),
//              //手指按下时会触发此回调
//              onPanDown: (DragDownDetails e) {
//                //打印手指按下的位置(相对于屏幕)
//                print("用户手指按下：${e.globalPosition}");
//              },
//
//              //手指滑动时会触发此回调
//              onPanUpdate: (DragUpdateDetails e) {
//                //用户手指滑动时，更新偏移，重新构建
//                setState(() {
//                  _left += e.delta.dx;
//                  _top += e.delta.dy;
//                });
//              },
//
//              onPanEnd: (DragEndDetails e) {
//                //打印滑动结束时在x、y轴上的速度
//                print(e.velocity);
//              },
//            ),
//          ),
//        ],
//      ),

      ///单一方向拖动,垂直
//      body: Stack(
//        children: <Widget>[
//          Positioned(
//            top: _top,
//            child: GestureDetector(
//              child: CircleAvatar(child: Text("A")),
//              //垂直方向拖动事件
//              onVerticalDragUpdate: (DragUpdateDetails details) {
//                setState(() {
//                  _top += details.delta.dy;
//                });
//              },
//            ),
//          ),
//        ],
//      ),

      ///缩放
      body: Center(
        child: GestureDetector(
          //指定宽度，高度自适应
          child: Image.asset("assets/images/lufei.jpg", width: _width),
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              //缩放倍数在0.8到10倍之间
              _width = 200 * details.scale.clamp(.8, 10.0);
            });
          },
        ),
      ),
    );
  }
}

///GestureRecognizer
class TestGestureRecognizer extends StatefulWidget {
  _TestGestureRecognizer createState() => new _TestGestureRecognizer();
}

class _TestGestureRecognizer extends State<TestGestureRecognizer> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手势识别 GestureRecognizer"),
      ),
      body: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "你好世界"),
              TextSpan(
                text: "点我变色",
                style: TextStyle(
                  fontSize: 25.0,
                  color: _toggle ? Colors.blue : Colors.red,
                ),
                recognizer: _tapGestureRecognizer
                  ..onTap = () {
                    setState(() {
                      _toggle = !_toggle;
                    });
                  },
              ),
              TextSpan(text: "你好世界"),
            ],
          ),
        ),
      ),
    );
  }
}

///手势竞争与冲突
class BothDirectionTestRoute extends StatefulWidget {
  @override
  BothDirectionTestRouteState createState() =>
      new BothDirectionTestRouteState();
}

class BothDirectionTestRouteState extends State<BothDirectionTestRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手势竞争与冲突"),
      ),

      ///手势竞争
//      body: Stack(
//        children: <Widget>[
//          Positioned(
//            top: _top,
//            left: _left,
//            child: GestureDetector(
//              child: CircleAvatar(child: Text("A")),
//              //垂直方向拖动事件
//              onVerticalDragUpdate: (DragUpdateDetails details) {
//                setState(() {
//                  _top += details.delta.dy;
//                });
//              },
//              onHorizontalDragUpdate: (DragUpdateDetails details) {
//                setState(() {
//                  _left += details.delta.dx;
//                });
//              },
//            ),
//          ),
//        ],
//      ),

      ///手势冲突，通过Listener直接识别原始指针事件来解决冲突
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _left,
            child: Listener(
              onPointerDown: (details) {
                print("down");
              },
              onPointerUp: (details) {
                //会触发
                print("up");
              },
              child: GestureDetector(
                child: CircleAvatar(child: Text("A")),
                //要拖动和点击的widget
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  print("onHorizontalDragEnd");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/************* 手势识别 end *************/

/************* Notification start *************/

class TestNotification extends StatefulWidget {
  @override
  _TestNotification createState() => new _TestNotification();
}

class _TestNotification extends State<TestNotification> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通知Notification"),
      ),
//      body: _TestNotification1(),
//      body: _TestNotification2(),

      ///自定义通知
//      body: NotificationListener<MyNotification>(
//        onNotification: (notification) {
//          setState(() {
//            _msg += notification.msg + "  ";
//          });
//          return true;
//        },
//        child: Center(
//          child: Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Builder(
//                builder: (context) {
//                  return RaisedButton(
//                    onPressed: () => MyNotification("哇哈哈").dispatch(context),
//                    child: Text("Send Notification"),
//                  );
//                },
//              ),
//              Text(_msg),
//            ],
//          ),
//        ),
//      ),

      ///阻止冒泡
      body: NotificationListener<MyNotification>(
        onNotification: (notification) {
          print(notification.msg); //打印通知
          return true;
        },
        child: NotificationListener<MyNotification>(
          onNotification: (notification) {
            setState(() {
              _msg += notification.msg + "  ";
            });
            return true;
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    return RaisedButton(
                      onPressed: () => MyNotification("哇哈哈").dispatch(context),
                      child: Text("Send Notification"),
                    );
                  },
                ),
                Text(_msg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///ListView的通知监听
_TestNotification1() {
  return NotificationListener(
    ///onNotification 返回值类型为布尔值，当返回值为true时，阻止冒泡，其父级Widget将再也收不到该通知；当返回值为false 时继续向上冒泡通知
    onNotification: (notification) {
      switch (notification.runtimeType) {
        case ScrollStartNotification:
          print("开始滚动");
          break;
        case ScrollUpdateNotification:
          print("正在滚动");
          break;
        case ScrollEndNotification:
          print("滚动停止");
          break;
        case OverscrollNotification:
          print("滚动到边界");
          break;
      }
      return true;
    },
    child: ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("$index"),
        );
      },
    ),
  );
}

///指定通知类型
_TestNotification2() {
  //指定监听通知的类型为滚动结束通知(ScrollEndNotification)
  return NotificationListener<ScrollEndNotification>(
    onNotification: (notification) {
      //只会在滚动结束时才会触发此回调
      print(notification);
    },
    child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("$index"),
          );
        }),
  );
}

///自定义通知
class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}
/************* Notification end *************/
