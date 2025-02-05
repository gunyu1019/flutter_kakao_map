package kr.yhs.flutter_kakao_maps.controller

import com.kakao.vectormap.GestureType
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdate
import com.kakao.vectormap.camera.CameraAnimation
import com.kakao.vectormap.LatLng
import com.kakao.vectormap.MapType
import com.kakao.vectormap.MapOverlay
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import kr.yhs.flutter_kakao_maps.converter.CameraTypeConverter.asCameraAnimation
import kr.yhs.flutter_kakao_maps.converter.CameraTypeConverter.asCameraUpdate
import kr.yhs.flutter_kakao_maps.converter.CameraTypeConverter.asLatLng
import kr.yhs.flutter_kakao_maps.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_maps.converter.PrimitiveTypeConverter.asList
import kr.yhs.flutter_kakao_maps.converter.PrimitiveTypeConverter.asInt
import kr.yhs.flutter_kakao_maps.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_maps.model.KakaoMapEvent

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
        "setEventHandler" -> setEventHandler(call.arguments!!.asInt())
        "fromScreenPoint" -> {
            val arguments = call.arguments!!.asMap<Any?>()
            fromScreenPoint(
                arguments["x"]!!.asInt(), 
                arguments["y"]!!.asInt(), 
                result::success
            )
        }
        "toScreenPoint" -> toScreenPoint(call.arguments!!.asLatLng(), result::success)
        "clearCache" -> clearCache(result::success)
        "clearDiskCache" -> clearDiskCache(result::success)
        /* "canPositionVisible" -> {
            val arguments = call.arguments!!.asMap<Any?>()
            canPositionVisible(
                arguments["zoomLevel"]!!.asInt(),
                arguments["position"]!!.asList<Any>().map { (e: Any) => e.asLatLng() },
                result::success
            )
        } */
        "changeMapType" -> {
            val arguments = call.arguments!!.asMap<Any?>()
            changeMapType(
                arguments["mapType"]!!.toString().let(MapType::getEnum),
                result::success
            )
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
        event: Int
    )

    fun fromScreenPoint(
        x: Int,
        y: Int,
        onSuccess: (Map<String, Any>?) -> Unit
    )

    fun toScreenPoint(
        position: LatLng,
        onSuccess: (Map<String, Any>?) -> Unit
    )

    fun clearCache(onSuccess: (Any?) -> Unit)

    fun clearDiskCache(onSuccess: (Any?) -> Unit)

    fun canPositionVisible(
        zoomLevel: Int,
        position: List<LatLng>,
        onSuccess: (Boolean) -> Unit
    )

    fun changeMapType(
        mapType: MapType,
        onSuccess: (Any?) -> Unit
    )

    fun overlayVisible(
        overlayType: MapOverlay,
        visible: Boolean,
        onSuccess: (Any?) -> Unit
    )

    fun getBuildingHeightScale(
        onSuccess: (Float) -> Unit
    )

    fun setBuildingHeightScale(
        scale: Float,
        onSuccess: (Any?) -> Unit
    )
}