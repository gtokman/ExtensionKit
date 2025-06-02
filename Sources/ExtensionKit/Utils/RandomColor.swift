import UIKit

public func getRandomColor() -> UIColor {
    let hue = CGFloat(arc4random() % 256) / 256.0
    let saturation: CGFloat = 0.3 + CGFloat(arc4random() % 128) / 256.0
    let brightness: CGFloat = 0.7 + CGFloat(arc4random() % 128) / 256.0
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
}
