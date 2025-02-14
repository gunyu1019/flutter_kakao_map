import KakaoMapsSDK


internal extension UIColor {
     convenience init(value: UInt) {
        self.init(red: CGFloat((value & 0x00FF0000) >> 16) / 255.0,
                  green: CGFloat((value & 0x0000FF00) >> 8) / 255.0,
                  blue: CGFloat(value & 0x000000FF) / 255.0,
                  alpha: CGFloat(value & 0xFF000000) / 1.0)
    }
}


internal extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero, 
                size: scaledImageSize
            ))
        }
        return scaledImage
    }
}


internal func asImage(payload: Dictionary<String, Any>) -> UIImage? {
    let width = asInt(payload["width"])
    let height = asInt(payload["height"])
    let size = CGSize(width: width, height: height)
    let imageType = asInt(payload["type"])
    switch imageType {
    case 0:
        let rawPath = asString(payload["path"])
        let path = FlutterKakaoMapsPlugin.getAssets(path: rawPath)
        return UIImage(contentsOfFile: path).targetSize(targetSize: size)
    case 2:
        let data = payload["data"] as! FlutterStandardTypedData
        return UIImage(data: data.data).targetSize(targetSize: size)
    default:  // type 1
        let path = asString(payload["path"])
        return UIImage(contentsOfFile: path).targetSize(targetSize: size)
    }
}


internal extension CGPoint {
    convenience init(payload: Dictionary<String, Double>) {
        self.init(x: payload["x"]!, y: paylaod["y"]!)
    }

    convenience init(payload: Dictionary<String, Int>) {
        self.init(x: payload["x"]!, y: paylaod["y"]!)
    }

    convenience init<T>(payload: Dictionary<String, Any>, caster: (Any) throws -> T) {
        let rawPayload = asDictTyped(payload, caster: caster)
        self.init(x: rawPayload["x"]!, y: rawPayload["y"]!)
    }
}


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