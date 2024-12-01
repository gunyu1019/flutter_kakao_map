package kr.yhs.flutter_kakao_map.model

import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.LatLng
import com.kakao.vectormap.MapType
import com.kakao.vectormap.MapViewInfo


internal data class KakaoMapOption (
    private val onReady: (KakaoMap) -> Unit,
    private val initialPosition: LatLng? = null,
    private val zoomLevel: Int? = null,
    private val mapType: MapType? = null,
    private val viewName: String? = null,
    private val visible: Boolean = true,
    private val tag: String? = null,
) : KakaoMapReadyCallback() {
    override fun onMapReady(map: KakaoMap) = onReady(map);

    override fun getZoomLevel(): Int = zoomLevel ?: super.getZoomLevel()

    override fun getPosition(): LatLng = initialPosition ?: super.getPosition()

    override fun getMapViewInfo(): MapViewInfo {
        if (mapType == null) {
            return super.getMapViewInfo()
        } 
        return MapViewInfo.from("openmap", mapType)
    }

    override fun getViewName(): String = viewName ?: super.getViewName()

    override fun isVisible(): Boolean = visible

    override fun getTag(): String = tag ?: ""

    companion object {
        fun fromMessageable(
            onReady: (KakaoMap) -> Unit
            rawArgs: Map<String, Any>
        ): KakaoMapOption {
            return KakaoMapOption(
                onReady=onReady,
                initialPosition=LatLng.from(
                    rawArgs["latitude"] as Double,
                    rawArgs["longitude"] as Double
                ),
                zoomLevel = rawArgs["zoomLevel"] as Int?,
                viewName = rawArgs["viewName"] as String?,
                mapType = (
                    if (rawArgs.containsKey("mapType"))
                    MapType.getEnum(rawArgs["mapType"] as String)
                    else null
                ),
                visible = rawArgs["visible"] as Boolean? ?: true,
                tag = rawArgs["tag"] as String?
            )
        }
    }
}