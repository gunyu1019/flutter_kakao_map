package kr.yhs.flutter_kakao_map.controller

import com.kakao.vectormap.camera.CameraPosition
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

interface KakaoMapControllerHandler {
    fun handle(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        "getCameraPosition" -> getCameraPosition(result::success)
        else -> result.notImplemented()
    }

    fun getCameraPosition(onSuccess: (cameraPosition: Map<String, Any>) -> Unit)

    fun moveCamera()
}