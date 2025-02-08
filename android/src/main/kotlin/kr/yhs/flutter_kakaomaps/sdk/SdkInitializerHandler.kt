package kr.yhs.flutter_kakaomaps.SDK

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

interface SdkInitializerHandler {
    fun handle(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        "initialize" -> initialize(call.argument("appKey")!!, result)
        "isInitialize" -> isInitialize(result)
        "hashKey" -> hashKey(result)
        else -> result.notImplemented()
    }

    fun initialize(appKey: String, result: MethodChannel.Result);

    fun isInitialize(result: MethodChannel.Result);

    fun hashKey(result: MethodChannel.Result);
}