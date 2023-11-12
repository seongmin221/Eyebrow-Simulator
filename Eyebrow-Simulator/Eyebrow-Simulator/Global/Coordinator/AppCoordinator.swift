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
        _ navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    func show() {
        self.toCameraView()
    }
}

// MARK: - Back to Parent Coordinator

//extension AppCoordinator {
//    
//    func backToParent(from child: CoordinatorType) {
//        for (index, coordinator) in self.childrenCoordinators.enumerated() {
//            guard coordinator === child else { continue }
//            self.childrenCoordinators.remove(at: index)
//            break
//        }
//    }
//}

// MARK: - To Child Coordinators

extension AppCoordinator {
    
    func toCameraView() {
        let child = CameraCoordinator(self.navigationController)
        child.parentCoordinator = self
        child.show()
        self.childrenCoordinators.append(child)
    }
}
