import Combine
import SwiftUI

/// Get keyboard status updates
struct KeyboardStateModifier: ViewModifier {

    @Binding var keyboardInfo: KeyboardInfo

    init(_ keyboardInfo: Binding<KeyboardInfo>) {
        _keyboardInfo = keyboardInfo
    }

    func body(content: Content) -> some View {
        content
            .onReceive(
            AnyPublisher<KeyboardInfo, Never>.keyboardInfo,
            assignTo: $keyboardInfo
        )
    }
}
