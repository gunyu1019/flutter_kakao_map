package kr.yhs.flutter_kakao_map.model

import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.LatLng


class KakaoMapOption (
    private val onReady: (KakaoMap) -> Unit,
    private val initialPosition: LatLng? = null,
    private val zoomLevel: Int? = null
) : KakaoMapReadyCallback() {
    override fun onMapReady(map: KakaoMap) = onReady(map);

    override fun getZoomLevel(): Int = zoomLevel ?: super.getZoomLevel()

    override fun getPosition(): LatLng = initialPosition ?: super.getPosition()
}