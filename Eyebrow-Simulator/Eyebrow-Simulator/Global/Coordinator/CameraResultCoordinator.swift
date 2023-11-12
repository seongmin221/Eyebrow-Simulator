//
//  CameraResultCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/21/23.
//

import UIKit

final class CameraResultCoordinator: CoordinatorType {
    
    var navigationController: UINavigationController
    
    weak var parentCoordinator: CoordinatorType?
    var childrenCoordinators: [CoordinatorType] = []
    
    private var previewImage: UIImage
    
    init(
        _ navigationController: UINavigationController,
        _ image: UIImage
    ) {
        self.navigationController = navigationController
        self.previewImage = image
    }
    
    func show() {
        let view = CameraResultView(previewImage: self.previewImage)
        let viewModel = CameraResultViewModel()
        let viewController = CameraResultViewController(view: view, viewModel: viewModel)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension CameraResultCoordinator: CameraResultViewCoordinatorDelegate {
    func backToCamera() {
        
    }
    
    func toSimulator() {
        
    }
}
