import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * flutter和原生交互
 */

class TestDartTransferPlatform extends StatefulWidget {
  _TestDartTransferPlatform createState() => new _TestDartTransferPlatform();
}

class _TestDartTransferPlatform extends State<TestDartTransferPlatform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter和原生交互"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250.0,
              height: 50.0,
              child: new RaisedButton(
                child: new Text(
                  "BasicMessageChannel",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () async {
                  sendMessage();
                  receiveMessage();
                },
                color: Colors.red,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              width: 250.0,
              height: 50.0,
              child: new RaisedButton(
                child: new Text(
                  "MethodChannel",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () async {
                  String result = await invokeNative("method1", 1111);
                  print("result =-= " + result);
                },
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*************  BasicMessageChannel start *************/

  ///BasicMessageChannel 主要是传递字符串和一些半结构体的数据

  ///初始化BasicMessageChannel
  static const _messagechannel = const BasicMessageChannel<Object>(
      "basicmessagechannel", StandardMessageCodec());

  ///发送信息到Platform端,并且接收消息回复
  Future<String> sendMessage() async {
    String reply =
        await _messagechannel.send("Dart Side =-= BasicMessageChannel");
    print("reply =-=" + reply);
    return reply;
  }

  ///从Platform端接收消息 并且发送回复
  void receiveMessage() {
    _messagechannel.setMessageHandler((message) async {
      print("收到一个消息 =-= $message");
      return "Dart Side =-= BasicMessageChannel";
    });
  }

  /*************  BasicMessageChannel end *************/

  /*************  MethodChannel  start *************/

  ///MethodChannel 用于传递方法调用

  static const _messagechannel2 = const MethodChannel("methodchannel");

  //调用native方法
  static Future<dynamic> invokeNative(String methodName,
      [dynamic arguments]) async {
    return await _messagechannel2.invokeMethod(methodName, arguments);
  }

/*************  MethodChannel  end *************/

}
