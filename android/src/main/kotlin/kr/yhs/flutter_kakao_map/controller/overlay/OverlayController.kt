package kr.yhs.flutter_kakao_map.controller.overlay

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.KakaoMap
import kr.yhs.flutter_kakao_map.controller.overlay.handler.LabelControllerHandler
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.model.OverlayType


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

    override fun createLabelLayer() { }

    override fun addPoi(layerId: String, poi: LabelOptions, onSuccess: (Map<String, Any>) -> Unit) { 
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        val layer = labelManager!!.getLayer(layerId)
        layer!!.addLabel(poi)
        onSuccess(mapOf(
            "test" to "test"
        ))
    }
}