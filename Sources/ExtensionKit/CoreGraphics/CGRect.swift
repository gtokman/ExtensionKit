import CoreGraphics

public extension CGRect {
    
    var topLeft: CGPoint {
        return origin
    }
    
    var topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }
    
    var topMiddle: CGPoint {
        return CGPoint(x: midX, y: minY)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }
    
    var bottomMiddle: CGPoint {
        return CGPoint(x: midX, y: maxY)
    }
    
    var leftMiddle: CGPoint {
        return CGPoint(x: minX, y: midY)
    }
    
    var rightMiddle: CGPoint {
        return CGPoint(x: maxX, y: midY)
    }
    
    /// Center taking size into account
    var center: CGPoint {
        get {
            let x = origin.x + size.width / 2
            let y = origin.y + size.height / 2
            return CGPoint(x: x, y: y)
        }
        set {
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
    }
    
    var sameCenterSquare: CGRect {
        let maxLength = max(size.width, size.height)
        var rect = CGRect(x: 0, y: 0, width: maxLength, height: maxLength)
        rect.center = center
        return rect
    }
}
