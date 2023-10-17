//
//  CoordinatorType.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import Foundation

protocol CoordinatorType: AnyObject {
    var childrenCoordinators: [CoordinatorType] { get set }
    func show()
}
