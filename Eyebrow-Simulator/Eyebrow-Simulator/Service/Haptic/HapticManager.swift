//
//  HapticService.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 11/30/23.
//

import UIKit

final class HapticManager {
    
    static func buttonTapHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
