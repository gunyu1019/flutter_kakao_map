package kr.yhs.flutter_kakao_map.controller.overlay

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.KakaoMap
import kr.yhs.flutter_kakao_map.controller.overlay.handler.LabelControllerHandler


class OverlayController(
    private val channel: MethodChannel,
    private val kakaoMap: KakaoMap
): LabelControllerHandler {
    private val labelManager: LabelManager? get() = kakaoMap.getLabelManager()

    init {
        channel.setMethodCallHandler(::handle)
    }

    override fun createLabelLayer() { }

    override fun addPoi(layerId: String, poi: LabelOptions) { 
        if (labelManager == null) {
            throw NullPointerException("LabelManager is null.");
        }
        val layer = labelManager!!.getLayer(layerId)
        layer!!.addLabel(poi)
    }
}