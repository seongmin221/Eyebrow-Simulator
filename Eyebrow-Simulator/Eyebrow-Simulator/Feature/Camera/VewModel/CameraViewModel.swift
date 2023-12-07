//
//  CameraViewModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import AVFoundation
import Combine
import CoreImage

final class CameraViewModel: ViewModelType {
    
    typealias PreviewLayer = AVCaptureVideoPreviewLayer
    
    // MARK: - Properties
    
    private let cameraService = CameraService()
    private var cancelBag: Set<AnyCancellable> = Set()

    // MARK: - Input & Output
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let viewWillAppear: AnyPublisher<Void, Never>
        let photoTrigger: AnyPublisher<Void, Never>
        let viewWillDisappear: AnyPublisher<Void, Never>
        
        init(viewDidLoad: AnyPublisher<Void, Never>,
             viewWillAppear: AnyPublisher<Void, Never>,
             photoTrigger: AnyPublisher<Void, Never>,
             viewWillDisappear: AnyPublisher<Void, Never>) {
            self.viewDidLoad = viewDidLoad
            self.viewWillAppear = viewWillAppear
            self.photoTrigger = photoTrigger
            self.viewWillDisappear = viewWillDisappear
        }
    }
    
    struct Output {
        let photoPreviewLayer: AnyPublisher<PreviewLayer, Never>
        let photoResult: AnyPublisher<(image: CIImage?, buffer: CMSampleBuffer?), Never>
        
        init(photoPreviewLayer: AnyPublisher<PreviewLayer, Never>,
             photoResult: AnyPublisher<(image: CIImage?, buffer: CMSampleBuffer?), Never>) {
            self.photoPreviewLayer = photoPreviewLayer
            self.photoResult = photoResult
        }
    }
    
    // MARK: - Transform
    
    func handle(input: Input) {
        input.viewDidLoad
            .print("viewDidLoad")
            .sink(receiveValue: { [weak self] in
                self?.cameraService.setupSession()
            })
            .store(in: &self.cancelBag)
        
        input.photoTrigger
            .sink(receiveValue: {
                HapticManager.buttonTapHaptic()
            })
            .store(in: &self.cancelBag)
        
        input.viewWillDisappear
            .print("viewWillDisappear")
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.cameraService.stopSession()
            })
            .store(in: &self.cancelBag)
    }
    
    func transform(input: Input) -> Output {
        let photoPreviewLayer = input.viewWillAppear
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .print("viewWillAppear")
            .map { [weak self] _ -> PreviewLayer in
                self?.cameraService.startSession()
                guard let previewLayer = self?.cameraService.configurePreviewLayer()
                else { return PreviewLayer() }
                return previewLayer
            }
            .eraseToAnyPublisher()
            
        let photoResult = input.photoTrigger
            .map { [weak self] _ -> (image: CIImage?, buffer: CMSampleBuffer?) in
                guard let self else { return (nil, nil) }
                self.cameraService.takePhoto()
                let ciImage = self.cameraService.takenPhoto
                let buffer = self.cameraService.cmBuffer
                return (ciImage, buffer)
            }
            .eraseToAnyPublisher()
        
        return Output(photoPreviewLayer: photoPreviewLayer, photoResult: photoResult)
    }
}
