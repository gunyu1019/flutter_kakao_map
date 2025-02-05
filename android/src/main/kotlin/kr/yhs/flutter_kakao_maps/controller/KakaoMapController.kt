
package kr.yhs.flutter_kakao_maps.controller

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
import com.kakao.vectormap.MapOverlay
import com.kakao.vectormap.MapType
import kr.yhs.flutter_kakao_maps.converter.CameraTypeConverter.toMessageable
import kr.yhs.flutter_kakao_maps.converter.CameraTypeConverter.asLatLng
import kr.yhs.flutter_kakao_maps.converter.CameraTypeConverter.asCameraPosition
import kr.yhs.flutter_kakao_maps.converter.CameraTypeConverter.asCameraAnimation
import kr.yhs.flutter_kakao_maps.converter.ReferenceTypeConverter.toMessageable
import kr.yhs.flutter_kakao_maps.model.KakaoMapEvent
import kr.yhs.flutter_kakao_maps.listener.CameraListener
import kr.yhs.flutter_kakao_maps.controller.KakaoMapController
import kr.yhs.flutter_kakao_maps.controller.overlay.OverlayController

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
    
    override fun fromScreenPoint(
        x: Int,
        y: Int,
        onSuccess: (Map<String, Any>?) -> Unit
    ) {
        kakaoMap.fromScreenPoint(x, y)?.toMessageable().let(onSuccess::invoke)
    }

    override fun toScreenPoint(
        position: LatLng,
        onSuccess: (Map<String, Any>?) -> Unit
    ) {
        kakaoMap.toScreenPoint(position)?.toMessageable().let(onSuccess::invoke)
    }

    override fun clearCache(onSuccess: (Any?) -> Unit) {
        kakaoMap.clearAllCache()
        onSuccess.invoke(null)
    }

    override fun clearDiskCache(onSuccess: (Any?) -> Unit) {
        kakaoMap.clearDiskCache()
        onSuccess.invoke(null)
    }

    override fun canPositionVisible(
        zoomLevel: Int,
        position: List<LatLng>,
        onSuccess: (Boolean) -> Unit
    ) {
        kakaoMap.canShowMapPoints(zoomLevel, *position.toTypedArray()).let(onSuccess::invoke)
    }

    override fun changeMapType(
        mapType: MapType,
        onSuccess: (Any?) -> Unit
    ) {
        kakaoMap.changeMapType(mapType)
        onSuccess.invoke(null)
    }

    override fun overlayVisible(
        overlayType: MapOverlay,
        visible: Boolean,
        onSuccess: (Any?) -> Unit
    ) {
        if (visible) {
            kakaoMap.showOverlay(overlayType)
        } else {
            kakaoMap.hideOverlay(overlayType)
        }
        onSuccess.invoke(null)
    }

    override fun getBuildingHeightScale(
        onSuccess: (Float) -> Unit
    ) {
        kakaoMap.buildingHeightScale.let(onSuccess::invoke)
    }

    override fun setBuildingHeightScale(
        scale: Float,
        onSuccess: (Any?) -> Unit
    ) {
        kakaoMap.buildingHeightScale = scale
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