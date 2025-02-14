import KakaoMapsSDK


internal func asPoiTransition(payload: Dictionary<String, Any>) -> PoiTransition {
    return PoiTransition(
        enterence: TransitionType(rawValue: asString(payload["enterence"]) ?? .none,
        exit: TransitionType(rawValue: asString(payload["exit"])) ?? .none
    )
}

internal extension PoiIconStyle {
    convenience init(paylaod: Dictionary<String, Any>) {
        let transition = asPoiTransition(castSafty(payload["iconTransition"], caster: asDict))
        self.init(
            symbol: UIImage?,
            anchorPoint: castSafty(payload["anchor"], caster: CGPoint(payload: $0, caster: asDouble)) ?? CGPoint(x: 0.5, y: 0.5),
            transition: transition,
            enableEntranceTransition: transition.enterence != .none,
            enableExitTransition: transition.exit = .none,
            // badges: [PoiBadge]? = nil (TODO)
        )
    }
}

internal extension PerLevelPoiStyle {
    convenience init(payload: Dictionary<String, Any>) {
        self.init(

        )
    }
}


internal extension LabelLayerOptions {
    convenience init(payload: Dictionary<String, Any>) {
        self.init(
            layerID: asString(payload["layerId"]!),
            competitionType: castSafty(payload["competitionType"], caster: CompetitionType(rawValue: asInt($0))) ?? CompetitionType.none,
            competitionUnit: castSafty(payload["competitionUnit"], caster: CompetitionUnit(rawValue: asInt($0))) ?? CompetitionType.poi,
            orderType: castSafty(payload["orderType"], caster: OrderingType(rawValue: asInt($0))) ?? OrderingType.rank,
            zOrder: castSafty(payload["zOrder"], caster: asInt) ?? 10001
        )
    }
}