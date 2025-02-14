import KakaoMapsSDK


internal extension TextStyle {
    convenience init(payload: Dictionary<String, Any>) {
        self.init(
            fontSize: asInt(rawPayload["size"]!),
            fontColor: UIColor(asInt(rawPayload["color"]!!)),
            strokeThickness: castSafty(payload["strokeSize"], caster: asInt) ?? 0,
            strokeColor: castSafty(payload["strokeColor"], caster: UIColor(asInt($0))) ?? UIColor.white,
            font: castSafty(payload["font"], caster: asString) ?? "",
            charSpace: castSafty(payload["characterSpace"], caster: asInt) ?? 0,
            lineSpace: castSafty(payload["lineSpace"], caster: asDouble) ?? 1.0,
            aspectRatio: castSafty(payload["aspectRatio"], caster: asDouble) ?? 1.0
        )
    }
}


internal extension LabelLayerOptions {
    convenience init(payload: Dictionary<String, Any>) {
        self.init(
            layerID: asString(payload["layerId"]!),
            competitionType: castSafty(payload["competitionType"], caster: CompetitionType(rawValue: asInt($0))) ?? CompetitionType.CompetitionTypeNone,
            competitionUnit: castSafty(payload["competitionUnit"], caster: CompetitionUnit(rawValue: asInt($0))) ?? CompetitionType.CompetitionUnitPoi,
            orderType: castSafty(payload["orderType"], caster: OrderingType(rawValue: asInt($0))) ?? OrderingType.OrderingTypeRank,
            zOrder: castSafty(payload["zOrder"], caster: asInt) ?? 10001
        )
    }
}