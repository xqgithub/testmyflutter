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
                  //弹出对话框并等待其关闭
                  sendMessage();
                  receiveMessage();
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

}
