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
    
<<<<<<< Updated upstream
    init(_ viewModel: CameraViewModel) {
=======
    init(
        viewModel: CameraViewModel
    ) {
>>>>>>> Stashed changes
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
        self.bind(viewModel: self.viewModel)
        self.hideNavigationBar(true)
    }
    
    // MARK: - Setting
    
    func bind(viewModel: CameraViewModel) {
<<<<<<< Updated upstream
        let viewDidLoad = self.viewDidLoadPublisher
        let photoTrigger = self.cameraView.shutterButton
            .controlPublisher(event: .touchUpInside)
            .map { _ in Void() }
            .eraseToAnyPublisher()
=======
>>>>>>> Stashed changes
        
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
            .sink { photo in
                dump(photo)
            }
            .store(in: &self.cancelBag)
    }
}
