package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.LabelOptions


interface LabelControllerHandler {
    fun handle(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        else -> result.notImplemented()
    }

    fun createLabelLayer();

    fun addPoi(layerId: String, poi: LabelOptions);
}