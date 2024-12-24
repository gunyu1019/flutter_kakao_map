package kr.yhs.flutter_kakao_map.listener

import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.GestureType
import com.kakao.vectormap.camera.CameraPosition
import io.flutter.plugin.common.MethodChannel
import kr.yhs.flutter_kakao_map.converter.MapTypeConverter.toMessageable
import kr.yhs.flutter_kakao_map.model.KakaoMapEvent


class CameraListener(
    private val channel: MethodChannel
) : KakaoMap.OnCameraMoveStartListener, KakaoMap.OnCameraMoveEndListener {
    override fun onCameraMoveStart(kakaoMap: KakaoMap, gestureType: GestureType) {
        channel.invokeMethod("onCameraMoveStart", mapOf(
            "gesture" to gestureType.value
        ))
    }
    
    override fun onCameraMoveEnd(kakaoMap: KakaoMap, cameraPosition: CameraPosition, gestureType: GestureType) {
        channel.invokeMethod("onCameraMoveEnd", mapOf(
            "gesture" to gestureType.value,
            "position" to cameraPosition.toMessageable()
        ))
    }
}