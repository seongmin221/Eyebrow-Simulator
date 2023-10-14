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
        let photoPreviewLayer: AnyPublisher<CALayer, Never>
        let photoResult: AnyPublisher<UIImage, Never>
        
        init(_ photoPreviewLayer: AnyPublisher<CALayer, Never>,
             _ photoResult: AnyPublisher<UIImage, Never>) {
            self.photoPreviewLayer = photoPreviewLayer
            self.photoResult = photoResult
        }
    }
    
    
    // MARK: - Transform
    
    func transform(_ input: Input) -> Output {
        let photoPreviewLayer = input.viewDidLoad
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.cameraService.setupSession() })
            .map { [weak self] _ -> CALayer in
                guard let previewLayer = self?.cameraService.previewLayer else { return CALayer() }
                print("VM: preview layer")
                return previewLayer
            }
            .eraseToAnyPublisher()
            
        let photoResult = input.photoTrigger
            .handleEvents(receiveSubscription: { [weak self] _ in self?.cameraService.takePhoto() })
            .map { [weak self] _ -> UIImage in
                guard let ciImage = self?.cameraService.takenPhoto else { return UIImage() }
                print("VM: preview layer")
                return UIImage(ciImage: ciImage)
            }
            .eraseToAnyPublisher()
        
        return Output(photoPreviewLayer, photoResult)
    }
}
