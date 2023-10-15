//
//  UIButton+Combine.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/12/23.
//

import UIKit
import Combine

extension UIButton {
    
    func controlPublisher(event: UIControl.Event) -> UIControl.EventPublisher {
        return .init(control: self, event: event)
    }
}
