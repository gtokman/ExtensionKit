import UIKit

public extension UICollectionView {
    /// Enum representing a cell's position based on whether it's
    /// beyond the top or bottom of the view, or entirely visible
    /// 
    enum VerticalCellPosition {
        case overTop
        case visible
        case overBottom
    }
    
    /// The visible area of the `UICollectionView`
    ///
    var visibleRect: CGRect {
        CGRect(origin: contentOffset, size: bounds.size)
    }

    /// The maximum offset of the `UICollectionView`, i.e. the bottom and trailing edge
    ///
    var maxOffset: CGPoint {
        CGPoint(
            x: contentSize.width - bounds.size.width + safeAreaInsets.right + contentInset.right,
            y: contentSize.height - bounds.size.height + safeAreaInsets.bottom + contentInset.bottom
        )
    }

    /// The minimum offset of the `UICollectionView`, i.e. the top and leading edge
    ///
    var minOffset: CGPoint {
        CGPoint(
            x: -safeAreaInsets.left - contentInset.left,
            y: -safeAreaInsets.top - contentInset.top
        )
    }

    /// Retrieves the `VerticalCellPosition` of a cell in a `UICollectionView` based on its position
    ///
    private func verticalCellPosition(for indexPath: IndexPath) -> VerticalCellPosition? {
        guard let attributes = layoutAttributesForItem(at: indexPath) else { return nil }
        if attributes.frame.minY < visibleRect.minY {
            return .overTop
        } else if attributes.frame.maxY > visibleRect.maxY {
            return .overBottom
        } else {
            return .visible
        }
    }
    
    /// Scrolls to a specified item in a `UICollectionView` such that it becomes entirely visible,
    /// along with some additional padding specified per collection view
    ///
    func verticalScrollItemVisible(at indexPath: IndexPath,
                                   withPadding padding: CGFloat,
                                   animated: Bool)
    {
        switch verticalCellPosition(for: indexPath) {
        case .overTop:
            verticalScrollToItem(at: indexPath, forCellPosition: .overTop, padding: padding, animated: animated)
            
        case .overBottom:
            verticalScrollToItem(at: indexPath, forCellPosition: .overBottom, padding: padding, animated: animated)
            
        default:
            return
        }
    }

    /// Helper function used in `verticalScrollItemVisible` that scrolls to a specified item
    /// in a `UICollectionView` depending on its `cellPosition`
    ///
    func verticalScrollToItem(at indexPath: IndexPath,
                              forCellPosition cellPosition: VerticalCellPosition,
                              padding: CGFloat,
                              animated: Bool)
    {
        guard let attributes = layoutAttributesForItem(at: indexPath) else { return }
        
        switch cellPosition {
        case .overTop:
            var offset = attributes.frame.origin.y - padding
            offset = min(max(offset, minOffset.y), maxOffset.y)
            setContentOffset(.init(x: 0, y: offset), animated: animated)
            
        case .overBottom:
            var offset = attributes.frame.origin.y - bounds.height + attributes.frame.height + padding
            offset = min(max(offset, minOffset.y), maxOffset.y)
            setContentOffset(.init(x: 0, y: offset), animated: animated)
        
        default:
            break
        }
    }
}
