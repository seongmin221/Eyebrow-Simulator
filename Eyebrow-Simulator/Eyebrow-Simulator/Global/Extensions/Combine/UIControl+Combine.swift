//
//  UIControl+Combine.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/12/23.
//

import UIKit
import Combine

extension UIControl {
<<<<<<< Updated upstream
=======
    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        return UIControl.EventPublisher(control: self, event: event)
    }
>>>>>>> Stashed changes
    
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
<<<<<<< Updated upstream
        func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(subscriber: subscriber, control: control, event: event)
=======
        func receive<S>(subscriber: S)
        where S: Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(
                control: self.control,
                subscriber: subscriber,
                event: self.event
            )
>>>>>>> Stashed changes
            subscriber.receive(subscription: subscription)
        }
    }
    
<<<<<<< Updated upstream
    fileprivate class EventSubscription<S: Subscriber>: Subscription
    where S.Input == UIControl, S.Failure == Never {
        
        private let subscriber: S?
        private let control: UIControl
        private let event: UIControl.Event
        
        init(
            subscriber: S?,
            control: UIControl,
            event: UIControl.Event
        ) {
=======
    fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription
    where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {
        
        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubscriber?
        
        init(control: UIControl, subscriber: EventSubscriber, event: UIControl.Event) {
            self.control = control
>>>>>>> Stashed changes
            self.subscriber = subscriber
            self.control = control
            self.event = event
<<<<<<< Updated upstream
            self.control.addTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        func cancel() {}
        
        @objc
        func eventDidOccur() {
=======
            
            control.addTarget(self, action: #selector(self.eventDidOccur), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            self.subscriber = nil
            self.control.removeTarget(self, action: #selector(self.eventDidOccur), for: self.event)
        }
        
        @objc func eventDidOccur() {
>>>>>>> Stashed changes
            _ = self.subscriber?.receive(self.control)
        }
    }
}
