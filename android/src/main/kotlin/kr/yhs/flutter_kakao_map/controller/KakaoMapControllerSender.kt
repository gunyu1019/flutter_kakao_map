package kr.yhs.flutter_kakao_map.controller

import com.kakao.vectormap.MapLifeCycleCallback

internal interface KakaoMapControlSender {
    fun onMapReady()

    fun onMapDestroyed()
}