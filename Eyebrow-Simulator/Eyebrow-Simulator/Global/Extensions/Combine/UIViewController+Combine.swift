//
//  UIViewController+.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/12/23.
//

import UIKit
import Combine

extension UIViewController {
    
    var viewDidLoadPublisher: AnyPublisher<Void, Never> {
        return Just(#selector(self.viewDidLoad))
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
    
    var viewWillAppearPublisher: AnyPublisher<Void, Never> {
        return Just(#selector(self.viewWillAppear(_:)))
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
    
    var viewIsAppearingPublisher: AnyPublisher<Void, Never> {
        return Just(#selector(self.viewIsAppearing(_:)))
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
    
    var viewDidAppearPublisher: AnyPublisher<Void, Never> {
        return Just(#selector(self.viewDidAppear(_:)))
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
    
}
