import SwiftUI
import Combine

@available(iOS 13.0, macOS 10.15, *)
public extension View {
    
    /// Self wrapped in an `UIHostingController`
    var hosted: UIHostingController<Self> {
        return UIHostingController(rootView: self)
    }
    
    /// Fill frame height and width to the same length
    /// - Parameters:
    ///   - length: Length to set
    ///   - alignment: Aligment
    /// - Returns: View
    func fillEqual(length: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(width: length, height: length, alignment: alignment)
    }

    /// Fill parent view
    /// - Parameter alignment: alignment
    /// - Returns: View with filled frame
    func fillParent(alignment: Alignment = .center) -> some View {
        self
            .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: alignment
        )
    }
    
    /// Fill parent's width
    /// - Returns: view
    func fillWidth() -> some View {
        return self.frame(minWidth: 0, maxWidth: .infinity)
    }

    /// Fill parent's height
    /// - Returns: view
    func fillHeight() -> some View {
        return self.frame(minHeight: 0, maxHeight: .infinity)
    }
    
    /// Similar to distribuation fill on `UIStackView`, take up all availabe space of parent
    /// - Parameters:
    ///   - flexibleAxis: Axis to fill
    ///   - alignment: Alignment
    /// - Returns: View
    func fillFlexible(
        _ flexibleAxis: Axis.Set = [.horizontal, .vertical],
        alignment: Alignment = .center
    ) -> some View {
      return frame(
        maxWidth: flexibleAxis.contains(.horizontal) ? .infinity : nil,
        maxHeight: flexibleAxis.contains(.vertical) ? .infinity : nil,
        alignment: alignment)
    }

    /// If a condition is true, transform and return a new view
    /// - Parameters:
    ///   - condition: condition
    ///   - transform: transformation if true
    /// - Returns: new view
    @ViewBuilder
    func `if`<TrueContent: View>(_ condition: Bool, transform: (Self) -> TrueContent) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// If a condition is true, transform and return a new view
    /// - Parameters:
    ///   - condition: condition
    ///   - ifTransform: true case transform
    ///   - elseTransform: else case transform
    /// - Returns: new view
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
      _ condition: Bool,
      if ifTransform: (Self) -> TrueContent,
      else elseTransform: (Self) -> FalseContent
    ) -> some View {
      if condition {
        ifTransform(self)
      } else {
        elseTransform(self)
      }
    }
    
    /// Conditionally apply a modifier to the view based on if the optional exists
    /// - Parameters:
    ///   - value: Optional value
    ///   - modifier: Modifier to run on value if it exists
    /// - Returns: Modified self if optional has a value
    @ViewBuilder
    func `ifLet`<Content: View, Value>(
        _ value: Value?,
        _ modifier: (Self, Value) -> Content) -> some View {
        if let value = value {
            modifier(self, value)
        } else {
            self
        }
    }
    
    /// Embed Self in `NavigationView`
    /// - Returns: New view with `NavigationView` parent
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
    
    /// Embed Self in `ScrollView`
    /// - Returns: New view with `ScrollView` parent
    func embedInScrollView(_ axis: Axis.Set = .vertical,
                           showsIndicators: Bool = false) -> some View {
        ScrollView(axis, showsIndicators: showsIndicators) { self }
    }
    
    /// Embed Self in `TabView`
    /// - Parameters:
    ///   - selection: selection binding
    ///   - paged: page style or not (`PageTabViewStyle`)
    ///   - pageIndicators: show page indicators, default .always
    /// - Returns: View
    @available(iOS 14.0, *)
    func embedInTabView<Selection: Hashable>(
        _ selection: Binding<Selection>,
        paged: Bool = true,
        pageIndicators: PageTabViewStyle.IndexDisplayMode = .always
    ) -> some View {
        TabView(selection: selection) { self }
            .if(paged) { (tabView) in
                return tabView
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: pageIndicators))
            }
    }
    
    /**
    ```
     ForEach(0 ..< 5) { item in
         Rectangle()
             .foregroundColor(.random())
     }.embedInVerticalPagingTabView($selection)
    ```
     */
    /// Embed Self in vertically paging `TabView`
    /// - Parameters:
    ///   - selection: selection binding
    ///   - pageIndicators: show page indicators, default .always
    /// - Returns: View
    @available(iOS 14.0, *)
    func embedInVerticalPagingTabView<Selection: Hashable>(
        _ selection: Binding<Selection>,
        pageIndicators: PageTabViewStyle.IndexDisplayMode = .never
    ) -> some View {
        GeometryReader { proxy in
            TabView(selection: selection) {
                self
                    .rotationEffect(.degrees(-90)) // Rotate content
                    .frame(
                        width: proxy.localWidth,
                        height: proxy.localHeight
                    )
            }
            .frame(
                width: proxy.localHeight,
                height: proxy.localWidth
            )
            .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
            .offset(x: proxy.localWidth) // Offset back into screens bounds
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: pageIndicators)
            )
        }
    }
    
    /// Round view with specific corners
    /// - Parameters:
    ///   - radius: radius
    ///   - corners: corners to round
    /// - Returns: new rounded view
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    /// Erase view to `AnyView`
    /// - Returns: new view
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    /// Hides the view conditionally
    /// - Parameter hidden: is hidden
    /// - Returns: hidden view but not drawn on screen
    @ViewBuilder
    func hide(if hidden: Bool) -> some View {
        switch hidden {
        case true: self.hidden()
        case false: self
        }
    }
    
    /// Loading shimmer animation on view
    /// - Parameters:
    ///   - isActive: is shimmer animation active
    ///   - speed: speed, default: 0.15
    ///   - angle: angle of animation, default: 70º
    /// - Returns: View
    func shimmer(
        isActive: Bool = true,
        speed: Double = 0.15,
        angle: Angle = .init(degrees: 70)
    ) -> some View {
        
        let view = ShimmerModifier(
            isActive: isActive,
            speed: speed,
            angle: angle
        )
        
        return self.modifier(view)
    }
    
    /// Add animating circles to view
    /// - Parameters:
    ///   - isActive: is animation active
    ///   - circleColor: circle foreground color
    /// - Returns: View
    func circleMotion(
        isActive: Bool = true,
        circleColor: Color = .gray
    ) -> some View {
        
        let view = CircleMotionModifier(
            isActive: isActive,
            circleColor: circleColor)

        return self.modifier(view)
    }
    
    /// Overlay border on view
    /// - Parameters:
    ///   - content: ShapeStyle view
    ///   - width: border width
    ///   - cornerRadius: corner radius
    /// - Returns: view
   func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S: ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(content, lineWidth: width))
    }

    /// Addd a `LinearGradient` overlayed on View
    /// - Parameters:
    ///   - colors: Colors
    ///   - start: Start, default top
    ///   - end: End, default bottom
    /// - Returns: View
    func gradientOverlay(
        colors: Color...,
        start: UnitPoint = .top,
        end: UnitPoint = .bottom) -> some View {
            overlay(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: start, endPoint: end)
            )
    }
    
    /// Addd a `LinearGradient` background on View
    /// - Parameters:
    ///   - colors: Colors
    ///   - start: Start, default top
    ///   - end: End, default bottom
    /// - Returns: View
    func gradientBackground(
        colors: Color...,
        start: UnitPoint = .top,
        end: UnitPoint = .bottom) -> some View {
            background(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: start, endPoint: end)
            )
    }
    
    /// Expand safe area on the background of the view
    /// - Parameters:
    ///   - backgroundView: view to ignore safe area
    ///   - safeAreaRegions: safe area regions
    ///   - edges: edges
    /// - Returns: View
    @available(iOS 14.0, *)
    func safeArea<Background: View>(
        withBackground backgroundView: Background,
        safeAreaRegions: SafeAreaRegions = .all,
        edges: Edge.Set = .all
    ) -> some View {
        self.background(
            backgroundView.ignoresSafeArea(
                safeAreaRegions,
                edges: edges
            )
        )
    }

    /// Set Navigation bar background color and text
    /// - Parameters:
    ///   - background: background color
    ///   - text: text color
    /// - Returns: View
    func navigationBarColors(background: UIColor, text: UIColor) -> some View {
        self.modifier(
            NavigationBarModifier(backgroundColor: background, textColor: text)
        )
    }
    
    /// Container that doesn’t leak outside the safe area, only the elements in its background
    /// - Parameters:
    ///   - alignment: alignment
    ///   - content: content
    /// - Returns: View
    func background<Content: View>(
        alignment: Alignment = .center,
        @ViewBuilder content: () -> Content
    ) -> some View {
      self.background(ZStack(alignment: alignment) { content() }, alignment: alignment)
    }
    
    /// Hide keyboard
    func hideKeyboard() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    /// Receive keyboard status updates
    /// - Parameter isVisible: is keyboard visible
    /// - Returns: View
    func keyboardState(isVisible: Binding<Bool>) -> some View {
        self.modifier(KeyboardStateModifier(isVisible))
    }
    
    /// Debug print
    /// - Parameter vars: item to print
    /// - Returns: View
    func debugPrint(_ vars: Any...) -> some View {
        for v in vars { dprint(v) }
        return self
    }
    
    /// Debug action
    /// - Parameter closure: action
    /// - Returns: View
    func debugAction(_ closure: () -> Void) -> Self {
        #if DEBUG
        closure()
        #endif
        return self
    }
    
    /// Debug visual modifier
    /// - Parameter modifier: View modifier
    /// - Returns: View
    func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
        #if DEBUG
        return modifier(self)
        #else
        return self
        #endif
    }
    
    /// Debug only border
    /// - Parameters:
    ///   - color: color
    ///   - width: width
    /// - Returns: View
    func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View {
        debugModifier {
            $0.border(color, width: width)
        }
    }

    /// Debug only background
    /// - Parameter color: color
    /// - Returns: View
    func debugBackground(_ color: Color = .red) -> some View {
        debugModifier {
            $0.background(color)
        }
    }
    
    /// Debug print view representation
    /// - Returns: Self after printing
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }

    /// Repeat View n times
    /// - Parameter value: repeat upto not including
    /// - Returns: View
    func times(_ value: UInt) -> some View {
        ForEach(0..<Int(value)) { _ in self }
    }
    
    /// Overlay View on content size
    /// - Parameter content: content size
    /// - Returns: View
    func useSize<Content: View>(of content: @autoclosure () -> Content) -> some View {
        return content().hidden().overlay(self)
    }
    
    /// Subscribe and blind ouput to View property
    /// - Parameters:
    ///   - publisher: publisher
    ///   - binding: binding
    /// - Returns: View
    func onReceive<P: Publisher>(_ publisher: P, assignTo binding: Binding<P.Output>) -> some View where P.Failure == Never {
        onReceive(publisher) { binding.wrappedValue = $0 }
    }
    
    /// Subscribe and blind optional ouput to View property
    /// - Parameters:
    ///   - publisher: publisher
    ///   - binding: binding
    /// - Returns: View
    func onReceive<P: Publisher>(_ publisher: P, assignTo binding: Binding<P.Output?>) -> some View where P.Failure == Never {
        onReceive(publisher) { binding.wrappedValue = $0 }
    }
    
    /// Get the scroll view content offset X
    /// - Parameter offsetX: Binding for offset
    /// - Returns: View
    func scrollOffsetX(_ offsetX: Binding<CGFloat>) -> some View {
        ScrollViewOffSetReaderRepresentable(offset: offsetX, isOffsetX: true) { self }
    }
    
    /// Get the scroll view content offset Y
    /// - Parameter offsetY: Binding for offset
    /// - Returns: View
    func scrollOffsetY(_ offsetY: Binding<CGFloat>) -> some View {
        ScrollViewOffSetReaderRepresentable(offset: offsetY, isOffsetX: false) { self }
    }
}
