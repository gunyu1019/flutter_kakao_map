package kr.yhs.flutter_kakao_maps.listener

import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.label.LabelLayer
import com.kakao.vectormap.label.LodLabelLayer
import com.kakao.vectormap.label.Label
import com.kakao.vectormap.label.LodLabel
import com.kakao.vectormap.camera.CameraPosition
import io.flutter.plugin.common.MethodChannel
import kr.yhs.flutter_kakao_maps.converter.CameraTypeConverter.toMessageable
import kr.yhs.flutter_kakao_maps.model.KakaoMapEvent


class PoiClickListener(
    private val channel: MethodChannel
) : KakaoMap.OnLabelClickListener, KakaoMap.OnLodLabelClickListener {
    override fun onLabelClicked(kakaoMap: KakaoMap, layer: LabelLayer, label: Label): Boolean {
        channel.invokeMethod("onPoiClick", mapOf(
            "layerId" to layer.layerId,
            "poiId" to label.labelId
        ))
        return true
    }
    
    override fun onLodLabelClicked(kakaoMap: KakaoMap, layer: LodLabelLayer, label: LodLabel): Boolean {
        channel.invokeMethod("onLodPoiClick", mapOf(
            "layerId" to layer.layerId,
            "poiId" to label.labelId
        ))
        return true
    }
}