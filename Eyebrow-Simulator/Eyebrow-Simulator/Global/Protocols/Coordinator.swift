//
//  Coordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import Foundation

protocol Coordinator: AnyObject {
    var childrenCoordinators: [Coordinator] { get set }
    func start()
}
