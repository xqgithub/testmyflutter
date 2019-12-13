import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testmyflutter/entity/book_model.dart';
import 'package:testmyflutter/entity/user_model.dart';
import 'package:testmyflutter/entity/user_model2.dart';
import 'package:web_socket_channel/io.dart';

/**
 * 文件操作与网络请求
 */

/************* 文件操作 start *************/
class FileOperationRoute extends StatefulWidget {
  FileOperationRoute({Key key}) : super(key: key);

  @override
  _FileOperationRouteState createState() => new _FileOperationRouteState();
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter;

  @override
  void initState() {
    super.initState();
    //从文件读取点击次数
    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文件操作"),
      ),
      body: Center(
        child: Text('点击了 $_counter 次'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/************* 文件操作 end *************/

/************* HttpClient发起HTTP请求 start *************/

class HttpTestRoute extends StatefulWidget {
  @override
  _HttpTestRouteState createState() => new _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HttpClient发起HTTP请求"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("获取百度首页"),
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() {
                          _loading = true;
                          _text = "正在请求...";
                        });
                        try {
                          //创建一个HttpClient
                          HttpClient httpClient = new HttpClient();
                          //打开Http连接
                          HttpClientRequest request = await httpClient
                              .getUrl(Uri.parse("https://www.baidu.com"));
                          //使用iPhone的UA
                          request.headers.add("user-agent",
                              "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                          //等待连接服务器（会将请求信息发送给服务器）
                          HttpClientResponse response = await request.close();
                          //读取响应内容
                          _text = await response.transform(utf8.decoder).join();
                          //输出响应头
                          print(response.headers);
                          //关闭client后，通过该client发起的所有请求都会中止。
                          httpClient.close();
                        } catch (e) {
                          _text = "请求失败：$e";
                        } finally {
                          setState(() {
                            _loading = false;
                          });
                        }
                      },
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  child: Text(_text.replaceAll(new RegExp(r"\s"), "")))
            ],
          ),
        ),
      ),
    );
  }
}

/************* HttpClient发起HTTP请求 end *************/

/************* Http请求-Dio http库 start *************/
class DioHttpTestRoute extends StatefulWidget {
  @override
  _FutureBuilderRouteState createState() => new _FutureBuilderRouteState();
}

class _FutureBuilderRouteState extends State<DioHttpTestRoute> {
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http请求-Dio"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              //请求成功，通过项目信息构建用于显示项目名称的ListView

              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(
                          title: Text(e["full_name"]),
                        ))
                    .toList(),
              );
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

///Dio库实现 Http分块下载
Future downloadWithChunks(
  url,
  savePath, {
  ProgressCallback onReceiveProgress,
}) async {
  const firstChunkSize = 102;
  const maxChunk = 3;

  int total = 0;
  var dio = Dio();
  var progress = <int>[];

  createCallback(no) {
    return (int received, _) {
      progress[no] = received;
      if (onReceiveProgress != null && total != 0) {
        onReceiveProgress(progress.reduce((a, b) => a + b), total);
      }
    };
  }

  //start 代表当前块的起始位置，end代表结束位置
  //no 代表当前是第几块
  Future<Response> downloadChunk(url, start, end, no) async {
    progress.add(0); //progress记录每一块已接收数据的长度
    --end;
    return dio.download(
      url,
      savePath + "temp$no", //临时文件按照块的序号命名，方便最后合并
      onReceiveProgress: createCallback(no), // 创建进度回调，后面实现
      options: Options(
        headers: {"range": "bytes=$start-$end"}, //指定请求的内容区间
      ),
    );
  }

  Future mergeTempFiles(chunk) async {
    File f = File(savePath + "temp0");
    IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
    //合并临时文件
    for (int i = 1; i < chunk; ++i) {
      File _f = File(savePath + "temp$i");
      await ioSink.addStream(_f.openRead());
      await _f.delete(); //删除临时文件
    }
    await ioSink.close();
    await f.rename(savePath); //合并后的文件重命名为真正的名称
  }

  // 通过这个分块请求检测服务器是否支持分块传输
  Response response = await downloadChunk(url, 0, firstChunkSize, 0);
  if (response.statusCode == 206) {
    //如果支持
    //解析文件总长度，进而算出剩余长度
    total = int.parse(
        response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);

    int reserved = total -
        int.parse(response.headers.value(HttpHeaders.contentLengthHeader));

    //文件的总块数(包括第一块)
    int chunk = (reserved / firstChunkSize).ceil() + 1;
    if (chunk > 1) {
      int chunkSize = firstChunkSize;
      if (chunk > maxChunk + 1) {
        chunk = maxChunk + 1;
        chunkSize = (reserved / maxChunk).ceil();
      }
      var futures = <Future>[];
      for (int i = 0; i < maxChunk; ++i) {
        int start = firstChunkSize + i * chunkSize;
        //分块下载剩余文件
        futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
      }
      //等待所有分块全部下载完成
      await Future.wait(futures);
    }
    //合并文件文件
    await mergeTempFiles(chunk);
  }
}

/************* Http请求-Dio http库 end *************/

/************* WebSockets start *************/
class WebSocketRoute extends StatefulWidget {
  @override
  _WebSocketRouteState createState() => new _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    //创建websocket连接
    channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket(内容回显)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: new InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                //网络不通会走到这
                if (snapshot.hasError) {
                  _text = "网络不通...";
                } else if (snapshot.hasData) {
                  _text = "echo : " + snapshot.data;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(_text),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: new Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

/************* WebSockets end *************/

/************* Json转Dart Model类 start *************/
class TestJsonToDartModel extends StatefulWidget {
  @override
  _TestJsonToDartModel createState() => new _TestJsonToDartModel();
}

class _TestJsonToDartModel extends State<TestJsonToDartModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json转Dart Model类"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200.0,
              height: 50.0,
              child: RaisedButton(
                color: Colors.red,
//                onPressed: _testJson1,
                onPressed: _testJson3,
                child: Text(
                  "生成json",
                  style: new TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              width: 200.0,
              height: 50.0,
              child: RaisedButton(
                color: Colors.red,
//                onPressed: _testJson2,
                onPressed: _testJson4,
                child: Text(
                  "json转UserModel",
                  style: new TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_testJson1() {
  UserModel userModel = UserModel('fangmingdong', 12);
  String jsonStr = json.encode(userModel.toJson());
  print(jsonStr);
}

_testJson2() {
  String JSON_STRING = '''{"name":"fangmingdong","age":12}''';
  UserModel userModel = UserModel.fromJson(json.decode(JSON_STRING));
  print("name:${userModel.name}");
  print("age:${userModel.age}");
}

///由于json_serializable 并不支持泛型解析
_testJson3() {
  UserModel2 userModel2 = UserModel2(
      new UserModelReal('fangmingdong', 12, BookModel(1, '从你的全世界路过')));
  String jsonStr = json.encode(userModel2.toJson());
  print(jsonStr);
}

_testJson4() {
  String JSON_STRING =
      '''{"code":200,"msg":"success","data":{"name":"fangmingdong","age":12,"book":{"id":1,"name":"从你的全世界路过"}}}''';
  UserModel2 userModel2 = UserModel2.fromJson(json.decode(JSON_STRING));
  print("name:${userModel2.data.name}");
  print("age:${userModel2.data.age}");
  print("bookname:${userModel2.data.book.name}");
  print("code:${userModel2.code}");
}

/************* Json转Dart Model类 end *************/
