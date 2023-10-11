//
//  CameraViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Foundation
import Combine

final class CameraViewController: BaseViewControllerType {
    
    // MARK: - Property
    
    var viewModel: CameraViewModel
    var cancelBag: Set<AnyCancellable> = Set()
    
    // MARK: - UI Property
    
    
    
    // MARK: - Life Cycle
    
    
    
    // MARK: - Setting
    
    
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    init(_ viewModel: CameraViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(viewModel: CameraViewModel) {
        
    }
    
    
}
