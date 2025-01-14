package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.Label
import com.kakao.vectormap.label.LabelLayer
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelLayerOptions
import com.kakao.vectormap.LatLng
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelOptions
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelLayerOptions


interface LabelControllerHandler {
    val labelManager: LabelManager?

    fun labelHandle(call: MethodCall, result: MethodChannel.Result) {
        val arguments = call.arguments!!.asMap<Any?>()
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }

        val layer = arguments["layerId"]?.let(labelManager::getLayer)

        // TODO (implement label required method)
        // val poi = arguments["poiId"]?.let(layer::getLabel)

        // TODO (implement poi required method)
        /* when (call.method) {
            "addPoi" -> { 
                val poiOption = arguments["poi"]!!.asLabelOptions(labelManager!!)
                addPoi(layer, poiOption, result::success)
            }
            "removePoi" -> {
                val poiId = call.argument<String>("poiId")!!
                removePoi(layer, poi, result::success)
            }
            "createLabelLayer" -> {
                createLabelLayer(arguments.asLabelLayerOptions(), result::success)
            }
            else -> result.notImplemented()
        } */
    }

    fun createLabelLayer(options: LabelLayerOptions, onSuccess: (Any?) -> Unit);

    fun addPoi(layer: LabelLayer, poi: LabelOptions, onSuccess: (String) -> Unit);
    
    fun removePoi(layer: LabelLayer, poi: Label, onSuccess: (Any?) -> Unit);

    // Poi Controller
    fun changePoiOffsetPosition(poi: Label, x: Float, y: Float, forceDpScale: Boolean?, onSuccess: (Any?) -> Unit);

    fun changePoiVisible(poi: Label, visible: Boolean, onSuccess: (Any?) -> Unit);

    fun changePoiStyle(poi: Label, styleId: String, onSuccess: (Any?) -> Unit);

    fun changePoiText(poi: Label, text: String, onSuccess: (Any?) -> Unit);

    fun invalidatePoi(poi: Label, styleId: String, text: String, transition: Boolean, onSuccess: (Any?) -> Unit);

    fun movePoi(poi: Label, position: LatLng, millis: Int?, onSuccess: (Any?) -> Unit);

    fun rotatePoi(poi: Label, angle: Float, millis: Int?, onSuccess: (Any?) -> Unit);
    
    fun scalePoi(poi: Label, x: Float, y: Float, millis: Int?, onSuccess: (Any?) -> Unit);

    fun rankPoi(poi: Label, rank: Long, onSuccess: (Any?) -> Unit);
}