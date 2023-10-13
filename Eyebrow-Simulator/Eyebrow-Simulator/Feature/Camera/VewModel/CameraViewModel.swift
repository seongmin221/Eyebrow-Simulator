//
//  CameraViewModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit
import Combine

<<<<<<< Updated upstream
class CameraViewModel {
    
    // MARK: - Properties
    
    let cameraService = CameraService()
    
=======
class CameraViewModel: ViewModelType {
    
    // MARK: - Properties
    
>>>>>>> Stashed changes
    // MARK: - Input & Output
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let photoTrigger: AnyPublisher<Void, Never>
<<<<<<< Updated upstream
        
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
    
    // MARK: - Life Cycle
=======
    }
    
    struct Output {
        let photoResult: AnyPublisher<UIImage, Never>
    }
    
    // MARK: - Initialize
>>>>>>> Stashed changes
    
    init() {
        
    }
    
    // MARK: - Transform
    
    func transform(_ input: Input) -> Output {
<<<<<<< Updated upstream
//        _ = input.viewDidLoad
//            .map { [weak self] _ in
//                guard let self = self else { return }
//                Task { await self.cameraService.startSession() }
//            }
//        
//        let photoResult = input.photoTrigger
//            .map {
//                self.cameraService.takePhoto()
//            }
//            .map {
//                guard let ciImage = self.cameraService.previewImage
//                else { return UIImage() }
//                return UIImage(ciImage: ciImage)
//            }
//            .eraseToAnyPublisher()
            
        return Output(nil)
    }
}
=======
        
    }
}

// MARK: - Functions
>>>>>>> Stashed changes
