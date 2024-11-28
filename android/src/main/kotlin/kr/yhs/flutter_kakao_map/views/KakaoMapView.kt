package kr.yhs.flutter_kakao_map.views

import android.app.Activity
import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.util.Base64
import android.util.Log
import android.view.View
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.KakaoMapSdk
import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.MapView
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
): PlatformView, MethodChannel.MethodCallHandler {
    private val mapView = MapView(context)

    override fun getView(): View {
        channel.setMethodCallHandler(this)
        return mapView
    }

    override fun dispose() {
        // mapView.finish();
    }

    override fun onMethodCall(method: MethodCall, result: MethodChannel.Result) {
        if (method.method == "start") {
            KakaoMapSdk.init(context, "4158a148fb2f4ec780b87e53b86c4b38")

            mapView.start(object : MapLifeCycleCallback() {
                override fun onMapDestroy() {

                }

                override fun onMapError(exception: Exception?) {
                    Log.e("ERROR", exception?.message?:"ERROR")
                }
            }, object : KakaoMapReadyCallback() {
                override fun onMapReady(map: KakaoMap) {
                    Log.i("KakaoMap", "ready")
                }
            })
            result.success(true)
        } else if (method.method == "hashCode") {

            var packageInfo: PackageInfo? = null
            try {
                packageInfo = activity.packageManager.getPackageInfo(activity.packageName, PackageManager.GET_SIGNATURES)
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }
            if (packageInfo == null) Log.e("KeyHash", "KeyHash:null")

            for (signature in packageInfo!!.signatures) {
                try {
                    val md = MessageDigest.getInstance("SHA")
                    md.update(signature.toByteArray())
                    Log.d("KeyHash", Base64.encodeToString(md.digest(), Base64.DEFAULT))
                } catch (e: NoSuchAlgorithmException) {
                    Log.e("KeyHash", "Unable to get MessageDigest. signature=$signature", e)
                }
            }
        }
    }
}
