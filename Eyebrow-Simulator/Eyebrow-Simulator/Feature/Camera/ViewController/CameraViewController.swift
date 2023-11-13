//
//  CameraViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Combine
import UIKit

protocol CameraCoordinatorDelegate: CoordinatorDelegate {
    func toCameraResultView(with image: UIImage)
}

final class CameraViewController: ViewControllerType {
    
    // MARK: - Property
    
    weak var coordinator: CameraCoordinatorDelegate?
    
    var baseView: CameraView = CameraView()
    var viewModel: CameraViewModel
    var cancelBag: Set<AnyCancellable> = Set()
    
    // MARK: - Life Cycle
    
    init(
        viewModel: CameraViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(viewModel: self.viewModel)
        self.hideNavigationBar(true)
    }
    
    // MARK: - Setting
    
    func bind(viewModel: CameraViewModel) {
        let input = CameraViewModel.Input(
            viewDidLoad: self.viewDidLoadPublisher,
            photoTrigger: self.baseView.shutterButtonTrigger
        )
        
        let output = self.viewModel.transform(input)
        
        output.photoPreviewLayer
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] layer in
                guard let self = self else { return }
                self.view.layer.insertSublayer(layer, below: self.view.layer)
                layer.frame = self.view.layer.frame
            })
            .store(in: &self.cancelBag)
        
        output.photoResult
            .receive(on: DispatchQueue.main)
            .sink { [self] photo in
                self.coordinator?.toCameraResultView(with: photo)
            }
            .store(in: &self.cancelBag)
    }
}
