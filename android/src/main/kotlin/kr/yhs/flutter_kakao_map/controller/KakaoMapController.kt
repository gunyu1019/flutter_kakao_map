
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
import com.kakao.vectormap.GestureType
import kr.yhs.flutter_kakao_map.converter.CameraTypeConverter.toMessageable
import kr.yhs.flutter_kakao_map.converter.CameraTypeConverter.asLatLng
import kr.yhs.flutter_kakao_map.converter.CameraTypeConverter.asCameraPosition
import kr.yhs.flutter_kakao_map.converter.CameraTypeConverter.asCameraAnimation
import kr.yhs.flutter_kakao_map.model.KakaoMapEvent
import kr.yhs.flutter_kakao_map.listener.CameraListener
import kr.yhs.flutter_kakao_map.controller.KakaoMapController
import kr.yhs.flutter_kakao_map.controller.overlay.OverlayController

class KakaoMapController(
    private val viewId: Int,
    private val context: Context,
    private val channel: MethodChannel,
    private val overlayChannel: MethodChannel
): KakaoMapControllerHandler, KakaoMapControllerSender, MapLifeCycleCallback() {
    private lateinit var kakaoMap: KakaoMap
    private lateinit var overlayController: OverlayController

    // listener
    private val cameraListener = CameraListener(channel)

    init {
        channel.setMethodCallHandler(::handle)
    }
    
    /* Handler */
    override fun getCameraPosition(onSuccess: (cameraPosition: Map<String, Any>) -> Unit) { 
        kakaoMap.getCameraPosition(object : KakaoMap.OnCameraPositionListener {
            override fun onCameraPosition(cameraPosition: CameraPosition) {
                cameraPosition.toMessageable().let(onSuccess)
            }
        });
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

    override fun setGestureEnable(
        gestureType: GestureType,
        enable: Boolean,
        onSuccess: (Any?) -> Unit
    ) {
        kakaoMap.setGestureEnable(gestureType, enable)
        onSuccess(null)
    }

    override fun setEventHandler(event: Int) {
        if(KakaoMapEvent.CameraMoveStart.compare(event)) {
            kakaoMap.setOnCameraMoveStartListener(cameraListener)
        }
        if(KakaoMapEvent.CameraMoveEnd.compare(event)) {
            kakaoMap.setOnCameraMoveEndListener(cameraListener)
        }
    }

    /* Sender */
    override fun onMapReady(kakaoMap: KakaoMap) {
        this.kakaoMap = kakaoMap
        this.overlayController = OverlayController(overlayChannel,kakaoMap)
        channel.invokeMethod("onMapReady", null)
    }

    override fun onMapDestroy() { 
        channel.invokeMethod("onMapDestroy", null)
    }

    override fun onMapResumed() {
        channel.invokeMethod("onMapResumed", null)
    }

    override fun onMapPaused() {
        channel.invokeMethod("onMapPaused", null)
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