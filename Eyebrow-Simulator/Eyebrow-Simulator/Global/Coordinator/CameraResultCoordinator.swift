//
//  CameraResultCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/21/23.
//

import UIKit

final class CameraResultCoordinator: CoordinatorType {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    weak var parentCoordinator: CoordinatorType?
    var childrenCoordinators: [CoordinatorType] = []
    
    // MARK: - Data
    
    private var previewImage: UIImage
    
    // MARK: - Initialize
    
    init(
        navigationController: UINavigationController,
        image: UIImage
    ) {
        self.navigationController = navigationController
        self.previewImage = image
    }
    
    func show() {
        let viewModel = CameraResultViewModel(image: self.previewImage)
        let viewController = CameraResultViewController(viewModel: viewModel)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension CameraResultCoordinator: CameraResultViewCoordinatorDelegate {
    func backToCamera() {
        self.popViewController(withAnimation: true)
//        self.parentCoordinator.
    }
    
    func toSimulator() {
        
    }
}
