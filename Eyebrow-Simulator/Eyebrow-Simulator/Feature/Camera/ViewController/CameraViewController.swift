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
    
    let cameraView = CameraView()
    
    // MARK: - Life Cycle
    
    init(_ viewModel: CameraViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.cameraView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setting
    
    func bind(viewModel: CameraViewModel) {
        
    }
}
