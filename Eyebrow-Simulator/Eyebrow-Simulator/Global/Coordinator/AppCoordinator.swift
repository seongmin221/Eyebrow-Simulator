//
//  AppCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childrenCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
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
