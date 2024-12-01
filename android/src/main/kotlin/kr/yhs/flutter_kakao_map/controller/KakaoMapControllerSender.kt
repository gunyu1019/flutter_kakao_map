package kr.yhs.flutter_kakao_map.controller

import com.kakao.vectormap.MapLifeCycleCallback

interface KakaoMapControllerSender {
    fun onMapReady()

    fun onMapDestroyed()

    fun onMapException()
}