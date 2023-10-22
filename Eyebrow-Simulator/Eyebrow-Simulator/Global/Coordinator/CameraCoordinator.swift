//
//  CameraCoordinator.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/16/23.
//

import UIKit

final class CameraCoordinator: CoordinatorType {
    
    // MARK: - Properties
    
    weak var parentCoordinator: CoordinatorType?
    var childrenCoordinators: [CoordinatorType] = []
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() {
        let view = CameraView()
        let viewModel = CameraViewModel()
        let viewController = CameraViewController(
            coordinator: self,
            view: view,
            viewModel: viewModel
        )
        self.navigationController.pushViewController(viewController, animated: false)
    }
}

extension CameraCoordinator: CameraCoordinatorDelegate {
    
    func toCameraResultView(with image: UIImage) {
        let cameraResultCoordinator = CameraResultCoordinator(self.navigationController, image)
        cameraResultCoordinator.parentCoordinator = self
        cameraResultCoordinator.show()
    }
}
