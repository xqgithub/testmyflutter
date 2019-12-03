package io.flutter.test;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

/**
 * flutter 和 Android 数据交互
 */
public class TestDartTransferPlatform extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        communicateFromBasicMessageChannel();
        communicateFromMethodChannel();
    }

    /**
     * BasicMessageChannel 方式
     */
    private void communicateFromBasicMessageChannel() {
        //初始化BasicMessageChannel
        BasicMessageChannel<Object> messageChannel = new BasicMessageChannel<Object>(
                getFlutterView(), "basicmessagechannel", StandardMessageCodec.INSTANCE);

        //第一种使用:platform为主动发起方(platform发送消息到dart,并且收到dart的回复)
//        messageChannel.send("Android Side =-= BasicMessageChannel", new BasicMessageChannel.Reply<Object>() {
//            @Override
//            public void reply(Object o) {
//                System.out.println("收到消息 from dart =-=" + o.toString());
//            }
//        });

        //第二种使用:dart主动发起，platform为接收方(从dart端接收消息，并且发送回复)
        messageChannel.setMessageHandler(new BasicMessageChannel.MessageHandler<Object>() {
            @Override
            public void onMessage(Object o, BasicMessageChannel.Reply<Object> reply) {
                System.out.println("收到消息 from dart =-=" + o.toString());
                //回复消息
//                reply.reply("Android Side =-= BasicMessageChannel");
                //发送消息
                messageChannel.send("Android Side =-= BasicMessageChannel");
            }
        });
    }

    /**
     * MethodChannel 方式
     */
    private void communicateFromMethodChannel() {
        //初始化MethodChannel
        MethodChannel channel = new MethodChannel(getFlutterView(), "methodchannel");
        //设置方法调用再处理
        channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                String method = methodCall.method;
                Object arguments = methodCall.arguments;
                switch (method) {
                    case "method1":
                        boolean arg;
                        if (arguments instanceof Integer) {
                            arg = true;
                        } else {
                            arg = false;
                        }
                        //在此处调用method1，如果有返回值，可以通过result把返回值
                        String reply = "invoke native method1 " + arg;
                        result.success(reply);
                        break;
                }
            }
        });
    }
}
