//
//  CGPoint+.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 12/7/23.
//

import Foundation

extension CGPoint {
    func absolutePoint(in rect: CGRect) -> CGPoint {
        return CGPoint(
            x: x * rect.size.width + rect.origin.x,
            y: y * rect.size.height + rect.origin.y
        )
    }
}
