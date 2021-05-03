import Combine
import Foundation
import UIKit

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

extension Publisher where Failure == Never {
    
    /// Subscribe to keyboard notifications and receive `Notification.KeyboardInfo` on updates
    static var keyboardInfo: AnyPublisher<Notification.KeyboardInfo, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
                .map { $0.keyboardInfo }

        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in Notification.KeyboardInfo() }

        return Publishers.MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
    
}
