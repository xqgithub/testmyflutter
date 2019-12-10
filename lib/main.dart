library crashy;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testmyflutter/AlignRelative.dart';
import 'package:testmyflutter/Animation.dart';
import 'package:testmyflutter/ButtonType.dart';
import 'package:testmyflutter/ChangeTransform.dart';
import 'package:testmyflutter/ClipTestRoute.dart';
import 'package:testmyflutter/Container.dart';
import 'package:testmyflutter/CountInstance.dart';
import 'package:testmyflutter/CustomizeComponent.dart';
import 'package:testmyflutter/DartTransferPlatform.dart';
import 'package:testmyflutter/DecoratedBox.dart';
import 'package:testmyflutter/EventAndNotification.dart';
import 'package:testmyflutter/FunctionalComponent.dart';
import 'package:testmyflutter/ImageAndIcon.dart';
import 'package:testmyflutter/InputBoxAndForm.dart';
import 'package:testmyflutter/LoadAssets.dart';
import 'package:testmyflutter/RoutePassValue.dart';
import 'package:testmyflutter/RowAndColumn.dart';
import 'package:testmyflutter/ScaffoldAndTabBar.dart';
import 'package:testmyflutter/ScrollableComponent.dart';
import 'package:testmyflutter/StackPositioned.dart';
import 'package:testmyflutter/StateLifeCycle.dart';
import 'package:testmyflutter/SwitchAndCheckBox.dart';
import 'package:testmyflutter/WidgetManageStatus.dart';
import 'package:testmyflutter/WrapAndFlow.dart';
import 'package:testmyflutter/flex.dart';

import 'ProgressIndicator.dart';
import 'SizeLimitContainer.dart';

//void main() => runApp(MyApp());

bool get isInDebugMode {
  bool inDebugMode = true;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');
  if (isInDebugMode) {
    print(stackTrace);
    print('In dev mode. Not sending report to Sentry.io.');
    return;
  }
}

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
  runZoned<Future<Null>>(() async {
    runApp(new MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'demo列表',
      theme: new ThemeData(primaryColor: Colors.white),
      //注册路由表
      routes: {
        //首页用/命名
        "/": (context) => Directory(),
        "CountInstance": (context) => CountInstanceless(),
        "EchoRoute": (context) => EchoRoute(),
        "TipRoute": (context) =>
            TipRoute(text: ModalRoute.of(context).settings.arguments),
        "LoadAssets": (context) => LoadAssets(),
        "CounterWidget": (context) => CounterWidget(),
        "TapboxA": (context) => TapboxA(),
        "ParentWidget=>TapboxB": (context) => ParentWidget(),
        "TapboxC": (context) => ParentWidgetC(),
        "ButtonType": (context) => ButtonType(),
        "ImageAndIcon": (context) => ImageAndIcon(),
        "SwitchAndCheckBoxTestRoute": (context) => SwitchAndCheckBoxTestRoute(),
        "InputBox": (context) => InputBox(),
        "TextForm": (context) => TextForm(),
        "ProgressRoute": (context) => ProgressRoute(),
        "RowAndColumn": (context) => RowAndColumn(),
        "resilience": (context) => resilience(),
        "WrapDemo": (context) => WrapDemo(),
        "FlowDemo": (context) => FlowDemo(),
        "StackPositioned": (context) => StackPositioned(),
        "AlignRelative": (context) => AlignRelative(),
        "SizeLimitContainer": (context) => SizeLimitContainer(),
        "DecoratedBoxTemp": (context) => DecoratedBoxTemp(),
        "ChangeTransform": (context) => ChangeTransform(),
        "TestContainer": (context) => TestContainer(),
        "TestScaffold": (context) => TestScaffold(),
        "ClipTestRoute": (context) => ClipTestRoute(),
        "TestScrollable": (context) => TestScrollable(),
        "InfiniteListView": (context) => InfiniteListView(),
        "InfiniteGridView": (context) => InfiniteGridView(),
        "CustomScrollViewTestRoute": (context) => CustomScrollViewTestRoute(),
        "ScrollControllerTestRoute": (context) => ScrollControllerTestRoute(),
        "ScrollNotificationTestRoute": (context) =>
            ScrollNotificationTestRoute(),
        "TestFunctionalComponent": (context) => TestFunctionalComponent(),
        "InheritedWidgetTestRoute": (context) => InheritedWidgetTestRoute(),
        "ProviderRoute": (context) => ProviderRoute(),
        "ThemeTestRoute": (context) => ThemeTestRoute(),
        "TestAlertDialog": (context) => TestAlertDialog(),
        "TestPointerEvent": (context) => TestPointerEvent(),
        "TestGestureDetector": (context) => TestGestureDetector(),
        "TestGestureRecognizer": (context) => TestGestureRecognizer(),
        "BothDirectionTestRoute": (context) => BothDirectionTestRoute(),
        "TestNotification": (context) => TestNotification(),
        "ScaleAnimationRoute": (context) => ScaleAnimationRoute(),
        "HeroAnimationRoute": (context) => HeroAnimationRoute(),
        "StaggerRoute": (context) => StaggerRoute(),
        "TestDartTransferPlatform": (context) => TestDartTransferPlatform(),
        "AnimatedSwitcherCounterRoute": (context) =>
            AnimatedSwitcherCounterRoute(),
        "AnimatedWidgetsTest": (context) => AnimatedWidgetsTest(),
        "GradientButtonRoute": (context) => GradientButtonRoute(),
        "TurnBoxRoute": (context) => TurnBoxRoute(),
        "CustomPaintRoute": (context) => CustomPaintRoute(),
        "GradientCircularProgressRoute": (context) =>
            GradientCircularProgressRoute(),
      },
      //如果路由表中没有注册，才会调用
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        String routeName = settings.name;
//        print("路由名字: $routeName");
        if (routeName == "RoutePassValue") {
          builder = (BuildContext context) => new RoutePassValue();
        } else {
          builder = (BuildContext context) => Directory();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

///列表的Widget
class Directory extends StatefulWidget {
  createState() => new _DirectoryState();
}

///列表Widget实现
class _DirectoryState extends State<Directory> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Center(
          child: new Text('第一个demo列表'),
        ),
      ),
      body: _getListData(context),
    );
  }
}

