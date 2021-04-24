#if canImport(UIKit)

import UIKit

#endif

public extension UITableView {
    
    /// Zero rows in all sections
    var isEmpty: Bool {
        return numberOfSections.range.reduce(0, {
            $0 + numberOfRows(inSection: $1)
        }) == 0
    }

    /// Reload cell  at index path
    /// - Parameters:
    ///   - cell: cell
    ///   - animation: animation
    func reloadCell(_ cell: UITableViewCell, with animation: UITableView.RowAnimation) {
        if let indexPath = indexPath(for: cell) {
            reloadRows(at: [indexPath], with: animation)
        }
    }
    
    /// Scroll to last index in last section
    /// - Parameters:
    ///   - position: position
    ///   - animated: animated
    func scrollToBottom(position: UITableView.ScrollPosition = .bottom, animated: Bool = true) {
        if let lastSection = (0 ..< numberOfSections).reversed().first(where: { numberOfRows(inSection: $0) > 0 }) {
            let lastRow = numberOfRows(inSection: lastSection) - 1
            let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
            scrollToRow(at: lastIndexPath, at: position, animated: animated)
        }
    }
    
}
