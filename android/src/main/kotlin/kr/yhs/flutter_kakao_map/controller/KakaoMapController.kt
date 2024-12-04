
package kr.yhs.flutter_kakao_map.controller

import android.content.Context
import io.flutter.plugin.common.MethodChannel
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdate
import com.kakao.vectormap.camera.CameraUpdateFactory
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.toMessageable
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asCameraPosition

class KakaoMapController(
    private val context: Context,
    private val channel: MethodChannel,
    private val kakaoMap: KakaoMap
): KakaoMapControllerHandler, KakaoMapControllerSender {
    init {
        channel.setMethodCallHandler(::handle)
    }

    override fun getCameraPosition(onSuccess: (cameraPosition: Map<String, Any>) -> Unit) { 
        kakaoMap.getCameraPosition()?.toMessageable().let { onSuccess }
    }

    override fun moveCamera(
        cameraUpdate: Map<String, Any>,
        cameraAnimation: Map<String, Any>?,
        onSuccess: (cameraPosition: Map<String, Any>) -> Unit
    ) { 
        val cameraUpdate = CameraUpdateFactory.newCameraPosition(cameraUpdate.asCameraPosition())
        kakaoMap.moveCamera(cameraUpdate)
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
    
    fun dispose() {
        channel.setMethodCallHandler(null)
    }
}