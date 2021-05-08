import Combine
import Foundation
import UIKit

// MARK: - Public

public extension Publisher {
    
    /// Debug print Publisher events
    /// - Parameters:
    ///   - prefix: Prefix on print statement
    ///   - function: Function name
    ///   - line: Line number
    /// - Returns: Publisher
    func debug(
        prefix: String = "",
        function: String = #function,
        line: Int = #line) -> Publishers.HandleEvents<Self> {
        let pattern = "\(prefix + (prefix.isEmpty ? "" : " "))\(function), line \(line): "

        return handleEvents(receiveSubscription: {
            dprint("\(pattern)subscription \($0)")
        }, receiveOutput: {
            dprint("\(pattern)output \($0)")
        }, receiveCompletion: {
            dprint("\(pattern)completion \($0)")
        }, receiveCancel: {
            dprint("\(pattern)cancelled")
        }, receiveRequest: {
            dprint("\(pattern)request \($0)")
        })
    }
    
}

public extension Publisher where Failure == Never {

    /// Receive Output value on main thread  (DispatchQueue.main)
    func receiveOnMain() -> Publishers.ReceiveOn<Self, DispatchQueue> {
        self.receive(on: DispatchQueue.main)
    }

    /// A single value sink function outputs a `Result`
    /// - Parameter result: Result<Output, Failure>
    /// - Returns: AnyCancellable
    func sink(result: @escaping ((Result<Self.Output, Self.Failure>) -> Void)) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                result(.failure(error))
            case .finished: break
            }
        }, receiveValue: { output in
            result(.success(output))
        })
    }

    /// Assign property to object without using [weak self]
    /// - Parameters:
    ///   - keyPath: Property keypath
    ///   - root: Any object
    /// - Returns: AnyCancellable
    func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
        sink { [weak root] in
            root?[keyPath: keyPath] = $0
        }
    }

}
