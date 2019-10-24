library crashy;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testmyflutter/CountInstance.dart';
import 'package:testmyflutter/LoadAssets.dart';
import 'package:testmyflutter/RoutePassValue.dart';

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
  } else if (index == 2) {
    Navigator.pushNamed(context, "EchoRoute", arguments: "我是海贼王路飞");
  } else if (index == 3) {
    Navigator.pushNamed(context, "LoadAssets");
  } else if (index == 4) {
    _asyncexception();
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
