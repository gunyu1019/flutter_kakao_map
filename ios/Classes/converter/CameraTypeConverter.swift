
internal extension MapPoint {
    init(payload: Dictionary<String, Any>) {
        let convertedPayload = asDictTyped(payload, asDouble)
        init(convertedPayload)
    }

    init(payload: Dictionary<String, Double>) {
        init(
            latitude: payload["latitude"]!,
            longitude: payload["longitude"]!
        )
    }

    func toMessageable() -> Dictionary<String, Double> {
        [
            "latitude": self.latitude,
            "longitude": self.longitude
        ]
    }
}

internal extension CameraUpdate {
    init(payload: Dictionary<String, Any>) {
        
    }
}

internal extension CameraAnimationOptions {
    init(payload: Dictionary<String, Any>) {
        self.autoElevation = asBoolean(payload["autoElevation"] ?? false )
        self.consecutive = asBoolean(payload["autoElevation"] ?? false)
        self.durationInMillis = asInt(payload["duration"]!)
    }
}