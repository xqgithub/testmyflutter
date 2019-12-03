package io.flutter.test;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class TestDartTransferPlatform extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        //初始化BasicMessageChannel
        BasicMessageChannel<Object> messageChannel = new BasicMessageChannel<Object>(
                getFlutterView(), "basicmessagechannel", StandardMessageCodec.INSTANCE);

        //第一种使用:platform为主动发起方(platform发送消息到dart,并且收到dart的回复)
        messageChannel.send("Android Side =-= BasicMessageChannel", new BasicMessageChannel.Reply<Object>() {
            @Override
            public void reply(Object o) {
                System.out.println("收到消息 from dart =-=" + o.toString());
            }
        });


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
}
