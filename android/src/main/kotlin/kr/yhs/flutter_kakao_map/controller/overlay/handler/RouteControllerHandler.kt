package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asLong
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import com.kakao.vectormap.route.RouteLineManager
import com.kakao.vectormap.route.RouteLineLayer

interface RouteControllerHandler {
    val routeManager: RouteLineManager?

    fun routeHandle(call: MethodCall, result: MethodChannel.Result) {
        val arguments = call.arguments!!.asMap<Any?>()
        if (routeManager == null) {
            throw NullPointerException("RouteManager is null.")
        }
        val layer = arguments["layerId"]?.asString()?.let<String, RouteLineLayer> {
            routeManager!!.getLayer(it)
        }

        when(call.method) {
            "createRouteLayer" -> {}
            "removeRouteLayer" -> {}
            "addRouteStyle" -> {}
            "addRoute" -> {}
            "addMultipleRoute" -> {}
            "removeRoute" -> {}
            else -> result.notImplemented()
        }
    }
}
