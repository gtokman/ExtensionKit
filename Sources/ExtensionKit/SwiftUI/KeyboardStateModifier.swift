import Combine
import SwiftUI

/// Get keyboard status updates
struct KeyboardStateModifier: ViewModifier {

    @Binding var keyboardInfo: Notification.KeyboardInfo

    init(_ keyboardInfo: Binding<Notification.KeyboardInfo>) {
        _keyboardInfo = keyboardInfo
    }

    func body(content: Content) -> some View {
        content
            .onReceive(
            AnyPublisher<Notification.KeyboardInfo, Never>.keyboardInfo,
            assignTo: $keyboardInfo
        )
    }
}
