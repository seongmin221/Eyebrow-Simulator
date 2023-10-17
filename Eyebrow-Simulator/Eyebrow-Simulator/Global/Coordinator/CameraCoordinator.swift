//
//  CameraCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class CameraCoordinator: CoordinatorType {
    
    // MARK: - Properties
    
    var childrenCoordinators: [CoordinatorType] = []
    private var navigationController: UINavigationController!
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() {
        let view = CameraView()
        let viewModel = CameraViewModel()
        let viewController = CameraViewController(view, viewModel)
        
        self.navigationController.viewControllers = [viewController]
    }
}

extension CameraCoordinator: CameraCoordinatorDelegate {
    func toCameraResult(with image: UIImage) {
        let view = CameraResultView(previewImage: image)
        let viewModel = CameraResultViewModel()
        let viewController = CameraResultViewController(view, viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
