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
        self.bind(viewModel: self.viewModel)
    }
    
    // MARK: - Setting
    
//    func bind() {
//        let viewDidLoad = self.viewDidLoadPublisher
//        let photoTrigger = self.cameraView.shutterButton
//            .controlPublisher(event: .touchUpInside)
//            .map { _ in Void() }
//            .eraseToAnyPublisher()
//        
//        let input = CameraViewModel.Input(viewDidLoad, photoTrigger)
//        let output = self.viewModel.transform(input)
//        
//        output.photoResult?
//            .sink(receiveValue: { [weak self] image in
//                guard let self = self else { return }
//                self.cameraView.previewView.image = image
//            }).store(in: &cancelBag)
//    }
    
    func bind(viewModel: CameraViewModel) {
        let viewDidLoad = self.viewDidLoadPublisher
        let photoTrigger = self.cameraView.shutterButton
            .controlPublisher(event: .touchUpInside)
            .map { _ in Void() }
            .eraseToAnyPublisher()
        
        let input = CameraViewModel.Input(viewDidLoad, photoTrigger)
        let output = self.viewModel.transform(input)
        
        output.photoResult?
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                guard let self = self else { return }
                self.cameraView.previewView.image = image
            }).store(in: &cancelBag)
    }
}
