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
        
        init(
            _ viewDidLoad: AnyPublisher<Void, Never>,
            _ photoTrigger: AnyPublisher<Void, Never>) {
            self.viewDidLoad = viewDidLoad
            self.photoTrigger = photoTrigger
        }
    }
    
    struct Output {
        let photoResult: AnyPublisher<UIImage, Never>?
        
        init(_ photoResult: AnyPublisher<UIImage, Never>?) {
            self.photoResult = photoResult
        }
    }
    
    // MARK: - Initialize
    
    init() {
        
    }
    
    // MARK: - Transform
    
    func transform(_ input: Input) -> Output {
            
        return Output(nil)
    }
}
