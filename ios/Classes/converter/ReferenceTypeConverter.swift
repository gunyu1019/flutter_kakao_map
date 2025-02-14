

internal extension UIColor {
     convenience init(value: UInt) {
        self.init(red: CGFloat((value & 0x00FF0000) >> 16) / 255.0,
                  green: CGFloat((value & 0x0000FF00) >> 8) / 255.0,
                  blue: CGFloat(value & 0x000000FF) / 255.0,
                  alpha: CGFloat(value & 0xFF000000) / 1.0)
    }
}