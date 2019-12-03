package io.flutter.test;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BatteryManager implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static final String METHOD = "org.tiny.platformspecific/battery";
    private static final String EVENT = "org.tiny.platformspecific/charging";
    private FlutterActivity mFlutterActivity;
    private BroadcastReceiver mChargingStateChangeReceiver;

    static void registerWith(FlutterActivity activity) {
        new BatteryManager(activity);
    }

    private BatteryManager(FlutterActivity activity) {
        mFlutterActivity = activity;
        new MethodChannel(mFlutterActivity.getFlutterView(), METHOD).setMethodCallHandler(this);
        new EventChannel(mFlutterActivity.getFlutterView(), EVENT).setStreamHandler(this);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        String method = methodCall.method;
        switch (method) {
            case "getBatteryLevel":
                result.success(getBatteryLevel());
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private int getBatteryLevel() {
        Intent intent = new ContextWrapper(mFlutterActivity.getApplicationContext()).
                registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
        if (intent == null) return -1;
        return intent.getIntExtra(android.os.BatteryManager.EXTRA_LEVEL, -1);
    }

    @Override
    public void onListen(Object arguments, final EventChannel.EventSink eventSink) {
        mChargingStateChangeReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                int battery = intent.getIntExtra(android.os.BatteryManager.EXTRA_LEVEL, -1);
                eventSink.success(battery);
            }
        };
        IntentFilter filter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        mFlutterActivity.registerReceiver(mChargingStateChangeReceiver, filter);
    }

    @Override
    public void onCancel(Object arguments) {
        if (mChargingStateChangeReceiver != null) {
            mFlutterActivity.unregisterReceiver(mChargingStateChangeReceiver);
        }
    }
}
