package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelManager
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelOptions


interface LabelControllerHandler {
    val labelManager: LabelManager?

    fun labelHandle(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        "addPoi" -> { 
            val arguments = call.arguments!!.asMap<Any?>()
            val layerId = call.argument<String>("layerId") ?: ""
            val poi = arguments["poi"]!!.asLabelOptions(labelManager!!)
            addPoi(layerId, poi, result::success)
        }
        else -> result.notImplemented()
    }

    fun createLabelLayer();

    fun addPoi(layerId: String, poi: LabelOptions, onSuccess: (Map<String, Any>) -> Unit);
}