///创建一个listview
_getListData(BuildContext context) {
  final _fontSize = const TextStyle(fontSize: 18.0, color: Colors.amber);
  //下划线widget预定义以供复用。
  Widget divider1 = Divider(
    color: Colors.black,
  );
  var _name = new List();
  _name.add("计数实例");
  _name.add("非命令路由传值");
  _name.add("命令路由传值");
  _name.add("加载assets内容");
  _name.add("错误提示");
  _name.add("State的生命周期");
  _name.add("Widget管理自身状态");
  _name.add("父Widget管理子Widget的状态");
  _name.add("混合状态管理");
  _name.add("按钮分类");
  _name.add("图片及ICON");
  _name.add("单选开关和复选框");
  _name.add("输入框");
  _name.add("输入框验证");
  _name.add("进度指示器");
  _name.add("线性布局");
  _name.add("弹性布局");
  _name.add("Wrap布局");
  _name.add("Flow布局");
  _name.add("层叠布局");
  _name.add("对齐、相对定位");
  _name.add("尺寸限制类容器");
  _name.add("装饰容器DecoratedBox");
  _name.add("变换Transform");
  _name.add("Container 容器");
  _name.add("Scaffold、TabBar、底部导航");
  _name.add("剪裁（Clip）");
  _name.add("可滚动组件");
  _name.add("ListView无限加载列表");
  _name.add("GridView无限加载列表");
  _name.add("CustomScrollView");
  _name.add("滚动监听及控制ScrollController");
  _name.add("滚动监听及控制NotificationListener");
  _name.add("功能型Widget简介");
  _name.add("数据共享（InheritedWidget）");
  _name.add("数据共享（Provider）");
  _name.add("主题颜色切换");
  _name.add("对话框详解");
  _name.add("原始指针事件处理");
  _name.add("手势识别GestureDetector");
  _name.add("手势识别GestureRecognizer");
  _name.add("手势竞争与冲突");
  _name.add("通知Notification");
  _name.add("动画缩放和监听");
  _name.add("动画Hero");
  _name.add("交织动画");
  _name.add("Android原生和flutter数据交互");
  _name.add("通用切换动画组件");
  _name.add("Flutter预置的动画过渡组件");
  _name.add("自定义渐变按钮");
  _name.add("组合实例：TurnBox");
  _name.add("自绘组件 （CustomPaint与Canvas）");
  _name.add("自绘实例：圆形背景渐变进度条");

  return new ListView.builder(
    scrollDirection: Axis.vertical, //设置列表的 滑动方向
    itemCount: _name.length * 2,

    ///设置item
    itemBuilder: (BuildContext context, int i) {
      ///当时奇数的时候返回分割线
      if (i.isOdd) return divider1;

      /// 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
      /// 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
      final index = i ~/ 2;
      return Container(
        child: new ListTile(
          title: new Text(_name[index], style: _fontSize),
          onTap: () {
//            print('row $index');
            _pageJump(context, index);
          },
        ),
      );
    },
  );
}

