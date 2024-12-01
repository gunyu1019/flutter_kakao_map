package kr.yhs.flutter_kakao_map.controller

import com.kakao.vectormap.MapLifeCycleCallback

interface KakaoMapControllerHandler {
    fun getCameraPosition()

    fun moveCamera()
}