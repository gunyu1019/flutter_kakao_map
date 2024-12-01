package kr.yhs.flutter_kakao_map.converter

import com.kakao.vectormap.LatLng


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
}