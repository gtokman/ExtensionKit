#if canImport(UIKit)

import UIKit

#endif

public extension UIImage {
    
    func getPixelColor(pos: CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: a)
    }
    
    /// Create QR code from string
    /// - Parameter string: String for QR code
    convenience init?(qrCodeFrom string: String) {
        if let data = string.data(using: .ascii), let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            if let output = filter.outputImage?.transformed(by: transform) {
                self.init(ciImage: output)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    /// Draw a star
    /// - Parameters:
    ///   - size: Size
    ///   - strokeColor: Stroke color
    ///   - lineWidth: Line width
    ///   - fillColor: Fill color
    /// - Returns: Drawn star as UIImage
    static func withStarShape(size: CGSize, strokeColor: UIColor = .clear, lineWidth: CGFloat = 2.0, fillColor: UIColor?) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        
        let starPath = UIBezierPath()
        
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let numberOfPoints = CGFloat(5.0)
        let numberOfLineSegments = Int(numberOfPoints * 2.0)
        let theta = .pi / numberOfPoints
        
        let circumscribedRadius = center.x
        let outerRadius = circumscribedRadius * 1.039
        let excessRadius = outerRadius - circumscribedRadius
        let innerRadius = CGFloat(outerRadius * 0.382)
        
        let leftEdgePointX = (center.x + cos(4.0 * theta) * outerRadius) + excessRadius
        let horizontalOffset = leftEdgePointX / 2.0
        
        // Apply a slight horizontal offset so the star appears to be more
        // centered visually
        let offsetCenter = CGPoint(x: center.x - horizontalOffset, y: center.y)
        
        // Alternate between the outer and inner radii while moving evenly along the
        // circumference of the circle, connecting each point with a line segment
        for i in 0..<numberOfLineSegments {
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            
            let pointX = offsetCenter.x + cos(CGFloat(i) * theta) * radius
            let pointY = offsetCenter.y + sin(CGFloat(i) * theta) * radius
            let point = CGPoint(x: pointX, y: pointY)
            
            if i == 0 {
                starPath.move(to: point)
            } else {
                starPath.addLine(to: point)
            }
        }
        
        starPath.close()
        
        // Rotate the path so the star points up as expected
        var pathTransform  = CGAffineTransform.identity
        pathTransform = pathTransform.translatedBy(x: center.x, y: center.y)
        pathTransform = pathTransform.rotated(by: CGFloat(-.pi / 2.0))
        pathTransform = pathTransform.translatedBy(x: -center.x, y: -center.y)
        
        starPath.apply(pathTransform)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.addPath(starPath.cgPath)
            context.setLineWidth(lineWidth)
            context.setStrokeColor(strokeColor.cgColor)
            if let fillColor = fillColor {
                context.setFillColor(fillColor.cgColor)
            }
            context.drawPath(using: CGPathDrawingMode.fillStroke)
            
        } else {
            print("Error: UIGraphicsGetCurrentContext() returns nil when drawing star shape!")
        }
        
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
    }
    
    
    /// Returns an identical image with specified tint color. Note that the returned image is with rendering mode `.alwaysOriginal`
    ///
    /// - Reference
    ///
    ///   https://stackoverflow.com/questions/31803157/how-can-i-color-a-uiimage-in-swift
    ///
    /// - Parameter color: The tint color
    /// - Returns: An identical image with specified tint color
    func withTintColor(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let maskImage = cgImage, let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        context.setBlendMode(.colorBurn)
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
    }
    
    /// Is square aspect ratio
    var isSquare: Bool {
        return size.height == size.width
    }
    
    /// Size in KB or MB
    var sizeOnDisk: String {
        var length = Double(self.jpegData(compressionQuality: 1.0)!.count) / 1024 / 1024
        if length < 1.0 {
            length *= 1024
            return "\(length)KB"
        } else {
            return "\(length)MB"
        }
    }
    
    
    /// Height for screen width
    var heightForScreenWidth: CGFloat {
        return aspectHeight(for: UIScreen.main.bounds.width)
    }
    
    /// Scale the height of the given width proportionally
    ///
    /// - parameter width: width
    ///
    /// - returns: New height
    func aspectHeight(for width: CGFloat) -> CGFloat {
        return width / size.width * size.height
    }
    
    
    /// Scale the width of the given height proportionally
    ///
    /// - parameter height: Height
    ///
    /// - returns: New width
    func aspectWidth(for height: CGFloat) -> CGFloat {
        return height / size.height * size.width
    }
    
    
    /// Keep the aspect ratio and return the fitting size of the given size
    ///
    /// - Parameter binding: Size
    /// - Returns: New size
    func aspectFitSize(forBindingSize binding: CGSize) -> CGSize {
        let rw = size.width / binding.width
        let rh = size.height / binding.height
        if rw < rh {
            return CGSize(width: size.width / rh, height: binding.height)
        } else {
            return CGSize(width: binding.height, height: size.height / rw)
        }
    }
    
    /// Get an single-colored image
    ///
    /// - Parameters:
    ///   - color: The color
    ///   - rect: The rect to draw in a CGContext.
    /// - Returns: An single-colored image object, nil if any problems occur, such as CGRect.zero got passed.
    class func image(withPureColor color: UIColor, for rect: CGRect, rounded: Bool) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        if rounded {
            context?.fillEllipse(in: rect)
        } else {
            context?.fill(rect)
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    /// Correct the direction of the picture so that it positioned correctly
    ///
    /// - Returns: Image
    var orientationFixed: UIImage {
        
        if imageOrientation == .up {
            return self
        }
        
        guard let cgImage = cgImage else {
            return self
        }
        
        let width = size.width
        let height = size.height
        var transform: CGAffineTransform = .identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: width, y: height)
            transform = transform.rotated(by: .pi)
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: height)
            transform = transform.rotated(by: -(.pi / 2))
            
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        default:
            break
        }
        
        guard let space = cgImage.colorSpace else { return self }
        let ctx = CGContext(
            data: nil,
            width: Int(width),
            height: Int(height),
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: 0,
            space: space,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: height, height: width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        guard let cgimg = ctx.makeImage() else {
            return self
        }
        return UIImage(cgImage: cgimg)
    }
    
    
    /// Get certain part of image
    ///
    /// - Parameter rect: Part of the image
    /// - Returns: Image
    func subImage(in rect: CGRect) -> UIImage? {
        if let cgimage = cgImage, let image = cgimage.cropping(to: rect) {
            return UIImage(cgImage: image, scale: 1.0, orientation: .up)
        }
        return nil
    }
    
    
    /// Redraw the image to the specified size
    ///
    /// - Parameter size: Size
    /// - Returns: Image
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizedImageWithAspectFitSize(forBindingSize binding: CGSize) -> UIImage? {
        return resized(to: aspectFitSize(forBindingSize: binding))
    }
    
    
    /// Resize the image so that its width and height are equal.
    ///
    /// - Returns: A newly created image.
    func square() -> UIImage? {
        let edgeLength = max(size.width, size.height)
        let contextSize = CGSize(width: edgeLength, height: edgeLength)
        
        UIGraphicsBeginImageContextWithOptions(contextSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        let origin = CGPoint(x: (contextSize.width - size.width) / 2, y: (contextSize.height - size.height) / 2)
        draw(in: CGRect(origin: origin, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Redraw a new image with the given requirements.
    ///
    /// - Parameters:
    ///   - backgroundColor: The background color of the image.
    ///   - cornerRadius: The corner radius of the image, pass 0.0 if you perfer a squared one.
    ///   - insets: The inset to apply to the image.
    /// - Returns: A newly created image.
    func with(backgroundColor: UIColor, cornerRadius: CGFloat, insets: UIEdgeInsets) -> UIImage? {
        let contextSize = CGSize(width: size.width + insets.left + insets.right,
                                 height: size.height + insets.top + insets.bottom)
        UIGraphicsBeginImageContextWithOptions(contextSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        let contextRect = CGRect(origin: .zero, size: contextSize)
        let backgroundPath = UIBezierPath(roundedRect: contextRect, cornerRadius: cornerRadius)
        context?.addPath(backgroundPath.cgPath)
        context?.setFillColor(backgroundColor.cgColor)
        context?.fillPath()
        draw(in: CGRect(origin: CGPoint(x: insets.left, y: insets.top), size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    enum ArrowDirection {
        case up, down, left, right
    }
    
    static func arrowHead(direction: ArrowDirection, color: UIColor, size: CGSize, lineWidth: CGFloat = 2.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        
        switch direction {
        case .up:
            context?.move(to: rect.bottomLeft)
            context?.addLine(to: rect.topMiddle)
            context?.addLine(to: rect.bottomRight)
            
        case .down:
            context?.move(to: rect.topLeft)
            context?.addLine(to: rect.bottomMiddle)
            context?.addLine(to: rect.topRight)
            
        case .left:
            context?.move(to: rect.topRight)
            context?.addLine(to: rect.leftMiddle)
            context?.addLine(to: rect.bottomRight)
            
        case .right:
            context?.move(to: rect.topLeft)
            context?.addLine(to: rect.rightMiddle)
            context?.addLine(to: rect.bottomLeft)
        }
        
        context?.setLineCap(.round)
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(color.cgColor)
        context?.strokePath()
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    /// Draw a image with a border
    /// - Parameters:
    ///   - size: size
    ///   - backgroundColor: color
    ///   - borderColor: border color
    ///   - borderWidth: border width
    ///   - cornerRadius: radius
    /// - Returns: New image
    class func borderImage(size: CGSize, backgroundColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(borderColor.cgColor)
        context?.setLineWidth(borderWidth)
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size).insetBy(dx: borderWidth / 2, dy: borderWidth / 2), cornerRadius: cornerRadius)
        context?.addPath(path.cgPath)
        context?.strokePath()
        context?.setFillColor(backgroundColor.cgColor)
        context?.fillPath()
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    /// Draw background image
    /// - Parameters:
    ///   - backgroundColor: color
    ///   - borderColor: border color
    ///   - borderWidth: width
    ///   - cornerRadius: radius
    /// - Returns: New image
    class func buttonBackgroundBorderImage(backgroundColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIImage? {
        let inset = borderWidth + cornerRadius + 2
        let width = inset * 2 + 1
        return borderImage(size: CGSize(width: width, height: width), backgroundColor: backgroundColor, borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius)?.resizableImage(withCapInsets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset), resizingMode: .stretch)
    }
    
}
