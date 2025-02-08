package kr.yhs.flutter_kakaomaps.controller

import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.KakaoMap

interface KakaoMapControllerSender {
    fun onMapReady(kakaoMap: KakaoMap)

    fun onMapDestroy()

    fun onMapResumed()

    fun onMapPaused()

    fun onMapError(exception: Exception)
}