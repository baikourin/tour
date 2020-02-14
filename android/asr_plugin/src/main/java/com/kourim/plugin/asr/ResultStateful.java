package com.kourim.plugin.asr;

import io.flutter.plugin.common.MethodChannel;

public class ResultStateful implements MethodChannel.Result {
    private final static String TAG = "ResultStateful";
    private MethodChannel.Result result;

    private ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }

    // 外界只能通过这个of方法来创建
    public static ResultStateful of(MethodChannel.Result result){
        return new ResultStateful(result);
    }

    @Override
    public void success(Object result) {

    }

    @Override
    public void error(String errorCode, String errorMessage, Object errorDetails) {

    }

    @Override
    public void notImplemented() {

    }
}
