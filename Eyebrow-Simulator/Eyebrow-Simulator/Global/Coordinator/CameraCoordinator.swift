//
//  CameraCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class CameraCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childrenCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CameraViewModel()
        let viewController = CameraViewController(viewModel)
        self.navigationController.viewControllers = [viewController]
    }
}

extension CameraCoordinator: CameraCoordinatorDelegate {
    func toCameraResult() {
        
    }
    
    
    func toCameraResult(of image: UIImage) {
        
    }
}
