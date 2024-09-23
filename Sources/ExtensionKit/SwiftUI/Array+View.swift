import SwiftUI


extension Array: @retroactive View where Element: View {
    
    /*
     ```
     struct SwiftUIView: View {
         let array = ["hello", "world"]

         var body: some View {
             VStack {
                 array.map(Text.init)
             }
         }
     }
     ```
     */
    /// Add View conformance to Array where element is View
    public var body: some View {
        ForEach(indices, id: \.self) { self[$0] }
    }
    
}
