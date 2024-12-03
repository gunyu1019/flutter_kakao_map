package kr.yhs.flutter_kakao_map.converter

import com.kakao.vectormap.LatLng
import com.kakao.vectormap.camera.CameraPosition
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap


object ReferenceTypeConverter {
    fun Any.asLatLng(): LatLng = asMap<Double>().let { map: Map<String, Double> ->
        LatLng.from(
            map["latitude"]!!,
            map["longitude"]!!
        )
    }

    fun LatLng.toMessageable(): Map<String, Double> = mapOf(
        "latitude" to latitude,
        "longitude" to longitude
    )

    fun Any.asCameraPosition(): CameraPosition = asMap().let { map: Map<String, Any> ->
        CameraPosition.from(
            map["latitude"] as Double,
            map["longitude"] as Double,
            map["zoomLevel"] as Int,
            map["tiltAngle"] as Double,
            map["rotationAngle"] as Double,
            map["height"] as Double,
        )
    }

    fun CameraPosition.toMessageable(): Map<String, Any> = mapOf(
        "latitude" to position.latitude,
        "longitude" to position.longitude,
        "zoomLevel" to zoomLevel,
        "tiltAngle" to tiltAngle,
        "rotationAngle" to rotationAngle,
        "height" to height
    )
}