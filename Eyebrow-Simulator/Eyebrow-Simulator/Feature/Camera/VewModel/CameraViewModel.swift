//
//  CameraViewModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import AVFoundation
import Combine
import UIKit

final class CameraViewModel: ViewModelType {
    
    typealias PreviewLayer = AVCaptureVideoPreviewLayer
    
    // MARK: - Properties
    
    private let cameraService = CameraService()

    // MARK: - Input & Output
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let photoTrigger: AnyPublisher<Void, Never>
        
        init(
            _ viewDidLoad: AnyPublisher<Void, Never>,
            _ photoTrigger: AnyPublisher<Void, Never>) {
            self.viewDidLoad = viewDidLoad
            self.photoTrigger = photoTrigger
        }
    }
    
    struct Output {
        let photoPreviewLayer: AnyPublisher<PreviewLayer, Never>
        let photoResult: AnyPublisher<UIImage, Never>
        
        init(_ photoPreviewLayer: AnyPublisher<PreviewLayer, Never>,
             _ photoResult: AnyPublisher<UIImage, Never>) {
            self.photoPreviewLayer = photoPreviewLayer
            self.photoResult = photoResult
        }
    }
    
    
    // MARK: - Transform
    
    func transform(_ input: Input) -> Output {
        let photoPreviewLayer = input.viewDidLoad
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .map { [weak self] _ -> PreviewLayer in
                self?.cameraService.setupSession()
                self?.cameraService.startSession()
                guard let previewLayer = self?.cameraService.configurePreviewLayer()
                else { return PreviewLayer() }
                return previewLayer
            }
            .eraseToAnyPublisher()
            
        let photoResult = input.photoTrigger
            .map { [weak self] _ -> UIImage in
                self?.cameraService.takePhoto()
                guard let ciImage = self?.cameraService.takenPhoto else { return UIImage() }
                return UIImage(ciImage: ciImage)
            }
            .eraseToAnyPublisher()
        
        return Output(photoPreviewLayer, photoResult)
    }
}
