import SwiftUI

/// Bottom sheet modal height
public enum Height: Equatable {
    
    /// Third of Screen size
    case low
    /// Half of Screen size
    case mid
    /// Full Screen size
    case full
    /// Custom screen size
    case custom(CGFloat)

    var value: CGFloat {
        switch self {
        case .low: return Screen.height * 0.33
        case .mid: return Screen.height * 0.55
        case .full: return Screen.height * 0.95
        case let .custom(custom): return custom
        }
    }
}

/// Buttom sheet view with animatable offset, background opacity, modal corner radius
struct BottomSheet<Content: View>: View {

    private var cornerRadiusUpperbound: CGFloat = 10
    private let backgroundOpacityUpperbound: CGFloat = 0.5
    private let dragIndicatorVerticalPadding: CGFloat = 15
    
    private var modalHeight = Height.mid
    private let animation: Animation
    private let indicatorHidden: Bool
    
    @State private var modalCornerRadius: CGFloat = 10
    @State private var backgroundOpacity: Double = 0.5
    @State private var offset = CGSize.zero

    @Binding var isPresented: Bool

    let content: () -> Content

    init(
        isPresented: Binding<Bool>,
        height: Height = .mid,
        animation: Animation = .easeInOut(duration: 0.3),
        thumbHidden: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.modalHeight = height
        self.animation = animation
        self.content = content
        self.indicatorHidden = thumbHidden
    }
    
    // MARK: - Computed vars
    
    private var yRange: ClosedRange<CGFloat> {
        return 0...modalHeight.value
    }
    
    var newOpacity: Double {
        let y = offset.height
        let lower = yRange.lowerBound
        let upper = yRange.upperBound
        let newOpacity = (y - lower) / ((upper - lower) / backgroundOpacityUpperbound)
        return Double(backgroundOpacityUpperbound - newOpacity)
    }
    
    var newCornerRadius: CGFloat {
        let y = offset.height
        let lower = yRange.lowerBound
        let upper = yRange.upperBound
        let newCorner = (y - lower) / ((upper - lower) / cornerRadiusUpperbound)
        return cornerRadiusUpperbound - newCorner
    }
    
    // MARK - Views

    var body: some View {
        ZStack(alignment: .bottom) {
            if isPresented {
                background
                modal
            }
        }
        .edgesIgnoringSafeArea(.all)
    }

    private var background: some View {
        Color.black
            .fillParent()
            .opacity(backgroundOpacity)
            .animation(animation)
            .onTapGesture { isPresented.toggle() }
    }
    
    private var modal: some View {
        VStack {
            indicator
            self.content()
        }
        .frame(
            width: Screen.width,
            height: modalHeight.value,
            alignment: .top)
            .background(Color.white)
            .cornerRadius(modalCornerRadius)
            .offset(y: offset.height)
            .gesture(
            DragGesture()
                .onChanged(onChangedDragValueGesture)
                .onEnded(onEndedDragValueGesture)
            )
            .animation(animation)
            .transition(.move(edge: .bottom))
    }

    private var indicator: some View {
        Rectangle()
            .fill(Color(.systemGray4))
            .frame(width: 50, height: 6)
            .cornerRadius(3)
            .padding(.vertical, dragIndicatorVerticalPadding)
            .hide(if: indicatorHidden)
    }
    
    // MARK: - Helpers

    private func onChangedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height > 0 else { return }
        self.offset = value.translation
        backgroundOpacity = newOpacity
        modalCornerRadius = newCornerRadius
    }
    
    private func onEndedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height >= self.modalHeight.value / 2 else {
            self.offset = .zero
            self.backgroundOpacity = Double(backgroundOpacityUpperbound)
            self.modalCornerRadius = cornerRadiusUpperbound
            return
        }

        withAnimation(animation) {
            self.isPresented.toggle()
            self.offset = .zero
            self.backgroundOpacity = Double(backgroundOpacityUpperbound)
            self.modalCornerRadius = cornerRadiusUpperbound
        }
    }
}
