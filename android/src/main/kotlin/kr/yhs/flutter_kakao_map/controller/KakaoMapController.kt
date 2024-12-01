
package kr.yhs.flutter_kakao_map.controller

import android.content.Context
import io.flutter.plugin.common.MethodChannel
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.camera.CameraPosition

class KakaoMapController(
    private val context: Context,
    private val channel: MethodChannel,
    private val kakaoMap: KakaoMap
): KakaoMapControllerHandler, KakaoMapControllerSender {
    init {

    }

    override fun getCameraPosition() { 
        val position: CameraPosition? = kakaoMap.getCameraPosition()
    }

    override fun moveCamera() { 
        
    }

    override fun onMapReady() {
        channel.invokeMethod("onMapReady", null)
    }

    override fun onMapDestroyed() { 
        channel.invokeMethod("onMapDestroyed", null)
    }

    override fun onMapException() {
        channel.invokeMethod("onMapDestroyed", null)
    }
    
}