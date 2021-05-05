import Combine
import CoreLocation

public extension CLLocationManager {
    
    /*
     /// Upgrade the user authoriztion status
     requestLocationAuthorization()
     .flatMap { status -> AnyPublisher<CLAuthorizationStatus, Never> in
         if status == CLAuthorizationStatus.authorizedAlways {
             return AuthorizationPublisher(manager: manager, authorizationType: type)
                 .eraseToAnyPublisher()
         } else {
             return Just(status)
                 .eraseToAnyPublisher()
         }
     }
     **/
    /// Request locaton authorization and subscribe to `CLAuthorizationStatus` updates
    /// - Parameters:
    ///   - manager: `CLLocationManager`
    ///   - type: `AuthorizationType`
    /// - Returns: Publisher with `AuthorizationType`
    static func requestLocationAuthorization(
        with manager: CLLocationManager = .init(),
        type: AuthorizationType
    ) -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: manager, authorizationType: type)
            .eraseToAnyPublisher()
    }

    /// Authorization access level
    enum AuthorizationType: String {
        case always, whenInUse
    }

}

protocol PublisherAuthorizationDelegate: class {
    func send(status: CLAuthorizationStatus)
}

protocol SubscriptionAuthorizationDelegate: class {
    func requestAuthorization(type: CLLocationManager.AuthorizationType)
}

final class AuthorizationSubscription <S: Subscriber>: NSObject,
    PublisherAuthorizationDelegate,
    Subscription where S.Input == CLAuthorizationStatus,
    S.Failure == Never {

    typealias Output = CLAuthorizationStatus
    typealias Failure = Never

    var subscriber: S?
    private weak var delegate: SubscriptionAuthorizationDelegate?
    private let authorizationType: CLLocationManager.AuthorizationType

    init(
        subscriber: S,
        authorizationType: CLLocationManager.AuthorizationType,
        delegate: SubscriptionAuthorizationDelegate
    ) {
        self.subscriber = subscriber
        self.delegate = delegate
        self.authorizationType = authorizationType
    }

    func request(_ demand: Subscribers.Demand) {
        delegate?.requestAuthorization(type: authorizationType)
    }

    func cancel() {
        subscriber = nil
        delegate = nil
    }
    
    func send(status: CLAuthorizationStatus) {
        _ = subscriber?.receive(status)
    }
}

final class AuthorizationPublisher: NSObject, Publisher, CLLocationManagerDelegate, SubscriptionAuthorizationDelegate {

    typealias Output = CLAuthorizationStatus
    typealias Failure = Never

    private let manager: CLLocationManager
    private let authorizationType: CLLocationManager.AuthorizationType
    private weak var publisherAuthorizationDelegate: PublisherAuthorizationDelegate?

    init(manager: CLLocationManager, authorizationType: CLLocationManager.AuthorizationType) {
        self.manager = manager
        self.authorizationType = authorizationType
    }

    func receive<S>(subscriber: S) where S: Subscriber, AuthorizationPublisher.Failure == S.Failure, AuthorizationPublisher.Output == S.Input {
        let subscription = AuthorizationSubscription(
            subscriber: subscriber,
            authorizationType: authorizationType,
            delegate: self
        )
        subscriber.receive(subscription: subscription)
        publisherAuthorizationDelegate = subscription
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        publisherAuthorizationDelegate?.send(status: status)
    }

    // MARK: - AuthorizationSubscriptionDelegate

    func requestAuthorization(type: CLLocationManager.AuthorizationType) {
        switch type {
        case .whenInUse:
            manager.requestWhenInUseAuthorization()
        case .always:
            manager.requestAlwaysAuthorization()
        }
    }
}
