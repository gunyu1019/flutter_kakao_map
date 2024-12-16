
package kr.yhs.flutter_kakao_map.controller

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.LatLng
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdate
import com.kakao.vectormap.camera.CameraUpdateFactory
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
    }

    private fun baseMoveCamera(
        cameraUpdate: CameraUpdate,
        cameraAnimation: Map<String, Any>?,
        onSuccess: () -> Unit
    ) {
        kakaoMap.moveCamera(cameraUpdate, cameraAnimation?.asCameraAnimation())
    }

    override fun moveCamera(
        cameraUpdate: Map<String, Any>,
        cameraAnimation: Map<String, Any>?,
        onSuccess: () -> Unit
    ) { 
        CameraUpdateFactory.newCameraPosition(cameraUpdate.asCameraPosition()).let { newCameraUpdate ->
            baseMoveCamera(newCameraUpdate, cameraAnimation, onSuccess)
        }
    }

    override fun moveCamera(
        points: List<Map<String, Any>>,
        padding: Int?,
        maxZoomLevel: Int?,
        cameraAnimation: Map<String, Any>?,
        onSuccess: () -> Unit
    ) { 
        CameraUpdateFactory.fitMapPoints(
            points.map { point -> point.asLatLng() }.toTypedArray(), 
            padding ?: 0, 
            maxZoomLevel ?: -1
        ).let { newCameraUpdate ->
            baseMoveCamera(newCameraUpdate, cameraAnimation, onSuccess)
        }
    }

    override fun onMapReady(kakaoMap: KakaoMap) {
        this.kakaoMap = kakaoMap
        channel.invokeMethod("onMapReady", null)
    }

    override fun onMapDestroy() { 
        channel.invokeMethod("onMapDestroy", null)
    }

    override fun onMapError(exception: Exception) {
        Log.i("flutter", "exception-catch-point-1")
        if (exception is MapAuthException) {
            Log.i("flutter", "exception-catch-point-2 ${exception.errorCode}")
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