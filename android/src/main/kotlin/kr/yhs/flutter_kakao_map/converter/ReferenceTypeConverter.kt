package kr.yhs.flutter_kakao_map.converter

import com.kakao.vectormap.LatLng
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraAnimation
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap


object ReferenceTypeConverter {
    fun Any.asLatLng(): LatLng? = asMap<Double?>().let { map: Map<String, Double?> ->
        if (map.containsKey("latitude") && map.containsKey("longitude"))
            LatLng.from(
                map["latitude"]!!,
                map["longitude"]!!
            )
        else 
            null
    }

    fun LatLng.toMessageable(): Map<String, Double> = mapOf(
        "latitude" to latitude,
        "longitude" to longitude
    )

    fun Any.asCameraPosition(): CameraPosition = asMap<Any>().let { map: Map<String, Any> ->
        CameraPosition.from(
            map["latitude"] as Double,
            map["longitude"] as Double,
            map["zoomLevel"] as Int? ?: -1,
            map["tiltAngle"] as Double? ?: -1.0,
            map["rotationAngle"] as Double? ?: -1.0,
            map["height"] as Double? ?: -1.0,
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

    fun Any.asCameraAnimation(): CameraAnimation = asMap<Any>().let { map: Map<String, Any?> ->
        CameraAnimation.from(
            map["duration"] as Int,
            map["autoElevation"] as Boolean? ?: false, 
            map["isConsecutive"] as Boolean? ?: false
        )
    }
}