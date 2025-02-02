import KakaoMapsSDK


class KakaoMapOption: MapviewInfo {
    init (
        viewName: String,
        appName: String = "openmap",
        viewInfoName: String = "map",
        defaultPosition: MapPoint?,
        defaultLevel: Int = 17,
        enabled: Bool = true
    ) { 
        super.init(
            viewName: viewName, 
            appName: appName, 
            viewInfoName: viewInfoName, 
            defaultPosition: defaultPosition, 
            defaultLevel: defaultLevel, 
            enabled: enabled
        )
    }

    init (
        paylaod: Dictionary<String, Any>
    ) {
        super.init(
            viewName: paylaod["viewName"], 
            appName: "openmap", 
            viewInfoName: paylaod["mapType"], 
            defaultPosition: payload["position"], // need MapPoints struction
            defaultLevel: payload["zoomLevel"], 
            enabled: payload["visible"]
        )
    }
}