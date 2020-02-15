package com.kourim.plugin.asr;

import androidx.annotation.Nullable;
import android.util.Log;

import io.flutter.plugin.common.MethodChannel;

public class ResultStateful implements MethodChannel.Result {
    private final static String TAG = "ResultStateful";
    private MethodChannel.Result result;
    private boolean called;

    // 外界只能通过这个of方法来创建
    public static ResultStateful of(MethodChannel.Result result){
        return new ResultStateful(result);
    }

    private ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }

    @Override
    public void success(@Nullable  Object o) {
        if (called){
            printError();
            return;
        }
        called=true;
        result.success(o);
    }

    @Override
    public void error(String s, @Nullable String s1, @Nullable Object o) {
        if (called){
            printError();
            return;
        }
        called=true;
        result.error(s, s1, o);

    }

    // 没有实现
    @Override
    public void notImplemented() {
        if (called){
            printError();
            return;
        }
        called=true;
        result.notImplemented();

    }

    private void printError() {
        Log.e(TAG, "error: result called");
    }
}
