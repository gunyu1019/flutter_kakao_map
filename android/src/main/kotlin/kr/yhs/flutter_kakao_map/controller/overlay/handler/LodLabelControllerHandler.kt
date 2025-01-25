package kr.yhs.flutter_kakao_map.controller.overlay.handler

import com.kakao.vectormap.label.LabelLayerOptions
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LodLabel
import com.kakao.vectormap.label.LodLabelLayer
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelLayerOptions
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelOptions
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asLong
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString

interface LodLabelControllerHandler {
    val labelManager: LabelManager?

    fun lodLabelHandle(call: MethodCall, result: MethodChannel.Result) {
        val arguments = call.arguments!!.asMap<Any?>()
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.")
        }

        val layer =
                arguments["layerId"]?.asString()?.let<String, LodLabelLayer> {
                    labelManager!!.getLodLayer(it)
                }
        val poi = layer?.run { arguments["poiId"]?.asString()?.let(layer::getLabel) }

        when (call.method) {
            "createLodLabelLayer" -> {
                createLodLabelLayer(arguments.asLabelLayerOptions(), result::success)
            }
            "removeLodLabelLayer" -> {
                removeLodLabelLayer(layer!!, result::success)
            }
            "addLodPoi" -> {
                val poiOption = arguments["poi"]!!.asLabelOptions(labelManager!!)
                addLodPoi(layer!!, poiOption, result::success)
            }
            "removeLodPoi" -> removeLodPoi(layer!!, poi!!, result::success)
            // poi Handler
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
            "rankPoi" -> {
                val rank = arguments["x"]?.asLong()!!
                rankPoi(poi!!, rank, result::success)
            }
            else -> result.notImplemented()
        }
    }

    fun createLodLabelLayer(options: LabelLayerOptions, onSuccess: (Any?) -> Unit)

    fun removeLodLabelLayer(layer: LodLabelLayer, onSuccess: (Any?) -> Unit)

    fun addLodPoi(layer: LodLabelLayer, poi: LabelOptions, onSuccess: (String) -> Unit)

    fun removeLodPoi(layer: LodLabelLayer, poi: LodLabel, onSuccess: (Any?) -> Unit)

    // Lod-Poi Controller
    fun changePoiVisible(poi: LodLabel, visible: Boolean, onSuccess: (Any?) -> Unit)

    fun changePoiStyle(poi: LodLabel, styleId: String, onSuccess: (Any?) -> Unit)

    fun changePoiText(poi: LodLabel, text: String, onSuccess: (Any?) -> Unit)

    fun rankPoi(poi: LodLabel, rank: Long, onSuccess: (Any?) -> Unit)
}
