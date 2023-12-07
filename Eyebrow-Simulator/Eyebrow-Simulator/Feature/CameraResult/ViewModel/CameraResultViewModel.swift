//
//  CameraResultViewModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import AVFoundation
import Combine
import CoreImage

final class CameraResultViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private var imageResult: CIImage
    private var imageBuffer: CMSampleBuffer
    
    // MARK: - Input & Output
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let continueTrigger: AnyPublisher<Void, Never>
        let retakeTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let takenPhoto: AnyPublisher<CIImage, Never>
        let chosenPhoto: AnyPublisher<CMSampleBuffer?, Never>
    }
    
    // MARK: - Initialize
    
    init(image: CIImage, buffer: CMSampleBuffer) {
        self.imageResult = image
        self.imageBuffer = buffer
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let takenPhoto = input.viewDidLoad
            .map { [weak self] _ -> CIImage in
                guard let self = self else { return CIImage() }
                return self.imageResult
            }
            .eraseToAnyPublisher()
        
        let chosenPhoto = input.continueTrigger
            .map { [weak self] _ -> CMSampleBuffer? in
                guard let self = self else { return nil }
                return self.imageBuffer
            }
            .eraseToAnyPublisher()
        
        return Output(takenPhoto: takenPhoto, chosenPhoto: chosenPhoto)
    }
    
    // MARK: - Functions
}
