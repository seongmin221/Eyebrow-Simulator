//
//  CameraResultViewModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Combine
import UIKit

final class CameraResultViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private var imageResult: UIImage
    
    // MARK: - Input & Output
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let continueTrigger: AnyPublisher<Void, Never>
        let retakeTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let takenPhoto: AnyPublisher<UIImage, Never>
        let chosenPhoto: AnyPublisher<UIImage, Never>
    }
    
    // MARK: - Initialize
    
    init(image: UIImage) {
        self.imageResult = image
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let takenPhoto = input.viewDidLoad
            .map { [weak self] _ -> UIImage in
                guard let self = self else { return UIImage() }
                return self.imageResult
            }
            .eraseToAnyPublisher()
        
        let chosenPhoto = input.continueTrigger
            .map { [weak self] _ -> UIImage in
                guard let self = self else { return UIImage() }
                return self.imageResult
            }
            .eraseToAnyPublisher()
        
        return Output(takenPhoto: takenPhoto, chosenPhoto: chosenPhoto)
    }
    
    // MARK: - Functions
}
