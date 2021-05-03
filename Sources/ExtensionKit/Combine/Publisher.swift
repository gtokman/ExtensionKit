import Combine
import Foundation

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
}
