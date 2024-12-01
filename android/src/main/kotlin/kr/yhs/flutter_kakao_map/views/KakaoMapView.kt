package kr.yhs.flutter_kakao_map.views

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.util.Base64
import android.util.Log
import android.view.View
import android.os.Bundle
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.KakaoMapSdk
import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.MapView
import com.kakao.vectormap.MapReadyCallback
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.lang.Exception
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

class KakaoMapView(
    private val activity: Activity,
    private val context: Context,
    private val viewId: Int,
    private val creationParams: Map<String, Any?>?,
    private val channel: MethodChannel
): PlatformView, Application.ActivityLifecycleCallbacks {
    private lateinit var mapView: MapView
    private lateinit var kakaoMap: KakaoMap
    
    private fun handler(method: MethodCall, result: MethodChannel.Result) {
    }

    init {
        channel.setMethodCallHandler(::handler)
    }

    override fun getView(): View = mapView

    override fun dispose() {
        mapView = MapView(activity);
        channel.setMethodCallHandler(null)
    }

    /* Application.LifeCycleCallback Handler */
    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) = Unit

    override fun onActivityStarted(activity: Activity) {
        mapView.start(object : MapLifeCycleCallback {

        }, object : KakaoMapReadyCallback {
            override fun onMapReady() 
        })
    }

    override fun onActivityResumed(activity: Activity) {
        if (activity != this.activity) return
        mapView.resume()
    }

    override fun onActivityPaused(activity: Activity) {
        if (activity != this.activity) return
        mapView.pause()
    }

    override fun onActivityStopped(activity: Activity) = Unit

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) = Unit

    override fun onActivityDestroyed(activity: Activity) {
        if (activity != this.activity) return
        mapView.finish()
    }
}
