//
//  CameraResultViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import AVFoundation
import Combine
import UIKit

final class CameraResultViewController: ViewControllerType {
    
    typealias View = CameraResultView
    typealias ViewModel = CameraResultViewModel
    
    // MARK: - Property
    
    var viewModel: CameraResultViewModel
    var cancelBag: Set<AnyCancellable> = Set()
    
    var baseView = CameraResultView()
    
    // MARK: - Life Cycle
    
    init(
        viewModel: CameraResultViewModel
    ) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationBar(false)
        self.bindUI()
        self.bindViewModel()
    }
    
    // MARK: - Setting
    
    private func transformedOutput() -> ViewModel.Output {
        let input = ViewModel.Input(
            viewDidLoad: self.viewDidLoadPublisher,
            continueTrigger: self.baseView.continueButtonTrigger,
            retakeTrigger: self.baseView.retakeButtonTrigger
        )
        
        return self.viewModel.transform(input: input)
    }
    
    func bindUI() {
        self.viewDidAppearPublisher
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.baseView.animateContinueButton()
            })
            .store(in: &self.cancelBag)
    }
    
    func bindViewModel() {
        let output = transformedOutput()
        
        output.takenPhoto
            .sink(receiveValue: { [weak self] ciImage in
                guard let self = self else { return }
                let photo = UIImage(ciImage: ciImage)
                self.baseView.configurePreviewImage(with: photo)
            })
            .store(in: &self.cancelBag)
        
        output.chosenPhoto
            .sink(receiveValue: { [weak self] buffer in
                guard let self, let buffer else { return }
                self.pushToSimulator(buffer: buffer)
            })
            .store(in: &self.cancelBag)
    }
    
}

extension CameraResultViewController {
    private func pushToSimulator(buffer: CMSampleBuffer) {
        let service = SimulatorService(buffer: buffer)
        let viewModel = SimulatorViewModel(service: service)
        let viewController = SimulatorViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
