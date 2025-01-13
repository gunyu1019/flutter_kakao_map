package kr.yhs.flutter_kakao_map.controller.overlay

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelLayerOptions
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
    }

    override fun createLabelLayer(options: LabelLayerOptions, onSuccess: (Any?) -> Unit) { 
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        labelManager!!.addLayer(options);
        onSuccess.invoke(null)
    }

    override fun addPoi(layerId: String, poi: LabelOptions, onSuccess: (String) -> Unit) { 
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        val layer = labelManager!!.getLayer(layerId)
        val label = layer.addLabel(poi)
        onSuccess.invoke(label.getLabelId())
    }

    override fun removePoi(layerId: String, poiId: String, onSuccess: Function1<Any?, Unit>) {
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        val layer = labelManager!!.getLayer(layerId)
        val poi = layer.getLabel(poiId)
        layer.remove(poi)
        onSuccess.invoke(null)
    }

    override fun changePoiOffsetPosition(layerId: String, poiId: String, x: Float, y: Float, forceDpScale: Boolean?, onSuccess: Function1<Any?, Unit>) {
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        val layer = labelManager!!.getLayer(layerId)
        val poi = layer.getLabel(poiId)
        if (forceDpScale == null) {
            poi.changePixelOffset(x, y)
        } else {
            poi.changePixelOffset(x, y, forceDpScale)
        }
        onSuccess.invoke(null)
    }

    override fun changePoiVisible(layerId: String, poiId: String, visible: Boolean, onSuccess: Function1<Any?, Unit>) { 
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        val layer = labelManager!!.getLayer(layerId)
        val poi = layer.getLabel(poiId)
        if (visible) {
            poi.show()
        } else {
            poi.hide()
        }
        onSuccess.invoke(null)
    }

    override fun changePoiStyle(layerId: String, poiId: String, styleId: String, onSuccess: Function1<Any?, Unit>) { 
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        val layer = labelManager!!.getLayer(layerId)
        val poiStyle = labelManager!!.getLabelStyles(styleId)
        val poi = layer.getLabel(poiId)
        poi.changeStyles(poiStyle)
        onSuccess.invoke(null)
     }

    override fun changePoiText(layerId: String, poiId: String, text: String, onSuccess: Function1<Any?, Unit>) {
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        val layer = labelManager!!.getLayer(layerId)
        val poi = layer.getLabel(poiId)
        poi.changeText(text.asLabelTextBuilder())
        onSuccess.invoke(null)
    }

    override fun invalidatePoi(layerId: String, poiId: String, styleId: String, text: String, transition: Boolean, onSuccess: Function1<Any?, Unit>) { }

    override fun invalidatePoi(layerId: String, poiId: String, position: LatLng, millis: Double?, onSuccess: Function1<Any?, Unit>) { }

    override fun rotatePoi(layerId: String, poiId: String, angle: Double, millis: Double?, onSuccess: Function1<Any?, Unit>) { }

    override fun scalePoi(layerId: String, poiId: String, x: Double, y: Double, millis: Double?, onSuccess: Function1<Any?, Unit>) { }

    override fun rankPoi(layerId: String, poiId: String, rank: Long, onSuccess: Function1<Any?, Unit>) { }
}