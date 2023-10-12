//
//  UIControl+Combine.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/12/23.
//

import UIKit
import Combine

extension UIControl {
    
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(subscriber: subscriber, control: control, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
    
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
            self.subscriber = subscriber
            self.control = control
            self.event = event
            self.control.addTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        func cancel() {}
        
        @objc
        func eventDidOccur() {
            _ = self.subscriber?.receive(self.control)
        }
    }
}
