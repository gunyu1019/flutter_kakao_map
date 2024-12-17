package kr.yhs.flutter_kakao_map.model

import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdate
import com.kakao.vectormap.camera.CameraUpdateFactory
import com.kakao.vectormap.LatLng


data class KCameraUpdate(
    val type: Int,
    val position: LatLng? = null,
    val zoomLevel: Int = -1,
    val tiltAngle: Double = -1.0,
    val rotateionAngle: Double = -1.0,
    val height: Double = -1.0,
    val fitPoints: Array<LatLng>? = null,
    val padding: Int = -1
) {
    fun toCameraUpdate(): CameraUpdate {
        return when(type) {
            CameraUpdateFactory.NewCenterPoint -> CameraUpdateFactory.newCenterPosition(position, zoomLevel)
            // CameraUpdateFactory.NewCameraPos -> CameraUpdateFactory.newCameraPosition(position)
            CameraUpdateFactory.ZoomTo -> CameraUpdateFactory.zoomTo(zoomLevel)
            CameraUpdateFactory.ZoomIn -> CameraUpdateFactory.zoomIn()
            CameraUpdateFactory.ZoomOut -> CameraUpdateFactory.zoomOut()
            else -> throw NotImplementedError("wrong type");
        }
    }
};