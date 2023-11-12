//
//  CameraCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class CameraCoordinator: CoordinatorType {
    
    var navigationController: UINavigationController
    
    weak var parentCoordinator: CoordinatorType?
    var childrenCoordinators: [CoordinatorType] = []
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    func show() {
        let viewModel = CameraViewModel()
        let viewController = CameraViewController(viewModel: viewModel)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension CameraCoordinator: CameraCoordinatorDelegate {
    
    func toCameraResultView(with image: UIImage) {
        let child = CameraResultCoordinator(navigationController: self.navigationController, image: image)
        child.parentCoordinator = self
        child.show()
        self.childrenCoordinators.append(child)
    }
}
