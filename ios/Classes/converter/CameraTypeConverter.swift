import KakaoMapsSDK

internal extension MapPoint {
    convenience init(payload: Dictionary<String, Any>) {
        self.init(
            longitude: asDouble(payload["longitude"]!),
            latitude: asDouble(payload["latitude"]!)
        )
    }

    convenience init(payload: Dictionary<String, Double>) {
        self.init(
            longitude: payload["longitude"]!,
            latitude: payload["latitude"]!
        )
    }

    func toMessageable() -> Dictionary<String, Double> {
        [
            "latitude": self.wgsCoord.latitude,
            "longitude": self.wgsCoord.longitude
        ]
    }
}

internal func asCameraUpdate(kakaoMap: KakaoMap, payload: Dictionary<String, Any>) -> CameraUpdate {
    let cameraUpdateType = asInt(payload["type"]!)
    let zoomLevel = castSafty(payload["zoomLevel"], caster: asInt) ?? kakaoMap.zoomLevel
    let angle = castSafty(payload["angle"], caster: asDouble)
    switch cameraUpdateType {
    case 0: return CameraUpdate.make(target: MapPoint(payload: payload), zoomLevel: zoomLevel, mapView: kakaoMap)
    case 1: 
        return CameraUpdate.make(
            target: MapPoint(payload: payload),
            zoomLevel: zoomLevel,
            rotation: asDouble(payload["rotationAngle"] ?? kakaoMap.rotationAngle),
            tilt: asDouble(payload["tiltAngle"] ?? kakaoMap.tiltAngle),
            mapView: kakaoMap
        )
    case 3: return CameraUpdate.make(zoomLevel: zoomLevel, mapView: kakaoMap)
    case 4: return CameraUpdate.make(zoomLevel: kakaoMap.zoomLevel+1, mapView: kakaoMap)
    case 5: return CameraUpdate.make(zoomLevel: kakaoMap.zoomLevel-1, mapView: kakaoMap)
    case 6: return CameraUpdate.make(rotation: angle!, tilt: kakaoMap.tiltAngle, mapView: kakaoMap)
    case 7: return CameraUpdate.make(rotation: kakaoMap.rotationAngle, tilt: angle!, mapView: kakaoMap)
    case 8: return CameraUpdate.make(
        area: AreaRect(points: asArray<Dictionary>(payload["points"]!, caster: asDict).map {
            element in MapPoint(payload: element)
        }),
        levelLimit: zoomLevel
    )
    default: return CameraUpdate.make(mapView: kakaoMap)
    }
}

internal extension CameraAnimationOptions {
    init(payload: Dictionary<String, Any>) {
        self.init(
            autoElevation: ObjCBool(asBool(payload["autoElevation"] ?? false )),
            consecutive: ObjCBool(asBool(payload["autoElevation"] ?? false)),
            durationInMillis: UInt(asInt(payload["duration"]!))
        )
    }
}
