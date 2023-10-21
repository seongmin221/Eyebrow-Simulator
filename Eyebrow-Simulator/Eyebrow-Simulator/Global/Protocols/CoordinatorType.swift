//
//  CoordinatorType.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

protocol CoordinatorType: AnyObject {
    
    var navigationController: UINavigationController { get }
    
    var parentCoordinator: CoordinatorType? { get set }
    var childrenCoordinators: [CoordinatorType] { get set }
    func show()
}
