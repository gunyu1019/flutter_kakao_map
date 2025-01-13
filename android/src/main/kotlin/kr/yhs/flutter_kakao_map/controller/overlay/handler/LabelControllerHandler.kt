package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelLayerOptions
import com.kakao.vectormap.LatLng
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelOptions
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelLayerOptions


interface LabelControllerHandler {
    val labelManager: LabelManager?

    fun labelHandle(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        "addPoi" -> { 
            val arguments = call.arguments!!.asMap<Any?>()
            val layerId = call.argument<String>("layerId") ?: ""
            val poi = arguments["poi"]!!.asLabelOptions(labelManager!!)
            addPoi(layerId, poi, result::success)
        }
        "createLabelLayer" -> {
            val arguments = call.arguments!!.asMap<Any?>()
            createLabelLayer(arguments.asLabelLayerOptions(), result::success)
        }
        else -> result.notImplemented()
    }

    fun createLabelLayer(options: LabelLayerOptions, onSuccess: (Any?) -> Unit);

    fun addPoi(layerId: String, poi: LabelOptions, onSuccess: (String) -> Unit);
    
    fun removePoi(layerId: String, poiId: String, onSuccess: (Any?) -> Unit);

    // Poi Controller
    fun changePoiOffsetPosition(layerId: String, poiId: String, x: Double, y: Double, forceDpScale: Boolean?, onSuccess: (Any?) -> Unit);

    fun changePoiVisible(layerId: String, poiId: String, visible: Boolean, onSuccess: (Any?) -> Unit);

    fun changePoiStyle(layerId: String, poiId: String, styleId: String, onSuccess: (Any?) -> Unit);

    fun changePoiText(layerId: String, poiId: String, text: String, onSuccess: (Any?) -> Unit);

    fun invalidatePoi(layerId: String, poiId: String, styleId: String, text: String, transition: Boolean, onSuccess: (Any?) -> Unit);

    fun invalidatePoi(layerId: String, poiId: String, position: LatLng, millis: Double?, onSuccess: (Any?) -> Unit);

    fun rotatePoi(layerId: String, poiId: String, angle: Double, millis: Double?, onSuccess: (Any?) -> Unit);
    
    fun scalePoi(layerId: String, poiId: String, x: Double, y: Double, millis: Double?, onSuccess: (Any?) -> Unit);

    fun rankPoi(layerId: String, poiId: String, rank: Long, onSuccess: (Any?) -> Unit);
}