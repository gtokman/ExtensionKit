import SwiftUI

/// Random circle motion animation on view
struct CircleMotionView: View {

    @State private var randomCircle = Int.random(in: 12...16)
    @State var isAnimating = false

    let circleColor: Color

    func randomCoordinate(max: CGFloat) -> CGFloat {
        CGFloat.random(in: 0...max)
    }

    var randomSize: CGFloat {
        CGFloat(Int.random(in: 10...300))
    }

    var randomScale: CGFloat {
        CGFloat(Double.random(in: 0.1...2.0))
    }

    var randomSpeed: Double {
        Double.random(in: 0.025...1.0)
    }

    var randomDelay: Double {
        Double.random(in: 0...2)
    }
    
    var animation: Animation {
        Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5)
        .repeatForever()
        .speed(randomSpeed)
        .delay(randomDelay)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0...randomCircle, id: \.self) { item in
                    Circle()
                        .foregroundColor(circleColor)
                        .opacity(0.15)
                        .frame(width: randomSize, height: randomSize, alignment: .center)
                        .scaleEffect(isAnimating ? randomScale : 1)
                        .position(
                        x: randomCoordinate(max: geometry.size.width),
                        y: randomCoordinate(max: geometry.size.height))
                        .animation(animation)
                        .onAppear(perform: {
                        isAnimating = true
                    })
                } //: LOOP
            } //: ZSTACK
            //
            .drawingGroup()
        } //: GEOMETRY
    }
}

struct CircleMotionModifier: ViewModifier {

    let isActive: Bool
    let circleColor: Color

    func body(content: Content) -> some View {
        if !isActive { return content.eraseToAnyView() }

        let view = content
            .overlay(CircleMotionView(isAnimating: isActive, circleColor: circleColor))
            .mask(content)
        return view.eraseToAnyView()
    }
}
