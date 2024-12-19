
package kr.yhs.flutter_kakao_map.controller

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.LatLng
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdate
import com.kakao.vectormap.camera.CameraUpdateFactory
import com.kakao.vectormap.camera.CameraAnimation
import com.kakao.vectormap.MapAuthException
import com.kakao.vectormap.MapLifeCycleCallback
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.toMessageable
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asLatLng
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asCameraPosition
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asCameraAnimation

class KakaoMapController(
    private val context: Context,
    private val channel: MethodChannel,
): KakaoMapControllerHandler, KakaoMapControllerSender, MapLifeCycleCallback() {
    private lateinit var kakaoMap: KakaoMap

    init {
        channel.setMethodCallHandler(::handle)
    }

    override fun getCameraPosition(onSuccess: (cameraPosition: Map<String, Any>) -> Unit) { 
        kakaoMap.getCameraPosition()?.toMessageable().let { onSuccess }
        Log.i("flutter", (kakaoMap.getCameraPosition()?.toMessageable()).toString())
    }

    override fun moveCamera(
        cameraUpdate: CameraUpdate,
        cameraAnimation: CameraAnimation?,
        onSuccess: (Any?) -> Unit
    ) { 
        if (cameraAnimation != null) {
            kakaoMap.moveCamera(cameraUpdate, cameraAnimation)
        } else {
            kakaoMap.moveCamera(cameraUpdate)
        }
        onSuccess(null)
    }

    override fun onMapReady(kakaoMap: KakaoMap) {
        this.kakaoMap = kakaoMap
        channel.invokeMethod("onMapReady", null)
    }

    override fun onMapDestroy() { 
        channel.invokeMethod("onMapDestroy", null)
    }

    override fun onMapError(exception: Exception) {
        if (exception is MapAuthException) {
            channel.invokeMethod("onMapError", mapOf(
                "className" to "MapAuthException",
                "errorCode" to exception.errorCode,
                "message" to exception.message,
            ))
            return
        }
        channel.invokeMethod("onMapError", mapOf(
            "className" to exception::javaClass.name,
            "message" to exception.message,
        ))
    }
    
    fun dispose() {
        channel.setMethodCallHandler(null)
    }
}