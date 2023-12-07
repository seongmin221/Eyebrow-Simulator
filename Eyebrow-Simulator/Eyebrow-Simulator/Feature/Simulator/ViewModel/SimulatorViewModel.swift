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
import Vision

final class SimulatorViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private var cancelBag: Set<AnyCancellable> = Set()
    
    private let simulatorService: SimulatorService
    
    private var previewImageRect = CGRect(
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
        let leftEyebrowBox: AnyPublisher<CGRect, Never>
        let rightEyebrowBox: AnyPublisher<CGRect, Never>
//        let leftEyebrowBox: AnyPublisher<[CGPoint], Never>
//        let rightEyebrowBox: AnyPublisher<[CGPoint], Never>
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
                self.boundingBox = convertSize(box: box, in: previewImageRect)
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
            .map { [weak self] _ -> CGRect in
                guard let self,
                      let eyebrowPoints = self.simulatorService.eyebrowPos?.right
                else { return CGRect() }
                
                let convertedPoints = convertNormalizedPoints(eyebrowPoints)
                return convertPointsToRect(convertedPoints)
            }
            .eraseToAnyPublisher()
        
        let rightEyebrowPos = input.viewWillAppear
            .map { [weak self] _ -> CGRect in
                guard let self,
                      let eyebrowPoints = self.simulatorService.eyebrowPos?.left
                else { return CGRect() }
                let convertedPoints = convertNormalizedPoints(eyebrowPoints)
                return convertPointsToRect(convertedPoints)
            }
            .eraseToAnyPublisher()
        
//        let leftEyebrowPos = input.viewWillAppear
//            .map { [weak self] _ -> [CGPoint] in
//                guard let self,
//                      let eyebrowPoints = self.simulatorService.eyebrowPos?.left
//                else { return [] }
//                
//                let convertedPoints = convertNormalizedPoints(eyebrowPoints)
//                return convertedPoints
//            }
//            .eraseToAnyPublisher()
//        
//        let rightEyebrowPos = input.viewWillAppear
//            .map { [weak self] _ -> [CGPoint] in
//                guard let self,
//                      let eyebrowPoints = self.simulatorService.eyebrowPos?.right
//                else { return [] }
//                
//                let convertedPoints = convertNormalizedPoints(eyebrowPoints)
//                return convertedPoints
//            }
//            .eraseToAnyPublisher()
        
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
    
    func convertNormalizedPoints(_ points: [CGPoint]) -> [CGPoint] {
        let convertedPoints = points
            .map {
                let width = Int(self.boundingBox.width)
                let height = Int(self.boundingBox.height)
                return VNImagePointForNormalizedPoint($0, width, height)
            }
            .map {
                let origin = boundingBox.origin
                return CGPoint(x: $0.x + origin.x, y: $0.y + origin.y)
            }
        
        return convertedPoints
    }
    
    func convertPointsToRect(_ points: [CGPoint]) -> CGRect {
        let minX = points.map({ $0.x }).min()!
        let maxX = points.map({ $0.x }).max()!
        let minY = points.map({ $0.y }).min()!
        let maxY = points.map({ $0.y }).max()!
        return CGRect(x: minX, y: minY, width: maxX-minX, height: maxY-minY)
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
