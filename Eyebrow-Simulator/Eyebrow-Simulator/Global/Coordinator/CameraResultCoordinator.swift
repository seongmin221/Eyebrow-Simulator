//
//  CameraResultCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/21/23.
//

import UIKit

final class CameraResultCoordinator: CoordinatorType {
    
    weak var parentCoordinator: CoordinatorType?
    var childrenCoordinators: [CoordinatorType] = []
    
    var navigationController: UINavigationController
    
    private let resultImage: UIImage
    
    init(
        _ navigationController: UINavigationController,
        _ resultImage: UIImage
    ) {
        self.navigationController = navigationController
        self.resultImage = resultImage
    }
    
    func show() {
        let view = CameraResultView(previewImage: self.resultImage)
        let viewModel = CameraResultViewModel()
        let viewController = CameraResultViewController(
            coordinator: self,
            view: view,
            viewModel: viewModel
        )
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