///页面跳转
_pageJump(BuildContext context, int index) {
  if (index == 0) {
    //跳转到计数实例页面
    Navigator.pushNamed(context, "CountInstance");
  } else if (index == 1) {
//    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//      return new RoutePassValue();
//    }));

    Navigator.pushNamed(context, "RoutePassValue");

//    //动画第一种
//    Navigator.of(context).push(animation_route(RoutePassValue()));
//    //动画第二种
//    Navigator.push(context, FadeRoute(builder: (context) {
//      return RoutePassValue();
//    }));
  } else if (index == 2) {
    Navigator.pushNamed(context, "EchoRoute", arguments: "我是海贼王路飞");
  } else if (index == 3) {
    Navigator.pushNamed(context, "LoadAssets");
  } else if (index == 4) {
    _asyncexception();
  } else if (index == 5) {
    Navigator.pushNamed(context, "CounterWidget");
  } else if (index == 6) {
    Navigator.pushNamed(context, "TapboxA");
  } else if (index == 7) {
    Navigator.pushNamed(context, "ParentWidget=>TapboxB");
  } else if (index == 8) {
    Navigator.pushNamed(context, "TapboxC");
  } else if (index == 9) {
    Navigator.pushNamed(context, "ButtonType");
  } else if (index == 10) {
    Navigator.pushNamed(context, "ImageAndIcon");
  } else if (index == 11) {
    Navigator.pushNamed(context, "SwitchAndCheckBoxTestRoute");
  } else if (index == 12) {
    Navigator.pushNamed(context, "InputBox");
  } else if (index == 13) {
    Navigator.pushNamed(context, "TextForm");
  } else if (index == 14) {
    Navigator.pushNamed(context, "ProgressRoute");
  } else if (index == 15) {
    Navigator.pushNamed(context, "RowAndColumn");
  } else if (index == 16) {
    Navigator.pushNamed(context, "resilience");
  } else if (index == 17) {
    Navigator.pushNamed(context, "WrapDemo");
  } else if (index == 18) {
    Navigator.pushNamed(context, "FlowDemo");
  } else if (index == 19) {
    Navigator.pushNamed(context, "StackPositioned");
  } else if (index == 20) {
    Navigator.pushNamed(context, "AlignRelative");
  } else if (index == 21) {
    Navigator.pushNamed(context, "SizeLimitContainer");
  } else if (index == 22) {
    Navigator.pushNamed(context, "DecoratedBoxTemp");
  } else if (index == 23) {
    Navigator.pushNamed(context, "ChangeTransform");
  } else if (index == 24) {
    Navigator.pushNamed(context, "TestContainer");
  } else if (index == 25) {
    Navigator.pushNamed(context, "TestScaffold");
  } else if (index == 26) {
    Navigator.pushNamed(context, "ClipTestRoute");
  } else if (index == 27) {
    Navigator.pushNamed(context, "TestScrollable");
  } else if (index == 28) {
    Navigator.pushNamed(context, "InfiniteListView");
  } else if (index == 29) {
    Navigator.pushNamed(context, "InfiniteGridView");
  } else if (index == 30) {
    Navigator.pushNamed(context, "CustomScrollViewTestRoute");
  } else if (index == 31) {
    Navigator.pushNamed(context, "ScrollControllerTestRoute");
  } else if (index == 32) {
    Navigator.pushNamed(context, "ScrollNotificationTestRoute");
  } else if (index == 33) {
    Navigator.pushNamed(context, "TestFunctionalComponent");
  } else if (index == 34) {
    Navigator.pushNamed(context, "InheritedWidgetTestRoute");
  } else if (index == 35) {
    Navigator.pushNamed(context, "ProviderRoute");
  } else if (index == 36) {
    Navigator.pushNamed(context, "ThemeTestRoute");
  } else if (index == 37) {
    Navigator.pushNamed(context, "TestAlertDialog");
  } else if (index == 38) {
    Navigator.pushNamed(context, "TestPointerEvent");
  } else if (index == 39) {
    Navigator.pushNamed(context, "TestGestureDetector");
  } else if (index == 40) {
    Navigator.pushNamed(context, "TestGestureRecognizer");
  } else if (index == 41) {
    Navigator.pushNamed(context, "BothDirectionTestRoute");
  } else if (index == 42) {
    Navigator.pushNamed(context, "TestNotification");
  } else if (index == 43) {
    Navigator.pushNamed(context, "ScaleAnimationRoute");
  } else if (index == 44) {
    Navigator.pushNamed(context, "HeroAnimationRoute");
  } else if (index == 45) {
    Navigator.pushNamed(context, "StaggerRoute");
  } else if (index == 46) {
    Navigator.pushNamed(context, "TestDartTransferPlatform");
  } else if (index == 47) {
    Navigator.pushNamed(context, "AnimatedSwitcherCounterRoute");
  } else if (index == 48) {
    Navigator.pushNamed(context, "AnimatedWidgetsTest");
  } else if (index == 49) {
    Navigator.pushNamed(context, "GradientButtonRoute");
  } else if (index == 50) {
    Navigator.pushNamed(context, "TurnBoxRoute");
  } else if (index == 51) {
    Navigator.pushNamed(context, "CustomPaintRoute");
  } else if (index == 52) {
    Navigator.pushNamed(context, "GradientCircularProgressRoute");
  }
}

///异常方法1
_asyncexception() async {
  foo() async {
    throw new StateError('This is an async Dart exception.');
  }

  bar() async {
    await foo();
  }

  await bar();
}
