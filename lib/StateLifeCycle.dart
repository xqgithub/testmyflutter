import 'package:flutter/material.dart';

///State的生命周期

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key key, this.initValue: 0});

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

//新创建的 State 会和一个 BuildContext 产生关联，此时认为 State 已经被安装好了，initState() 函数将会被调用
  @override
  void initState() {
    super.initState();
    //初始化状态
    _counter = widget.initValue;
    print("initState");
  }

  //在 initState() 调用结束后，这个函数会被调用,事实上，当 State 对象的依赖关系发生变化时，这个函数总会被 Framework 调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  //经过以上步骤，系统认为一个 State 已经准备好了，就会调用 build() 来构建视图
  @override
  Widget build(BuildContext context) {
    print("build");
    return new Scaffold(
      body: new Center(
        child: FlatButton(
          //点击后计数器自增,当我需要更新 State 的视图时，需要手动调用这个函数，它会触发 build()
          onPressed: () => setState(() => ++_counter),
          child: Text("$_counter"),
        ),
      ),
    );
  }

  //当 widget 的配置发生变化时，会调用这个函数
  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  //当 State 被暂时从视图树中移除时，会调用这个函数
  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  //当 State 被永久的从视图树中移除，Framework 会调用该函数
  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  //此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用
  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }
}
