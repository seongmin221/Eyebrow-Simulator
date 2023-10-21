//
//  CameraResultViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Combine
import UIKit

protocol CameraResultViewCoordinatorDelegate: CoordinatorDelegate {
    func backToCamera()
    func toSimulator()
}

final class CameraResultViewController: ViewControllerType {
    
    typealias View = CameraResultView
    typealias ViewModel = CameraResultViewModel
    
    // MARK: - Property
    
    weak var coordinator: CameraResultViewCoordinatorDelegate?
    
    var baseView: CameraResultView
    var viewModel: CameraResultViewModel
    var cancelBag: Set<AnyCancellable> = Set()
    
    // MARK: - Life Cycle
    
    init(
        _ baseView: CameraResultView,
        _ viewModel: CameraResultViewModel
    ) {
        self.baseView = baseView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = baseView
    }
    
    // MARK: - Setting
    
    func bind(viewModel: CameraResultViewModel) {}
    
}
