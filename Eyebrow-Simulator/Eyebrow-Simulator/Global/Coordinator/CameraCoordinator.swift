//
//  CameraCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class CameraCoordinator: CoordinatorType {
    
    // MARK: - Properties
    
    var parentCoordinator: CoordinatorType?
    var childrenCoordinators: [CoordinatorType] = []
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() {
        let view = CameraView()
        let viewModel = CameraViewModel()
        let viewController = CameraViewController(view, viewModel)
        viewController.coordinator = self
        self.navigationController.viewControllers = [viewController]
    }
}

extension CameraCoordinator: CameraCoordinatorDelegate {
    func toCameraResultView(with image: UIImage) {
        let childCoordinator = CameraResultCoordinator(self.navigationController, image)
        self.childrenCoordinators.append(childCoordinator)
        childCoordinator.show()
    }
}
