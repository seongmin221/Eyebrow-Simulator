//
//  AppCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class AppCoordinator: CoordinatorType {
    
    // MARK: - Properties
    
    var childrenCoordinators: [CoordinatorType] = []
    private var navigationController: UINavigationController!
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() {
        self.showCameraView()
    }
}

// MARK: - Functions

extension AppCoordinator {
    
    func showCameraView() {
        let view = CameraView()
        let viewModel = CameraViewModel()
        let viewController = CameraViewController(view, viewModel)
        self.navigationController.pushViewController(viewController, animated: false)
    }
}
