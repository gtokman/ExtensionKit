import UIKit

public extension CGAffineTransform {
    /// Basic transform that combines scaling and translation 
    ///
    static func transform(from frameA: CGRect, to frameB: CGRect) -> Self {
        let scale = scale(from: frameA, to: frameB)
        let translation = translate(from: frameA, to: frameB)
        return scale.concatenating(translation)
    }

    /// Calculates the translation needed to move from center of `frameA` to center of `frameB`
    ///
    static func translate(from frameA: CGRect, to frameB: CGRect) -> Self {
        let centerA = CGPoint(x: frameA.midX, y: frameA.midY)
        let centerB = CGPoint(x: frameB.midX, y: frameB.midY)
        return CGAffineTransform(
            translationX: centerB.x - centerA.x,
            y: centerB.y - centerA.y
        )
    }

    /// Calculates the scale factor needed to make `frameA` match `frameB`'s size
    ///
    static func scale(from frameA: CGRect, to frameB: CGRect) -> Self {
        let scaleX = frameB.width / frameA.width
        let scaleY = frameB.height / frameA.height
        return CGAffineTransform(scaleX: scaleX, y: scaleY)
    }

    /// A function that calculates the transformations required based on the three
    /// participating rects in a `SharedTransition`.
    ///
    /// - `parent`: The container view's frame
    /// - `child`: The view within the parent that we want to transform
    /// - `targetRect`: The target frame we want the child to match exactly
    ///
    /// For example, given the following two views that we want to transition between:
    ///
    /*
        +-------+    +-------------+
        |       |    |      B      |
        |   A   |    +-------------+
        |       |    |             |
        +-------+    |             |
                     |      C      |
                     |             |
                     |             |
                     +-------------+
                     |      B      |
                     +-------------+
    */
    ///
    /// The `parent` is B, the `child` is C (the rect we aim to overlap with another rect
    /// post-transformation), and the `rect` is A (the rect whose geometry we want the child to match
    /// with exactly).
    ///
    /// However, this function is not the one we shoud use, as the aspect ratio alters as A goes to C and back.
    /// This results in a distorted view since they are stretched and reshaped. The other
    /// `transform(parent:suchThatChild:aspectFills)` function is better suited for our needs.
    ///
    static func transform(parent: CGRect,
                          suchThatChild child: CGRect,
                          matches targetRect: CGRect) -> Self
    {
        // Calculate scale factors by comparing child rectangle's (C) dimensions
        // with the target rectangle (A)
        let scaleX = targetRect.width / child.width
        let scaleY = targetRect.height / child.height

        // Determine the origin of the animation by aligning the
        // centers of the rects.
        //
        // First, we match the center of the parent rect to the target rect.
        //
        // Second, we adjust the offset so that the child rect's center is aligned
        // with the target (calculated as the diff between the centers of the
        // parent and child rect in their scaled form).
        //
        // Without this, the view will always transition from the center of
        // the screen, instead of from where the transition should begin (i.e.
        // from a cell in a collection view).
        let offsetX = targetRect.midX - parent.midX
        let offsetY = targetRect.midY - parent.midY
        let centerOffsetX = (parent.midX - child.midX) * scaleX
        let centerOffsetY = (parent.midY - child.midY) * scaleY
        let translateX = offsetX + centerOffsetX
        let translateY = offsetY + centerOffsetY

        // Finally, create and combine the transformations into one
        // CGAffineTransform, ready to be applied to our views.
        let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let translateTransform = CGAffineTransform(translationX: translateX,
                                                   y: translateY)
        
        return scaleTransform.concatenating(translateTransform)
    }

    /// A similar transform function as the one above, but employing `aspectFill` to circumvent
    /// distortion of views during transition. With this, the child rect retains its aspect ratio while being transformed
    /// to fit perfectly within the target rect.
    ///
    /// However, this introduces another problem: parts of the child rect now extend beyond the bounds of the target rect
    /// and this is especially visible during the last few frames of the animation. We will need to apply a mask during the
    /// transition to hide this. Please see `CGRect+Extensions.swift` for the relevant utility functions.
    ///
    static func transform(parent: CGRect,
                          suchThatChild child: CGRect,
                          aspectFills targetRect: CGRect) -> Self
    {
        // Calculate aspect ratio of both child and target rect frames
        let childRatio = child.width / child.height
        let rectRatio = targetRect.width / targetRect.height

        let scaleX = targetRect.width / child.width
        let scaleY = targetRect.height / child.height

        // Determine the scaling dimension based on a comparison of the two ratios,
        // ensuring we maintain the original aspect while fitting the rectangle.
        let scaleFactor = rectRatio < childRatio ? scaleY : scaleX

        let offsetX = targetRect.midX - parent.midX
        let offsetY = targetRect.midY - parent.midY
        let centerOffsetX = (parent.midX - child.midX) * scaleFactor
        let centerOffsetY = (parent.midY - child.midY) * scaleFactor

        let translateX = offsetX + centerOffsetX
        let translateY = offsetY + centerOffsetY

        let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        let translateTransform = CGAffineTransform(translationX: translateX,
                                                   y: translateY)

        return scaleTransform.concatenating(translateTransform)
    }
    
    /// Transform a frame into another frame. Assumes they're the same aspect ratio.
    static func transform(originalFrame: CGRect,
                          toTargetFrame targetFrame: CGRect) -> Self
    {
        // Width or height doesn't matter if they're the same aspect ratio
        let scaleFactor = targetFrame.width / originalFrame.width
        
        let offsetX = targetFrame.midX - originalFrame.midX
        let offsetY = targetFrame.midY - originalFrame.midY
        
        let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        let translateTransform = CGAffineTransform(translationX: offsetX,
                                                   y: offsetY)
        
        return scaleTransform.concatenating(translateTransform)
    }
}
