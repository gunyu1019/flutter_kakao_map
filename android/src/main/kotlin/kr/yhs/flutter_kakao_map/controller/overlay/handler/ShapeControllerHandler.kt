package kr.yhs.flutter_kakao_map.controller.overlay.handler

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asLong
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import kr.yhs.flutter_kakao_map.converter.ShapeTypeConverter.asShapeLayerOption
import kr.yhs.flutter_kakao_map.converter.ShapeTypeConverter.asPolygonOption
import kr.yhs.flutter_kakao_map.converter.ShapeTypeConverter.asPolylineOption
import kr.yhs.flutter_kakao_map.converter.ShapeTypeConverter.asPolygonStylesSet
import kr.yhs.flutter_kakao_map.converter.ShapeTypeConverter.asPolylineStylesSet
import com.kakao.vectormap.shape.ShapeManager
import com.kakao.vectormap.shape.ShapeLayer
import com.kakao.vectormap.shape.ShapeLayerOptions
import com.kakao.vectormap.shape.PolygonStylesSet
import com.kakao.vectormap.shape.PolylineOptions
import com.kakao.vectormap.shape.PolygonOptions
import com.kakao.vectormap.shape.PolylineStylesSet
import com.kakao.vectormap.label.PolylineLabelStyles

interface ShapeControllerHandler {
    val shapeManager: ShapeManager?

    fun shapeHandle(call: MethodCall, result: MethodChannel.Result) {
        val arguments = call.arguments!!.asMap<Any?>()
        if (shapeManager == null) {
            throw NullPointerException("ShapeManager is null.")
        }
        val layer = arguments["layerId"]?.asString()?.let<String, ShapeLayer> {
            shapeManager!!.getLayer(it)
        }

        val polylineShape = layer?.run {
            arguments["polylineId"]?.asString()?.let(layer::getPolyline)
        }
        val polygonShape = layer?.run {
            arguments["polygonId"]?.asString()?.let(layer::getPolyline)
        }

        when(call.method) {
            "createShapeLayer" -> createShapeLayer(arguments.asShapeLayerOption(), result::success)
            "removeShapeLayer" -> removeShapeLayer(layer!!, result::success)
            "addPolylineShapeStyle" -> addPolylineShapeStyle(arguments.asPolylineStylesSet(), result::success)
            "addPolygonShapeStyle" -> addPolygonShapeStyle(arguments.asPolygonStylesSet(), result::success)
            "addPolylineShape" -> {
                val shapeOption = arguments["polyline"]!!.asPolylineOption(shapeManager!!)
                addPolylineShape(layer!!, shapeOption, result::success)
            }
            "addPolygonShape" -> {
                val shapeOption = arguments["polygon"]!!.asPolygonOption(shapeManager!!)
                addPolygonShape(layer!!, shapeOption, result::success)
            }
            "removePolylineShape" -> {}
            "removePolygonShape" -> {}
            "changePolylineVisible" -> {}
            "changePolygonVisible" -> {}
            "changePolylineStyle" -> {}
            "changePolygonStyle" -> {}
            "changePolylinePosition" -> {}
            "changePolygonPosition" -> {}
            else -> result.notImplemented()
        }
    }

    fun createShapeLayer(options: ShapeLayerOptions, onSuccess: (Any?) -> Unit);

    fun removeShapeLayer(layer: ShapeLayer, onSuccess: (Any?) -> Unit);

    fun addPolylineShapeStyle(style: PolylineStylesSet, onSuccess: (String) -> Unit);

    fun addPolygonShapeStyle(style: PolygonStylesSet, onSuccess: (String) -> Unit);

    fun addPolylineShape(layer: ShapeLayer, shape: PolylineOptions, onSuccess: (String) -> Unit);

    fun addPolygonShape(layer: ShapeLayer, shape: PolygonOptions, onSuccess: (String) -> Unit);
}
