import Combine
import CoreLocation

protocol PublisherLocationDelegate: class {
    func startLocationUpdates()
}

protocol SubscriptionLocationDelegate: class {
    func didUpdate(with locations: [CLLocation])
    func didFail(with error: Error)
}

final class LocationSubscription <S: Subscriber>:
    NSObject,
    SubscriptionLocationDelegate,
    Subscription where S.Input == [CLLocation],
                       S.Failure == Error {

    var subscriber: S?
    private var publisherDelegate: PublisherLocationDelegate?
    
    init(subscriber: S?, delegate: PublisherLocationDelegate?) {
        self.subscriber = subscriber
        self.publisherDelegate = delegate
    }

    func didUpdate(with locations: [CLLocation]) {
        _ = subscriber?.receive(locations)
    }
    
    func didFail(with error: Error) {
        _ = subscriber?.receive(completion: .failure(error))
    }
    
    func request(_ demand: Subscribers.Demand) {
        publisherDelegate?.startLocationUpdates()
    }
    
    func cancel() {
        subscriber = nil
        publisherDelegate = nil
    }
    
}

final class LocationPublisher: NSObject,
                               Publisher,
                               CLLocationManagerDelegate,
                               PublisherLocationDelegate {
    typealias Output = [CLLocation]
    typealias Failure = Error
    
    private let manager: CLLocationManager
    private var subscriberDelegate: SubscriptionLocationDelegate?
    
    init(manager: CLLocationManager) {
        self.manager = manager
        super.init()
        self.manager.delegate = self
    }
    
    // MARK: Publisher
    
    func receive<S>(subscriber: S) where S : Subscriber, LocationPublisher.Failure == S.Failure, LocationPublisher.Output == S.Input {
        let subscibtion = LocationSubscription(
            subscriber: subscriber,
            delegate: self
        )
        subscriber.receive(subscription: subscibtion)
        subscriberDelegate = subscibtion
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        subscriberDelegate?.didFail(with: error)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        subscriberDelegate?.didUpdate(with: locations)
    }
    
    // MARK: PublisherLocationDelegate
    
    func startLocationUpdates() {
        manager.startUpdatingLocation()
    }
}


