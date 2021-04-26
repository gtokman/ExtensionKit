#if canImport(SwiftUI)

import SwiftUI

#endif

/// Get keyboard status updates
struct KeyboardStateModifier: ViewModifier {
    
  @Binding var isVisible: Bool
    
  init(_ isVisible: Binding<Bool>) {
    _isVisible = isVisible
  }
    
  private let keyboardWillAppear = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillShowNotification)
    .map { _ -> Bool in true }
    
  private let keyboardWillHide = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillHideNotification)
    .map { _ -> Bool in false }
    
  func body(content: Content) -> some View {
    content
      .onReceive(keyboardWillAppear.merge(with: keyboardWillHide)) {
        self.isVisible = $0
      }
  }
}
