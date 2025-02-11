enum KakaoMapEvent: UInt8 {
    case CameraMoveStart = 0b00000001
    case CameraMoveEnd = 0b00000010
    case CompassClick = 0b00000100
    case MapClick = 0b00001000
    case TerrainClick = 0b00010000
    case TerrainLongClick = 0b00100000
    case PoiClick = 0b1000000
    case LodPoiClick = 0b10000000

    func compare(value: UInt8) -> Bool {
        return self.rawValue & value == self.rawValue
    }
}