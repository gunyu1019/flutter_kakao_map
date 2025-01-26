package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelLayerOptions
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelOptions
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asLong
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import com.kakao.vectormap.shape.ShapeManager
import com.kakao.vectormap.shape.ShapeLayer
import com.kakao.vectormap.shape.ShapeLayerOptions
import com.kakao.vectormap.shape.PolygonStylesSet
import com.kakao.vectormap.shape.PolylineOptions
import com.kakao.vectormap.shape.PolygonOptions
import com.kakao.vectormap.label.PolylineLabelStyles

interface ShapeControllerHandler {
    val shapeManager: ShapeManager?

    fun shapeHandle(call: MethodCall, result: MethodChannel.Result) {
        val arguments = call.arguments!!.asMap<Any?>()
        if (shapeManager == null) {
            throw NullPointerException("LabelManager is null.")
        }

        val layer = arguments["layerId"]?.asString()?.let<String, ShapeLayer> {
            shapeManager!!.getLayer(it)
        }

        when(call.method) {
            else -> result.notImplemented()
        }
    }

    fun createShapeLayer(options: ShapeLayerOptions, onSuccess: (Any?) -> Unit);

    fun removeShapeLayer(layer: ShapeLayer, onSuccess: (Any?) -> Unit);

    fun addPolylineShapeStyle(style: PolylineLabelStyles, onSuccess: (String) -> Unit);

    fun addPolygonShapeStyle(style: PolygonStylesSet, onSuccess: (String) -> Unit);

    fun addPolylineShape(layer: ShapeLayer, shape: PolylineOptions, onSuccess: (String) -> Unit);

    fun addPolygonShape(layer: ShapeLayer, shape: PolygonOptions, onSuccess: (String) -> Unit);
}
