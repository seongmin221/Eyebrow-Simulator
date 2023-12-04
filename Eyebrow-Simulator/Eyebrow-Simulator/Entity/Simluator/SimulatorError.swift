//
//  SimulatorError.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 12/1/23.
//

import Foundation

enum SimulatorError: LocalizedError {
    case failDetection
    case noDetection
}

extension SimulatorError {
    var description: String {
        switch self {
        case .failDetection: return "ML Model: failed detection"
        case .noDetection: return "ML Model: there aren't any detected eyebrows"
        }
    }
}
