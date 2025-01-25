package kr.yhs.flutter_kakao_map.controller.overlay

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelLayer
import com.kakao.vectormap.label.Label
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelStyles
import com.kakao.vectormap.label.LabelLayerOptions
import com.kakao.vectormap.label.PolylineLabelOptions
import com.kakao.vectormap.label.PolylineLabel
import com.kakao.vectormap.label.PolylineLabelStyles
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.LatLng
import kr.yhs.flutter_kakao_map.controller.overlay.handler.LabelControllerHandler
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.LabelTypeConverter.asLabelTextBuilder
import kr.yhs.flutter_kakao_map.model.OverlayType
import android.util.Log


class OverlayController(
    private val channel: MethodChannel,
    private val kakaoMap: KakaoMap
): LabelControllerHandler {
    override val labelManager: LabelManager? get() = kakaoMap.getLabelManager()

    init {
        channel.setMethodCallHandler(::handle)
    }
    
    fun handle(call: MethodCall, result: MethodChannel.Result) = when (OverlayType.values().filter { call.arguments.asMap<Int>()["type"]!! == it.value }.first()) {
        OverlayType.Label -> labelHandle(call, result)
        OverlayType.LodLabel -> {}
        OverlayType.Shape -> {}
    }

    override fun createLabelLayer(options: LabelLayerOptions, onSuccess: (Any?) -> Unit) { 
        labelManager!!.addLayer(options);
        onSuccess.invoke(null)
    }

    override fun removeLabelLayer(layer: LabelLayer, onSuccess: (Any?) -> Unit) {
        labelManager!!.remove(layer)
        onSuccess.invoke(null)
    }

    override fun addPoiStyle(style: LabelStyles, onSuccess: (Any?) -> Unit) {
        labelManager!!.addLabelStyles(style).let { it ->
            onSuccess.invoke(it?.styleId)
        }
    }

    override fun addPoi(layer: LabelLayer, poi: LabelOptions, onSuccess: (String) -> Unit) {
        val label = layer.addLabel(poi)
        onSuccess.invoke(label.getLabelId())
    }

    override fun removePoi(layer: LabelLayer, poi: Label, onSuccess: Function1<Any?, Unit>) {
        layer.remove(poi)
        onSuccess.invoke(null)
    }

    override fun addPolylineText(layer: LabelLayer, label: PolylineLabelOptions, onSuccess: (String) -> Unit) {
        val polylineText = layer.addPolylineLabel(label)
        onSuccess.invoke(polylineText.getLabelId())
    }

    override fun removePolylineText(layer: LabelLayer, label: PolylineLabel, onSuccess: (Any?) -> Unit) {
        layer.remove(label)
        onSuccess.invoke(null)
    }

    override fun changePoiOffsetPosition(poi: Label, x: Float, y: Float, forceDpScale: Boolean?, onSuccess: Function1<Any?, Unit>) {
        forceDpScale?.let { poi.changePixelOffset(x, y, it) } ?: poi.changePixelOffset(x, y)
        onSuccess.invoke(null)
    }

    override fun changePoiVisible(poi: Label, visible: Boolean, onSuccess: Function1<Any?, Unit>) { 
        if (visible) {
            poi.show()
        } else {
            poi.hide()
        }
        onSuccess.invoke(null)
    }

    override fun changePoiStyle(poi: Label, styleId: String, onSuccess: Function1<Any?, Unit>) { 
        val poiStyle = labelManager!!.getLabelStyles(styleId)
        poi.changeStyles(poiStyle)
        onSuccess.invoke(null)
     }

    override fun changePoiText(poi: Label, text: String, onSuccess: Function1<Any?, Unit>) {
        poi.changeText(text.asLabelTextBuilder())
        onSuccess.invoke(null)
    }

    override fun invalidatePoi(poi: Label, styleId: String, text: String, transition: Boolean, onSuccess: Function1<Any?, Unit>) { 
        val poiStyle = labelManager!!.getLabelStyles(styleId)
        poi.setStyles(poiStyle)
        poi.setTexts(text.asLabelTextBuilder())
        poi.invalidate(transition)
        onSuccess.invoke(null)
    }

    override fun movePoi(poi: Label, position: LatLng, millis: Int?, onSuccess: Function1<Any?, Unit>) { 
        millis?.let { poi.moveTo(position, it) } ?: poi.moveTo(position)
        onSuccess.invoke(null)
    }

    override fun rotatePoi(poi: Label, angle: Float, millis: Int?, onSuccess: Function1<Any?, Unit>) {
        millis?.let { poi.rotateTo(angle, it) } ?: poi.rotateTo(angle)
        onSuccess.invoke(null)
    }

    override fun scalePoi(poi: Label, x: Float, y: Float, millis: Int?, onSuccess: Function1<Any?, Unit>) {
        millis?.let { poi.scaleTo(x, y, it) } ?: poi.scaleTo(x, y)
        onSuccess.invoke(null)
    }

    override fun rankPoi(poi: Label, rank: Long, onSuccess: Function1<Any?, Unit>) { 
        poi.changeRank(rank)
        onSuccess.invoke(null)
    }

    override fun changePolylineTextAndStyle(label: PolylineLabel, style: PolylineLabelStyles, text: String?, onSuccess: (Any?) -> Unit) {
        text?.let { 
            label.changeTextAndStyles(it, style)
        } ?: label.changeStyles(style)
        onSuccess.invoke(null)
    }

    override fun changePolylineTextVisible(label: PolylineLabel, visible: Boolean, onSuccess: (Any?) -> Unit) {
        if (visible) {
            label.show()
        } else {
            label.hide()
        }
        onSuccess.invoke(null)
    }
}