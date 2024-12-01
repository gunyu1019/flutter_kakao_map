package kr.yhs.flutter_kakao_map.controller

import com.kakao.vectormap.MapLifeCycleCallback

internal interface KakaoMapControlHandler {
    fun getCameraPosition()

    fun moveCamera()
}