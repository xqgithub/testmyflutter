import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

///计数实例
class CountInstanceless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CountInstance',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CountInstance(
        title: 'CountInstance',
      ),
    );
  }
}

class CountInstance extends StatefulWidget {
  CountInstance({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CountInstance createState() => new _CountInstance();
}

class _CountInstance extends State<CountInstance> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('You have pushed the button this many times:'),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            RandomWordsWidget(),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

/**
 * 随机生成英文单词
 */
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}
