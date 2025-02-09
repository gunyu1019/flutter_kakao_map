import KakaoMapsSDK


internal extension MapviewInfo {
    convenience init (
        payload: Dictionary<String, Any>,
        viewId: Int64
    ) {
        self.init(
            viewName: castSafty(payload["viewName"], caster: asString) ?? "map_view_\(viewId)",
            appName: "openmap",
            viewInfoName: asString(payload["mapType"] ?? "openmap"),
            defaultPosition: MapPoint(payload: payload),
            defaultLevel: asInt(payload["zoomLevel"] ?? 15),
            enabled: asBool(payload["visible"] ?? true)
        )
    }
}
