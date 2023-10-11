//
//  CameraViewModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit
import Combine

class CameraViewModel: ViewModelType {
    
    // MARK: - Properties
    
    // MARK: - Input & Output
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let photoTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let photoResult: AnyPublisher<UIImage, Never>?
    }
    
    // MARK: - Initialize
    
    init() {
        
    }
    
    // MARK: - Transform
    
    func transform(_ input: Input) -> Output {
        return Output(photoResult: nil)
    }
}

// MARK: - Functions
