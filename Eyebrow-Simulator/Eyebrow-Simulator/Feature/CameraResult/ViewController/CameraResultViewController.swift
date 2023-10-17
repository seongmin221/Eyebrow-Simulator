//
//  CameraResultViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Combine
import UIKit

final class CameraResultViewController: BaseViewControllerType {
    
    
    // MARK: - Property
    
    var baseView: CameraResultView
    
    var viewModel: CameraResultViewModel
    var cancelBag: Set<AnyCancellable> = Set()
    
    // MARK: - Life Cycle
    
    init(
        _ view: CameraResultView,
        _ viewModel: CameraResultViewModel
    ) {
        self.baseView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    func bind(viewModel: CameraResultViewModel) {
        
    }
}
