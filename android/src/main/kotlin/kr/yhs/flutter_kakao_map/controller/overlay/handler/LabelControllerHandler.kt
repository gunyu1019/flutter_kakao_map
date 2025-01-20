package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.Label
import com.kakao.vectormap.label.LabelLayer
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelStyles
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelLayerOptions
import com.kakao.vectormap.LatLng
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asFloat
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asInt
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asLong
import kr.yhs.flutter_kakao_map.converter.CameraTypeConverter.asLatLng
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelOptions
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelStyles
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelLayerOptions


interface LabelControllerHandler {
    val labelManager: LabelManager?

    fun labelHandle(call: MethodCall, result: MethodChannel.Result) {
        val arguments = call.arguments!!.asMap<Any?>()
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }

        val layer = arguments["layerId"]?.asString()?.let<String, LabelLayer> { labelManager!!.getLayer(it) }
        val poi = layer?.run {
            arguments["poiId"]?.asString()?.let(layer::getLabel)
        }

        when (call.method) {
            "createLabelLayer" -> {
                createLabelLayer(arguments.asLabelLayerOptions(), result::success)
            }
            "removeLabelLayer" -> {
                removeLabelLayer(layer!!, result::success)
            }
            "addPoiStyle" -> {
                val style = arguments.asLabelStyles()
                addPoiStyle(style!!, result::success)
            }
            "addPoi" -> { 
                val poiOption = arguments["poi"]!!.asLabelOptions(labelManager!!)
                addPoi(layer!!, poiOption, result::success)
            }
            "removePoi" -> removePoi(layer!!, poi!!, result::success)
            "changePoiOffsetPosition" -> {
                val x = arguments["x"]?.asFloat()!!
                val y = arguments["y"]?.asFloat()!!
                val forceDpScale = arguments["forceDpScale"]?.asBoolean()
                changePoiOffsetPosition(poi!!, x, y, forceDpScale, result::success)
            }
            "changePoiVisible" -> {
                val visible = arguments["visible"]?.asBoolean()!!
                changePoiVisible(poi!!, visible, result::success)
            }
            "changePoiStyle" -> {
                val styleId = arguments["styleId"]?.asString()!!
                changePoiStyle(poi!!, styleId, result::success)
            }
            "changePoiText" -> {
                val text = arguments["text"]?.asString()!!
                changePoiStyle(poi!!, text, result::success)
            }
            "invalidatePoi" -> {
                val styleId = arguments["styleId"]?.asString()!!
                val text = arguments["text"]?.asString()!!
                val transition = arguments["transition"]?.asBoolean() ?: false
                invalidatePoi(poi!!, styleId, text, transition, result::success)
            }
            "movePoi" -> {
                val position = arguments.asLatLng()
                val millis = arguments["millis"]?.asInt()
                movePoi(poi!!, position, millis, result::success)
            }
            "rotatePoi" -> {
                val angle = arguments["angle"]?.asFloat()!!
                val millis = arguments["millis"]?.asInt()
                rotatePoi(poi!!, angle, millis, result::success)
            }
            "scalePoi" -> {
                val x = arguments["x"]?.asFloat()!!
                val y = arguments["y"]?.asFloat()!!
                val millis = arguments["millis"]?.asInt()
                scalePoi(poi!!, x, y, millis, result::success)
            }
            "rankPoi" -> {
                val rank = arguments["x"]?.asLong()!!
                rankPoi(poi!!, rank, result::success)
            }
            else -> result.notImplemented()
        }
    }

    fun createLabelLayer(options: LabelLayerOptions, onSuccess: (Any?) -> Unit);

    fun removeLabelLayer(layer: LabelLayer, onSuccess: (Any?) -> Unit);

    fun addPoiStyle(style: LabelStyles, onSuccess: (Any?) -> Unit);

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