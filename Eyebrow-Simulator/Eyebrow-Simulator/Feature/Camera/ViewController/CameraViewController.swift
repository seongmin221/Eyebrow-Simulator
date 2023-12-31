//
//  CameraViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import AVFoundation
import Combine
import UIKit

final class CameraViewController: ViewControllerType {
    
    // MARK: - Property
    
    var viewModel: CameraViewModel
    var cancelBag: Set<AnyCancellable> = Set()
    
    var baseView: CameraView = CameraView()
    
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
        self.hideNavigationBar(true)
        self.bindViewModel()
    }
    
    // MARK: - Setting
    
    func bindViewModel() {
        let input = CameraViewModel.Input(
            viewDidLoad: self.viewDidLoadPublisher,
            viewWillAppear: self.viewWillAppearPublisher,
            photoTrigger: self.baseView.shutterButtonTrigger,
            viewWillDisappear: self.viewWillDisappearPublisher
        )
        let output = self.viewModel.transform(input: input)
        
        self.viewModel.handle(input: input)
        
        output.photoPreviewLayer
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] layer in
                guard let self = self else { return }
                self.baseView.insertCameraLayer(layer: layer)
            })
            .store(in: &self.cancelBag)
        
        output.photoResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] data in
                guard let self,
                      let image = data.image,
                      let buffer = data.buffer
                else { return }
                self.pushToResult(image: image, buffer: buffer)
            })
            .store(in: &self.cancelBag)
    }
}

extension CameraViewController {
    private func pushToResult(image: CIImage, buffer: CMSampleBuffer) {
        let viewModel = CameraResultViewModel(image: image, buffer: buffer)
        let viewController = CameraResultViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
