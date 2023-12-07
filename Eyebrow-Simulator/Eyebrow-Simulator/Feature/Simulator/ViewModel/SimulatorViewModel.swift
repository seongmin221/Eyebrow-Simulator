//
//  SimulatorViewModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import AVFoundation
import Combine
import CoreImage
import Foundation

final class SimulatorViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private var cancelBag: Set<AnyCancellable> = Set()
    
    private let simulatorService: SimulatorService
    
    private var previewImageBox = CGRect(
        x: 0,
        y: SizeLiteral.Screen.height/2 - SizeLiteral.Screen.width * 2/3,
        width: SizeLiteral.Screen.width,
        height: SizeLiteral.Screen.width * 4/3
    )
    
    private var boundingBox = CGRect()
    
    // MARK: - Input & Output
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let viewWillAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let originImage: AnyPublisher<CIImage, Never>
        let faceViewSize: AnyPublisher<CGRect, Never>
        let leftEyebrowBox: AnyPublisher<[CGPoint], Never>
        let rightEyebrowBox: AnyPublisher<[CGPoint], Never>
    }
    
    // MARK: - Initialize
    
    init(service: SimulatorService) {
        self.simulatorService = service
    }
    
    // MARK: - Transform
    
    func handle(input: Input) {
        input.viewDidLoad
            .sink(receiveValue: { [weak self] in
                guard let self,
                      let box = self.simulatorService.faceBoundingBox
                else { return }
                self.boundingBox = convertSize(box: box, in: previewImageBox)
            })
            .store(in: &self.cancelBag)
    }
    
    func transform(input: Input) -> Output {
        self.handle(input: input)
        
        let originImage = input.viewWillAppear
            .map { [weak self] _ -> CIImage in
                guard let self else { return CIImage() }
                return self.simulatorService.extractCIImage()
            }
            .eraseToAnyPublisher()
        
        let faceViewSize = input.viewWillAppear
            .map { [weak self] _ -> CGRect in
                guard let self else { return CGRect() }
                return self.boundingBox
            }
            .eraseToAnyPublisher()
        
        let leftEyebrowPos = input.viewWillAppear
            .map { [weak self] _ -> [CGPoint] in
                guard let self,
                      let eyebrowPoints = self.simulatorService.eyebrowPos?.left
                else { return [] }
                return eyebrowPoints
            }
            .eraseToAnyPublisher()
        
        let rightEyebrowPos = input.viewWillAppear
            .map { [weak self] _ -> [CGPoint] in
                guard let self,
                      let eyebrowPoints = self.simulatorService.eyebrowPos?.right
                else { return [] }
                return eyebrowPoints
            }
            .eraseToAnyPublisher()
        
        let output = Output(
            originImage: originImage,
            faceViewSize: faceViewSize,
            leftEyebrowBox: leftEyebrowPos,
            rightEyebrowBox: rightEyebrowPos
        )
        
        return output
    }
    
    // MARK: - Functions
    
}

extension SimulatorViewModel {
    func convertSize(box: CGRect, in rect: CGRect) -> CGRect {
        let convertedOrigin = box.origin.absolutePoint(in: rect)
        let convertedSize = CGSize(
            width: rect.width * box.width,
            height: rect.height * box.height
        )
        return CGRect(origin: convertedOrigin, size: convertedSize)
    }
}


extension CGPoint {
    func absolutePoint(in rect: CGRect) -> CGPoint {
        return CGPoint(
            x: x * rect.size.width + rect.origin.x,
            y: y * rect.size.height + rect.origin.y
        )
    }
}
