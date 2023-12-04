//
//  SimulatorViewModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Foundation
import Combine

final class SimulatorViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private let simulatorService = MLSimulatorService()
    
    // MARK: - Input & Output
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
//        let selectedIndexPath: AnyPublisher<[IndexPath]?, Never>
    }
    
    struct Output {
        let eyebrowPosition: AnyPublisher<Result<EyebrowPositionModel, Error>, Never>
//        let selectedEyebrow: AnyPublisher<EyebrowModel, Never>
    }
    
//    struct CellInput {
//        
//    }
//    
//    struct CellOutput {
//        
//    }
    
    // MARK: - Initialize
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let eyebrowPosition = input.viewDidLoad
            .map { _ -> Result<EyebrowPositionModel, Error> in
                do {
                    return .success(.init())
                }
                catch {
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
//            .asyncMap { [weak self] _ -> Result<EyebrowPositionModel, Error> in
//                do {
//                    let position = try await self?.simulatorService.detectEyebrowPosition()
//                    return .success(position ?? .init())
//                }
//                catch let error {
//                    return .failure(error)
//                }
//            }
//            .eraseToAnyPublisher()
//        let selectedEyebrow = input.selectedIndexPath
//            .print("VM: selectedEyebrow")
//            .map { indexPaths -> EyebrowModel in
//                guard let index = indexPaths?.first?.item else { return EyebrowModel() }
//                return EyebrowModel.eyebrows[index]
//            }
//            .eraseToAnyPublisher()
        
        return Output(eyebrowPosition: eyebrowPosition)
    }
    
    // MARK: - Functions
    
}

//extension Publisher {
//    func asyncMap<T>(_ transform: @escaping (Output) async -> T)
//    -> Publishers.FlatMap<Future<T, Never>, Self> {
//        self.flatMap { value in
//            Future { promise in
//                Task {
//                    let output = await transform(value)
//                    promise(.success(output))
//                }
//            }
//        }
//    }
//    
//    func asyncMap<T>(_ transform: @escaping (Output) async throws -> T)
//    -> Publishers.FlatMap<Future<T, Error>, Self> {
//        self.flatMap { value in
//            Future { promise in
//                Task {
//                    do {
//                        let output = try await transform(value)
//                        promise(.success(output))
//                    } catch {
//                        promise(.failure(error))
//                    }
//                }
//            }
//        }
//    }
//}
