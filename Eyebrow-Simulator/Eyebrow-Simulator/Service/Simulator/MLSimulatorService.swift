//
//  SimulatorService.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/11/23.
//

import Foundation

final class SimulatorService {
    private var selectedEyebrow: EyebrowModel?
    private var eyebrowPos: EyebrowPositionModel
    
    init(
        selectedEyebrow: EyebrowModel? = nil,
        eyebrowPos: EyebrowPositionModel
    ) {
        self.selectedEyebrow = selectedEyebrow
        self.eyebrowPos = eyebrowPos
    }
}


