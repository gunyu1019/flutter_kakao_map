import KakaoMapsSDK


internal func asPoiTransition(payload: Dictionary<String, Any>) -> PoiTransition {
    return PoiTransition(
        enterence: TransitionType(rawValue: asString(payload["enterence"]) ?? .none,
        exit: TransitionType(rawValue: asString(payload["exit"])) ?? .none
    )
}

internal extension PoiIconStyle {
    convenience init(payload: Dictionary<String, Any>) {
        let transition = asPoiTransition(castSafty(payload["iconTransition"], caster: asDict))
        self.init(
            symbol: castSafty(payload["icon"], caster: asImage),
            anchorPoint: castSafty(payload["anchor"], caster: CGPoint(payload: $0, caster: asDouble)) ?? CGPoint(x: 0.5, y: 0.5),
            transition: transition,
            enableEntranceTransition: transition.enterence != .none,
            enableExitTransition: transition.exit = .none,
            // badges: [PoiBadge]? = nil (TODO)
        )
    }
}

internal extension PoiTextStyle {
    convenience init(payload: Dictionary<String, Any>) {
        let transition = asPoiTransition(castSafty(payload["textTransition"], caster: asDict))
        let textStyle = castSafty(payload["textStyle"], caster: asArray($0, caster: TextStyle(payload: $0))) ?? []
        self.init(
            transition: transition,
            enableEntranceTransition: transition.enterence != .none,
            enableExitTransition: transition.exit = .none,
            textLineStyles: textStyle
        )

        if (payload["textGravity"] != nil) {
            let gravity = asInt(payload["textGravity"])
            switch gravity {
            case 1:
                self.textLayouts = [PoiTextLayout.left]
            case 2:
                self.textLayouts = [PoiTextLayout.right]
            case 4:
                self.textLayouts = [PoiTextLayout.top]
            case 8:
                self.textLayouts = [PoiTextLayout.bottom]
            case 16:
                self.textLayouts = [PoiTextLayout.center]
            default:
                continue
            }
        }
    }
}

internal extension PerLevelPoiStyle {
    convenience init(payload: Dictionary<String, Any>) {
        self.init(
            iconStyle: PoiIconStyle(payload: payload),
            textStyle: PoiTextStyle(payload: payload),
            padding: castSafty(payload["paddding"], asFloat) ?? 0.0,
            level: castSafty(payload["zoomLevel"], asInt) ?? 0
        )
    }
}


internal extension PoiStyle {
    convenience init(payload: Dictionary<String, Any>) {
        let styleId = payload["styleId"] ?? UUID().uuidString 
        var styles = Array<PerLevelPoiStyle>()
        styles.append(PerLevelPoiStyle(payload: payload))
        styles.append(
            constentsOf: asArray(payload["otherStyle"], caster: PerLevelPoiStyle(payload: $0))
        )
        self.init(
            styleID: styleId,
            styles: styles
        )
    }
}


internal extension PoiOptions {
    convenience init(payload: Dictionary<String, Any>) {
        self.init(styleID: asString(rawPayload["styleId"]))
        if let rank = rawPayload["rank"] {
            self.rank = asInt(rank)
        }
        if let clickable = rawPayload["clickable"] {
            self.clickable = asInt(clickable)
        }
        if let transformMethod = rawPayload["transformMethod"] {
            self.transformMethod = PoiTransformType(rawValue: asInt(transformMethod))
        }
        if let text = rawPayload["text"] {
            text.split(separator: "\n").enumerate().map { 
                (index, element) in PoiText(text: element, styleIndex: index) 
            }.map(self.addText)
        }
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