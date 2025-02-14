package kr.yhs.flutter_kakao_maps.views

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
import kr.yhs.flutter_kakao_maps.model.KakaoMapOption
import kr.yhs.flutter_kakao_maps.controller.KakaoMapController
import kr.yhs.flutter_kakao_maps.controller.KakaoMapControllerSender

class KakaoMapView(
    private val activity: Activity,
    private val context: Context,
    private val controller: KakaoMapController,
    private val viewId: Int,
    private val option: KakaoMapOption,
    private val channel: MethodChannel
): PlatformView, Application.ActivityLifecycleCallbacks {
    private val mapView = MapView(activity)
    private lateinit var kakaoMap: KakaoMap

    init {
        mapView.start(controller, option)
        activity.registerActivityLifecycleCallbacks(this)
    }

    override fun getView(): View = mapView

    override fun dispose() {
        activity.unregisterActivityLifecycleCallbacks(this)
        controller.dispose()
    }

    /* Application.LifeCycleCallback Handler */
    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) = Unit

    override fun onActivityStarted(activity: Activity) = Unit

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
        activity.unregisterActivityLifecycleCallbacks(this)
    }
}
