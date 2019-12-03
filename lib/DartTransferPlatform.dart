import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * flutter和原生交互
 */

class TestDartTransferPlatform extends StatefulWidget {
  _TestDartTransferPlatform createState() => new _TestDartTransferPlatform();
}

class _TestDartTransferPlatform extends State<TestDartTransferPlatform> {
  int _battery = 0;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    _getBattery();
    super.initState();
  }

  void _getBattery() async {
    int battery = await BatteryManager.getInstance().getBatteryLevel();
    _setBattery(battery);
    _streamSubscription =
        BatteryManager.getInstance().setOnBatteryListener(_setBattery);
  }

  void _setBattery(int battery) {
    setState(() {
      _battery = battery;
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

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
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              width: 250.0,
              height: 50.0,
              child: Text('Battery: $_battery'),
            )
          ],
        ),
      ),
    );
  }
}

/*************  BasicMessageChannel start *************/

///BasicMessageChannel 主要是传递字符串和一些半结构体的数据

///初始化BasicMessageChannel
const _messagechannel = const BasicMessageChannel<Object>(
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
const _messagechannel2 = const MethodChannel("methodchannel");
//调用native方法
Future<dynamic> invokeNative(String methodName, [dynamic arguments]) async {
  return await _messagechannel2.invokeMethod(methodName, arguments);
}
/*************  MethodChannel  end *************/

/*************  EventChannel  start *************/

///Flutter端封装一个获取手机电量的方法

class BatteryManager {
  static BatteryManager _instance;
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;
  StreamSubscription _eventStreamSubscription;

  /// _私有构造方法
  BatteryManager._(this._methodChannel, this._eventChannel);

  /// 创建单例
  static BatteryManager getInstance() {
    if (_instance == null) {
      final MethodChannel methodChannel =
          const MethodChannel('org.tiny.platformspecific/battery');
      final EventChannel eventChannel =
          const EventChannel('org.tiny.platformspecific/charging');
      _instance = BatteryManager._(methodChannel, eventChannel);
    }
    return _instance;
  }

  /// 得到电量
  Future<int> getBatteryLevel() async {
    try {
      final int level = await _methodChannel.invokeMethod('getBatteryLevel');
      return Future.value(level);
    } on PlatformException catch (e) {
      return Future.value(-1);
    }
  }

  /// 监听电量的变化
  StreamSubscription setOnBatteryListener(void onEvent(int battery)) {
    if (_eventStreamSubscription == null) {
      _eventStreamSubscription = _eventChannel
          .receiveBroadcastStream()
          .listen((data) => onEvent(data));
    }
    return _eventStreamSubscription;
  }
}

/*************  EventChannel  end *************/
