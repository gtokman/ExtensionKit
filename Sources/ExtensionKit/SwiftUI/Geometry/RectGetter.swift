import SwiftUI

/// Get the views frame in the global coordinate space
struct RectGetter: View {
    
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }

    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.mainSafeAsync {
            self.rect = proxy.globalFrame
        }

        return Rectangle().fill(Color.clear)
    }
}
