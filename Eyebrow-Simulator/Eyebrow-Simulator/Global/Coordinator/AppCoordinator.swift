//
//  AppCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class AppCoordinator: CoordinatorType {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    var parentCoordinator: CoordinatorType?
    var childrenCoordinators: [CoordinatorType] = []
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    func show() {
        self.toCameraView()
    }
}

extension AppCoordinator {
    
    func addChild(_ child: CoordinatorType) {
        self.childrenCoordinators.append(child)
    }
    
    func removeChild(_ child: CoordinatorType) {
        for (index, coordinator) in self.childrenCoordinators.enumerated() {
            if coordinator === child {
                self.childrenCoordinators.remove(at: index)
            }
        }
    }
}

// MARK: - To Child Coordinators

extension AppCoordinator {
    
    func toCameraView() {
        let child = CameraCoordinator(navigationController: self.navigationController)
        child.parentCoordinator = self
        child.show()
        self.addChild(child)
    }
}
