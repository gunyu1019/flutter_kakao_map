import KakaoMapsSDK


internal extension MapviewInfo {
    convenience init (
        payload: Dictionary<String, Any>
    ) {
        self.init(
            viewName:"mapView",
            appName: "openmap",
            viewInfoName: asString(payload["mapType"] ?? "openmap"),
            defaultPosition: MapPoint(payload: payload),
            defaultLevel: asInt(payload["zoomLevel"] ?? 15),
            enabled: asBool(payload["visible"] ?? true)
        )
    }
}
