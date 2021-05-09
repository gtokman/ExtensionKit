import Combine

/// Limited Sink subscriber that only takes in a specified amount of demand
public extension Subscribers {
    typealias ReceivedCompletion<E: Error> = (Subscribers.Completion<E>) -> ()
    typealias ReceivedValue<Input> = (Input) -> ()
    
    class LimitedSink<Input, Failure>: Subscriber, Cancellable where Failure: Error {
        
        private let demand: Int
        private let receivedValue: ReceivedValue<Input>
        private var receivedCompletion: ReceivedCompletion<Failure>?
        private var subscription: Subscription?
        
        init(demand: Int, receivedValue: @escaping ReceivedValue<Input>){
            self.demand = demand
            self.receivedValue = receivedValue
        }
        
        convenience init(demand: Int, receivedCompletion: @escaping ReceivedCompletion<Failure>, receivedValue: @escaping ReceivedValue<Input>) {
            self.init(demand: demand, receivedValue: receivedValue)
            self.receivedCompletion = receivedCompletion
        }

        public func receive(subscription: Subscription) {
            // Request demand from subscription
            self.subscription = subscription
            subscription.request(.max(demand))
        }
    
        public func receive(_ input: Input) -> Subscribers.Demand {
            receivedValue(input)
            return .none
        }
    
        public func receive(completion: Subscribers.Completion<Failure>) {
            receivedCompletion?(completion)
        }
        
        public func cancel() {
            subscription?.cancel()
            subscription = nil
        }
    }
}
