import SwiftUI

public extension Binding where Value: Equatable {
    
    /**
    ```
    Toggle(
        "Foo",
        isOn: $foo.onChange {
            bar.isEnabled = $0
        }
    )
    ```
    */
    
    /// Update or run action after binding has changed
    /// - Parameter action: Action to run
    /// - Returns: Binding
    func onChange(_ action: @escaping (Value) -> Void) -> Self {
        .init(
            get: { wrappedValue },
            set: {
                let oldValue = wrappedValue
                wrappedValue = $0
                let newValue = wrappedValue
                if newValue != oldValue {
                    action(newValue)
                }
            }
        )
    }
    
}
