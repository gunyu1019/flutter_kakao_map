package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asLong
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import com.kakao.vectormap.route.RouteLineManager
import com.kakao.vectormap.route.RouteLineLayer
import com.kakao.vectormap.route.RouteLineStylesSet
import com.kakao.vectormap.route.RouteLineOptions
import com.kakao.vectormap.route.RouteLine

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

    fun createRouteLayer(routeId: String, zOrder: Int?, onSuccess: (Any?) -> Unit);

    fun removeRouteLayer(layer: RouteLineLayer, onSuccess: (Any?) -> Unit);

    fun addRouteStyle(style: RouteLineStylesSet, onSuccess: (String) -> Unit);

    fun addRoute(layer: RouteLineLayer, route: RouteLineOptions, onSuccess: (String) -> Unit);
    
    fun removeRoute(layer: RouteLineLayer, route: RouteLine, onSuccess: (Any?) -> Unit);
}
