package kr.yhs.flutter_kakao_map.controller

import com.kakao.vectormap.GestureType
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdate
import com.kakao.vectormap.camera.CameraAnimation
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asCameraAnimation
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asCameraUpdate
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asInt
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.model.KakaoMapEvent

interface KakaoMapControllerHandler {
    fun handle(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        "getCameraPosition" -> getCameraPosition(result::success)
        "moveCamera" -> {
            val arguments = call.arguments?.asMap<Any?>()
            val animation = arguments?.get("cameraAnimation")?.asCameraAnimation()
            val camera = arguments?.get("cameraUpdate")!!.asCameraUpdate()
            moveCamera(camera, animation, result::success)
        }
        "setGestureEnable" -> {
            val arguments = call.arguments!!.asMap<Any?>()
            val gestureType = GestureType.getEnum(arguments["gestureType"]!!.asInt())
            val enable = arguments["enable"]!!.asBoolean()
            setGestureEnable(gestureType, enable, result::success)
        }
        else -> result.notImplemented()
    }

    fun getCameraPosition(onSuccess: (cameraPosition: Map<String, Any>) -> Unit)

    fun moveCamera(
        cameraUpdate: CameraUpdate,
        cameraAnimation: CameraAnimation?,
        onSuccess: (Any?) -> Unit
    )

    fun setGestureEnable(
        gestureType: GestureType,
        enable: Boolean,
        onSuccess: (Any?) -> Unit
    )

    fun setEventHandler(
        eventType: KakaoMapEvent,
        enable: Boolean,
        onSuccess: (Any?) -> Unit
    );
}