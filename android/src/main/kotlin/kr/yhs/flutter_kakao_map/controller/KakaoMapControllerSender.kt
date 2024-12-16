package kr.yhs.flutter_kakao_map.controller

import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.KakaoMap

interface KakaoMapControllerSender {
    fun onMapReady(kakaoMap: KakaoMap)

    fun onMapDestroyed()

    fun onMapError(exception: Exception)
}