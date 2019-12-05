import 'package:flutter/material.dart';

/**
 * 动画
 */

/************* 动画缩放和监听 Start *************/

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

///需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
        duration: const Duration(seconds: 1), vsync: this);

    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(animation);

    //监听动画状态
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画"),
      ),
//      body: AnimatedImage(
//        animation: animation,
//      ),
      body: GrowTransition(
        child: Image.asset("assets/images/lufei.jpg"),
        animation: animation,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //路由销毁时需要释放动画资源
    controller.dispose();
  }
}

///使用AnimatedWidget简化  addListener()和setState() 操作
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "assets/images/lufei.jpg",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

///通过AnimatedBuilder重构
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

/************* 动画缩放和监听 end *************/

/************* 自定义路由切换动画 start *************/

///PageRouteBuilder
class animation_route extends PageRouteBuilder {
  final Widget widget;

  animation_route(this.widget)
      : super(
            transitionDuration: const Duration(milliseconds: 500), //设置动画时长500毫秒
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              //渐变过渡
//      return FadeTransition(//渐变过渡 0.0-1.0
//        opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//          parent: animation1, //动画样式
//          curve: Curves.fastOutSlowIn, //动画曲线
//        )),
//        child: child,
//      );
              //翻转缩放
//      return RotationTransition(
//        turns: Tween(begin: 0.0, end: 1.0).
//        animate(
//          CurvedAnimation(
//            parent: animation1,
//            curve: Curves.fastOutSlowIn,
//          )
//        ),
//        child: ScaleTransition(
//          scale: Tween(begin: 0.0, end: 1.0).
//          animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
//          child: child,
//        ),
//      );
              //左右滑动
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(-1.0, 0.0),
                  end: Offset(0.0, 0.0),
                ).animate(
                  CurvedAnimation(
                    parent: animation1,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                child: child,
              );
            });
}

///PageRoute
class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}

/************* 自定义路由切换动画 end *************/

/************* Hero动画 start *************/

///在Flutter中将图片从一个路由“飞”到另一个路由称为hero动画
class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero动画"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: InkWell(
          child: Hero(
            tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
            child: ClipOval(
              child: Image.asset(
                "assets/images/lufei.jpg",
                height: 50.0,
                width: 50.0,
              ),
            ),
          ),
          onTap: () {
            //打开路由
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return FadeTransition(
                    //渐隐渐入过渡
                    opacity: animation,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text("原图"),
                      ),
                      body: HeroAnimationRouteB(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.asset("assets/images/lufei.jpg"),
      ),
    );
  }
}

/************* Hero动画 end *************/

/************* 交织动画 start *************/
class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  Animation<double> height;
  Animation<Color> color;
  Animation<EdgeInsets> padding;

  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    //高度动画
    height = Tween<double>(
      begin: .0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          //间隔，前60%的动画时间
          0.0,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );

    //颜色动画
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    //平移动画
    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}

class StaggerRoute extends StatefulWidget {
  @override
  _StaggerRouteState createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("交织动画"),
      ),
      body: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _playAnimation();
          },
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            //调用我们定义的交织动画Widget
            child: StaggerAnimation(
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}

/************* 交织动画 end *************/

/************* 通用"切换动画"组件 start *************/
class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通用切换动画组件"),
      ),

      ///AnimatedSwitcher 使用方法
//      body: Center(
//        child: Column(
//          children: <Widget>[
//            AnimatedSwitcher(
//              duration: const Duration(milliseconds: 500),
//              transitionBuilder: (Widget child, Animation<double> animation) {
//                //执行缩放动画
//                return ScaleTransition(child: child, scale: animation);
//              },
//              child: Text(
//                "$_count",
//                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
//                key: ValueKey<int>(_count),
//                style: Theme.of(context).textTheme.display1,
//              ),
//            ),
//            RaisedButton(
//              child: const Text(
//                '+1',
//              ),
//              onPressed: () {
//                setState(() {
//                  _count += 1;
//                });
//              },
//            ),
//          ],
//        ),
//      ),
      ///实现左出右进动画
//      body: Center(
//        child: Column(
//          children: <Widget>[
//            AnimatedSwitcher(
//              duration: Duration(milliseconds: 200),
//              transitionBuilder: (Widget child, Animation<double> animation) {
//                var tween =
//                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
//                return MySlideTransition(
//                  child: child,
//                  position: tween.animate(animation),
//                );
//              },
//              child: Text(
//                "$_count",
//                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
//                key: ValueKey<int>(_count),
//                style: Theme.of(context).textTheme.display1,
//              ),
//            ),
//            RaisedButton(
//              child: const Text('+1'),
//              onPressed: () {
//                setState(() {
//                  _count += 1;
//                });
//              },
//            ),
//          ],
//        ),
//      ),

      ///根据配置实现动画
      body: Center(
        child: Column(
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween =
                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                return SlideTransitionX(
                  child: child,
                  direction: AxisDirection.down, //上入下出
                  position: animation,
                );
              },
              child: Text(
                "$_count",
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            RaisedButton(
              child: const Text('+1'),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

///MySlideTransition 从左边滑出，从右边进入
class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

///实现“右入左出”、“上入下出”或者 “下入上出”
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

/************* 通用"切换动画"组件 end *************/

/************* Flutter预置的动画过渡组件 start *************/

class AnimatedWidgetsTest extends StatefulWidget {
  @override
  _AnimatedWidgetsTestState createState() => _AnimatedWidgetsTestState();
}

class _AnimatedWidgetsTestState extends State<AnimatedWidgetsTest> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 5);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                _padding = 20;
              });
            },
            child: AnimatedPadding(
              duration: duration,
              padding: EdgeInsets.all(_padding),
              child: Text("AnimatedPadding"),
            ),
          ),
          SizedBox(
            height: 50,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: duration,
                  left: _left,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _left = 100;
                      });
                    },
                    child: Text("AnimatedPositioned"),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: AnimatedAlign(
              duration: duration,
              alignment: _align,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _align = Alignment.center;
                  });
                },
                child: Text("AnimatedAlign"),
              ),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            height: _height,
            color: _color,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _height = 150;
                  _color = Colors.blue;
                });
              },
              child: Text(
                "AnimatedContainer",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          AnimatedDefaultTextStyle(
            child: GestureDetector(
              child: Text("hello world"),
              onTap: () {
                setState(() {
                  _style = TextStyle(
                    color: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blue,
                  );
                });
              },
            ),
            style: _style,
            duration: duration,
          ),
        ].map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: e,
          );
        }).toList(),
      ),
    );
  }
}

/************* Flutter预置的动画过渡组件 end *************/
