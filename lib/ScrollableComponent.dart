import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/**
 * 可滚动组件简介
 */

class TestScrollable extends StatefulWidget {
  _TestScrollable createState() => new _TestScrollable();
}

class _TestScrollable extends State<TestScrollable> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("可滚动组件"),
      ),
//      body: _TestSingleChildScrollView(),
//      body: _TestListView1(),
//      body: _TestListView2(),
//      body: _TestListView3(),
      body: _TestListView4(),
    );
  }
}

///SingleChildScrollView类似于Android中的ScrollView，它只能接收一个子组件
///1.SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，这是因为SingleChildScrollView不支持基于Sliver的延迟实例化模型，
///2.所以如果预计视口可能包含超出屏幕尺寸太多的内容时，那么使用SingleChildScrollView将会非常昂贵（性能差），此时应该使用一些支持Sliver延迟加载的可滚动组件，如ListView
_TestSingleChildScrollView() {
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  return Scrollbar(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          //动态创建一个List<Widget>
          children: str
              .split("")
              //每一个字母都用一个Text显示,字体为原来的两倍
              .map((c) => Text(
                    c,
                    textScaleFactor: 2.0,
                  ))
              .toList(),
        ),
      ),
    ),
  );
}

///ListView第一种构造
///1.适合只有少量的子组件的情况，因为这种方式需要将所有children都提前创建好（这需要做大量工作）
///2.实际上通过此方式创建的ListView和使用SingleChildScrollView+Column的方式没有本质的区别
_TestListView1() {
  return ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.all(20.0),
    children: <Widget>[
      const Text('I\'m dedicating every day to you'),
      const Text('Domestic life was never quite my style'),
      const Text('When you smile, you knock me out, I fall apart'),
      const Text('And I thought I was so smart'),
    ],
  );
}

///ListView第二种构造
///ListView.builder适合列表项比较多（或者无限）的情况，因为只有当子组件真正显示的时候才会被创建，也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的
_TestListView2() {
  return ListView.builder(
    itemCount: 100,
    itemExtent: 50.0, //强制高度为50.0
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text("${index}"),
      );
    },
  );
}

///ListView第三种构造
///ListView.separated可以在生成的列表项之间添加一个分割组件，它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器
_TestListView3() {
  //下划线widget预定义以供复用。
  Widget divider1 = Divider(
    color: Colors.blue,
  );
  Widget divider2 = Divider(color: Colors.green);

  return ListView.separated(
    itemCount: 100,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text("${index}"),
      );
    },

    ///分割器构造器
    separatorBuilder: (BuildContext context, int index) {
      return index % 2 == 0 ? divider1 : divider2;
    },
  );
}

///ListView添加固定列表头
_TestListView4() {
  return Column(
    children: <Widget>[
      ListTile(
        title: Text("商品列表"),
      ),
      Expanded(
        child: ListView.separated(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${index}"),
            );
          },
          separatorBuilder: (context, index) => Divider(height: .0),
        ),
      ),
    ],
  );
}

///ListView无限加载列表
class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => new _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  ///加载数据
  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {
        //重新构建列表
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView无限加载"),
      ),
      body: ListView.separated(
        itemCount: _words.length,
        itemBuilder: (context, index) {
          //如果到了表尾
          if (_words[index] == loadingTag) {
            //不足100条，继续获取数据
            if (_words.length - 1 < 100) {
              //获取数据
              _retrieveData();
              //加载时显示loading
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)),
              );
            } else {
              //已经加载了100条数据，不再获取数据。
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          //显示单词列表项
          return ListTile(title: Text(_words[index]));
        },
        separatorBuilder: (context, index) => Divider(height: .0),
      ),
    );
  }
}
