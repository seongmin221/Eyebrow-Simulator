//
//  AppCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class AppCoordinator: CoordinatorType {
    
    // MARK: - Properties
    
    var parentCoordinator: CoordinatorType?
    var childrenCoordinators: [CoordinatorType] = []
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() {
        let cameraCoordinator = CameraCoordinator(navigationController)
        cameraCoordinator.parentCoordinator = self
        cameraCoordinator.show()
    }
}

// MARK: - Functions

extension AppCoordinator {
    
//    func presentCameraView() {
//        let view = CameraView()
//        let viewModel = CameraViewModel()
//        let viewController = CameraViewController(view, viewModel)
//        self.navigationController.pushViewController(viewController, animated: false)
//    }
}
